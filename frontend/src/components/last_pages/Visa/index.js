import React, { useState, useEffect, Fragment } from "react";
import { useNavigate } from "react-router-dom"; // For navigation after clicking "Yes"
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../../CoreComponent/Input";
import ImageUpload from "../../../CoreComponent/ImageUpload"; // Importing ImageUpload component
import DateInput from "../../../CoreComponent/Date"; // Importing DateInput component
import "./style.scss"; // Importing Sass file for styling
import httpService from "../../../common/httpService";
import { getFromLocalStorage } from "../../../common/localStorage";
import SimpleLabelValue from "../../SimpleLabelValue";

const VisaPage = () => {
  const navigate = useNavigate(); // For navigation later
  const [showVisaForm, setShowVisaForm] = useState(false); // Control the display of the form
  const [passportImage, setPassportImage] = useState(null);
  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [error, setError] = useState("");
  const [visaPrice, setVisaPrice] = useState(0); // Changed initial state to null to check for data

  const [visaData, setVisaData] = useState(null); // Changed initial state to null to check for data
  const userId = localStorage.getItem("user_id");
  const conferenceId = getFromLocalStorage("myConferencesId");
  const handleUserChoice = (choice) => {
    if (choice === "yes") {
      setShowVisaForm(true); // Show the visa form if "Yes" is chosen
    } else {
      setShowVisaForm(false); // Close the form if "No" is chosen
    }
  };

  async function getConferenceById(conferenceId) {
    const url = `http://localhost:8000/api/con/id/${conferenceId}`;

    try {
      const response = await axios.get(url);
      console.log("Conference data retrieved successfully:", response.data);
      // console.log(response.data.visa_price);
      setVisaPrice(response.data.visa_price);

      return response.data;
    } catch (error) {
      console.error(
        "Error fetching conference data:",
        error.response ? error.response.data : error.message
      );
      throw error; // Optionally rethrow the error for further handling
    }
  }
  useEffect(() => {
    getConferenceById(conferenceId);
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const token = localStorage.getItem("token"); // Retrieve token from local storage

    const formData = new FormData();
    formData.append("user_id", userId);
    formData.append("passport_image", passportImage); // Ensure passportImage is a file
    formData.append("arrival_date", arrivalDate);
    formData.append("departure_date", departureDate);

    try {
      const response = await axios.post(
        `http://127.0.0.1:8000/api/visa`,
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${token}`, // Pass token in header
          },
        }
      );

      toast.success("The Data updated Successfully"); // Show success message

      // Fetch updated visa data after successful submission
      await fetchVisaData(); // <-- Add this line to fetch updated data
    } catch (error) {
      if (error.response) {
        setError(error.response.data.message || "An error occurred");
      } else {
        setError("An error occurred");
      }
    }
  };

  const fetchVisaData = async () => {
    const token = localStorage.getItem("token"); // Retrieve the token

    try {
      const data = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/visa`,
        headers: {
          Authorization: `Bearer ${token}`, // Pass the token
        },
        onSuccess: (response) => setVisaData(response),
        onError: (err) => setError(err),
        withToast: true, // Show toast
      });
      setVisaData(data.visa);

      // Set fields based on the data
      if (data.visa) {
        setArrivalDate(data.arrival_date);

        setDepartureDate(data.departure_date);
        setShowVisaForm(false); // Hide the form if there is data
      } else {
        setShowVisaForm(false); // Hide the form if there is no data
      }
    } catch (error) {
      setError("Error fetching visa data.");
    }
  };

  // Call the function to fetch visa data on component mount
  useEffect(() => {
    fetchVisaData();
  }, []);

  return (
    <div className="visa-page-container">
      {!visaData &&
        !showVisaForm && ( // Show the question only if there is no data and the form is closed
          <div className="question-container">
            <h2>
              Would you like the organizing company to handle the visa for you?
            </h2>
            <div className="button-group">
              <button
                className="yes-btn"
                onClick={() => handleUserChoice("yes")}
              >
                Yes
              </button>
              <button className="no-btn" onClick={() => handleUserChoice("no")}>
                No
              </button>
            </div>
          </div>
        )}

      {showVisaForm && ( // Show the form only if "Yes" was chosen
        <form onSubmit={handleSubmit} className="visa-form">
          <div className="fields-container">
            <div>The Visa Price Is {visaPrice} $</div>
            <ImageUpload
              label="Upload Passport Image"
              inputValue={passportImage}
              setInputValue={setPassportImage}
              allowedExtensions={["jpg", "jpeg", "png", "pdf"]}
              required
            />

            <DateInput
              label="Arrival Date"
              placeholder="YYYY-MM-DD"
              inputValue={arrivalDate}
              setInputValue={setArrivalDate}
              required
            />

            <DateInput
              label="Departure Date"
              placeholder="YYYY-MM-DD"
              inputValue={departureDate}
              setInputValue={setDepartureDate}
              required
            />
          </div>
          <button type="submit" className="submit-btn">
            Submit
          </button>
        </form>
      )}

      {visaData && (
        <Fragment>
          <h2>Visa Information</h2>

          <div className="visa-info">
            {visaData.arrival_date && (
              <SimpleLabelValue
                label="Arrival Date"
                value={visaData.arrival_date}
              />
            )}
            {visaData.departure_date && (
              <SimpleLabelValue
                label="Departure Date"
                value={visaData.departure_date}
              />
            )}
            <SimpleLabelValue label="Status" value={visaData.status} />
            <SimpleLabelValue label="Visa Cost" value={visaData.visa_cost} />

            {visaData.updated_at_by_admin && (
              <SimpleLabelValue
                label="Last Updated by Admin"
                value={visaData.updated_at_by_admin}
              />
            )}
            <p>You cannot apply for another visa.</p>
          </div>
        </Fragment>
      )}
    </div>
  );
};

export default VisaPage;
