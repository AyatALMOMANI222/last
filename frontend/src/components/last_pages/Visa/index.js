import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom"; // For navigation after clicking "Yes"
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../../CoreComponent/Input";
import ImageUpload from "../../../CoreComponent/ImageUpload"; // Importing ImageUpload component
import DateInput from "../../../CoreComponent/Date"; // Importing DateInput component
import "./style.scss"; // Importing Sass file for styling
import httpService from "../../../common/httpService";

const VisaPage = () => {
  const navigate = useNavigate(); // For navigation later
  const [showVisaForm, setShowVisaForm] = useState(false); // Control the display of the form
  const [passportImage, setPassportImage] = useState(null);
  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [error, setError] = useState("");
  const [visaData, setVisaData] = useState(null); // Changed initial state to null to check for data
  const [visaPrice, setVisaPrice] = useState(null); // Changed initial state to null to check for data

  const userId = localStorage.getItem("user_id");

  const handleUserChoice = (choice) => {
    if (choice === "yes") {
      setShowVisaForm(true); // Show the visa form if "Yes" is chosen
    } else {
      setShowVisaForm(false); // Close the form if "No" is chosen
    }
  };

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

        toast.success(response.data.message); // Show success message

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


//   const fetchVisaPrice = async () => {
//     const token = localStorage.getItem("token"); // Retrieve the token

//     try {
//       const data = await httpService({
//         method: "GET",
//         url: `http://127.0.0.1:8000/api/con/id/95`,
//         headers: {
//           Authorization: `Bearer ${token}`, // Pass the token
//         },
//         onSuccess: (response) => setVisaData(response),
//         onError: (err) => setError(err),
//         withToast: true, // Show toast
//       });
//       setVisaPrice(data.VisaPrice);
// console.log(data.VisaPrice);
// console.log(visaPrice);

//       // Set fields based on the data
//       if (data.visa) {
//         setArrivalDate(data.arrival_date);
//         setDepartureDate(data.departure_date);
//         setShowVisaForm(false); // Hide the form if there is data
//       } else {
//         setShowVisaForm(false); // Hide the form if there is no data
//       }
//     } catch (error) {
//       setError("Error fetching visa data.");
//     }
//   };

  // Call the function to fetch visa data on component mount
  useEffect(() => {
    fetchVisaData();
  }, []);

  return (
    <div className="visa-page-container">
      {!visaData && !showVisaForm && ( // Show the question only if there is no data and the form is closed
        <div className="question-container">
          <h2>Would you like the organizing company to handle the visa for you?</h2>
          <div className="button-group">
            <button className="yes-btn" onClick={() => handleUserChoice("yes")}>Yes</button>
            <button className="no-btn" onClick={() => handleUserChoice("no")}>No</button>
          </div>
        </div>
      )}

      {showVisaForm && ( // Show the form only if "Yes" was chosen
        <form onSubmit={handleSubmit} className="visa-form">
          <div className="fields-container">
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

      {visaData && ( // Show visa information if visaData is available
        <div className="visa-info">
          <h2>Visa Information</h2>
          {visaData.arrival_date && (
            <p>
              <strong>Arrival Date:</strong> {visaData.arrival_date}
            </p>
          )}
          {visaData.departure_date && (
            <p>
              <strong>Departure Date:</strong> {visaData.departure_date}
            </p>
          )}
          <p>
            <strong>Status:</strong> {visaData.status}
          </p>
          <p>
            <strong>Visa Cost:</strong> {visaData.visa_cost}
          </p>
          {/* <p>
            <strong>Payment Required:</strong>{" "}
            {visaData.payment_required ? "Yes" : "No"}
          </p> */}
          {visaData.updated_at_by_admin && (
            <p>
              <strong>Last Updated by Admin:</strong>{" "}
              {visaData.updated_at_by_admin}
            </p>
          )}
          <p>You cannot apply for another visa.</p>
        </div>
      )}
    </div>
  );

};

export default VisaPage;
