import React, { Fragment, useEffect, useState } from "react";
import Input from "../../CoreComponent/Input/index";
import Checkbox from "../../CoreComponent/Checkbox/index";
import DateInput from "../../CoreComponent/Date/index";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import axios from "axios";
import "./style.scss";
import { toast } from "react-toastify";

import ImageUpload from "../../CoreComponent/ImageUpload";

const MainFlightForm = ({ setOpenForm, getFlightData }) => {
  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [passportImage, setPassportImage] = useState(null);
  const [departureAirport, setDepartureAirport] = useState("");
  const [returnAirport, setReturnAirport] = useState("");
  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [flightTime, setFlightTime] = useState("");
  const [flightNumber, setFlightNumber] = useState("");
  const [otherRequests, setOtherRequests] = useState("");
  const [seatNumber, setSeatNumber] = useState("");
  const [upgradeClass, setUpgradeClass] = useState(false);
  const [ticketCount, setTicketCount] = useState(1);

  const token = localStorage.getItem("token");
  const userId = localStorage.getItem("user_id");

  const handleSubmit = (e) => {
    e.preventDefault();

    // Create a new FormData instance
    const formData = new FormData();

    // Append the necessary fields
    formData.append("arrival_date", arrivalDate);
    formData.append("departure_date", departureDate);
    formData.append("passport_image", passportImage); // Uncomment if needed
    formData.append("departure_airport", departureAirport);
    formData.append("arrival_airport", returnAirport);
    formData.append("specific_flight_time", flightTime); // Adjusted to match the key in your original object
    formData.append("flight_number", flightNumber);
    formData.append("additional_requests", otherRequests);
    formData.append("seat_preference", seatNumber);
    formData.append("upgrade_class", upgradeClass ? 1 : 0);
    formData.append("ticket_count", ticketCount);
    formData.append("is_companion", 0); // Set is_companion to false
    formData.append("user_id", userId); // Add user_id to the data

    axios
      .post("http://127.0.0.1:8000/api/flights", formData, {
        headers: {
          Authorization: `Bearer ${token}`, // Include the token in the header
          // No need to set 'Content-Type' for FormData, it will be set automatically
        },
      })
      .then((response) => {
        toast.success(response?.data?.message);
        setOpenForm(false);
        getFlightData();
        // Handle success (like showing a success message, redirecting, etc.)
      })
      .catch((error) => {
        console.error(
          "There was an error creating the flight:",
          error.response.data
        );
        // Handle error (like showing an error message)
      });
  };

  return (
    <form className="main-flight-form" onSubmit={handleSubmit}>
      <div className="flight-information-header">Flight Information</div>
     <div className="form-section">
        <DateInput
          label="Arrival Date"
          inputValue={arrivalDate}
          setInputValue={setArrivalDate}
          placeholder="Arrival Date"
          required={true}
        />

        <DateInput
          label="Departure Date"
          inputValue={departureDate}
          setInputValue={setDepartureDate}
          placeholder="Departure Date"
          required={true}
        />

        <ImageUpload
          errorMsg={""}
          required={true}
          label="Passport Image"
          allowedExtensions={["jpg", "jpeg", "png", "gif"]}
          inputValue={passportImage}
          setInputValue={setPassportImage}
        />
        <Input
          label="Departure Airport"
          type="text"
          inputValue={departureAirport}
          setInputValue={setDepartureAirport}
          placeholder="Departure Airport"
          required={true}
        />

        <Input
          label="Return Airport"
          type="text"
          inputValue={returnAirport}
          setInputValue={setReturnAirport}
          placeholder="Return Airport"
          required={true}
        />

        <Checkbox
          label="Do you have specific flight time?"
          checkboxValue={specificFlightTime}
          setCheckboxValue={setSpecificFlightTime}
          icon={""}
          errorMsg={""}
        />

        {specificFlightTime && (
          <Fragment>
            <Input
              label="Flight Time"
              type="time"
              inputValue={flightTime}
              setInputValue={setFlightTime}
              placeholder="Flight Time"
              required={true}
            />
            <Input
              label="Flight Number"
              type="text"
              inputValue={flightNumber}
              setInputValue={setFlightNumber}
              placeholder="Flight Number"
              required={false}
            />
          </Fragment>
        )}

        <Input
          label="Other Requests"
          type="text"
          inputValue={otherRequests}
          setInputValue={setOtherRequests}
          placeholder="Other Requests"
          required={false}
        />

        <Input
          label="Seat Number"
          type="text"
          inputValue={seatNumber}
          setInputValue={setSeatNumber}
          placeholder="Seat Number"
          required={false}
        />

        <Checkbox
          label="Do you want to upgrade from economy to business class?"
          checkboxValue={upgradeClass}
          setCheckboxValue={setUpgradeClass}
          icon={""}
          errorMsg={""}
        />

        <Input
          label="Number of Tickets to Book"
          type="number"
          inputValue={ticketCount}
          setInputValue={(value) => setTicketCount(Number(value))}
          placeholder="Number of Tickets to Book"
          required={true}
        />
      </div>

      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpenForm(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" type="submit" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </form>
  );
};

const CompanionForm = ({ setOpenForm }) => {
  const [companions, setCompanions] = useState([]); // Array to store companions' data
  const [currentCompanion, setCurrentCompanion] = useState({
    name: "",
    arrivalDate: "",
    departureDate: "",
    passportImage: null,
    departureAirport: "",
    returnAirport: "",
    specificFlightTime: false,
    flightTime: "",
    flightNumber: "",
    seatNumber: "",
    otherRequests: "",
    upgradeClass: false,
  });

  // Add a new companion to the list
  const addCompanionToList = () => {
    setCompanions([...companions, currentCompanion]);
    setCurrentCompanion({
      arrivalDate: "",
      departureDate: "",
      passportImage: null,
      departureAirport: "",
      returnAirport: "",
      specificFlightTime: false,
      flightTime: "",
      flightNumber: "",
      seatNumber: "",
      otherRequests: "",
      upgradeClass: false,
    });
    setOpenForm(false);
  };

  // Handle input change in the side drawer form
  const handleCompanionChange = (field, value) => {
    setCurrentCompanion((prev) => ({ ...prev, [field]: value }));
  };

  const token = localStorage.getItem("token");
  const userId = localStorage.getItem("user_id");
  const handleCompanionSubmit = (e) => {
    e.preventDefault();

    // Create a new FormData instance
    const formData = new FormData();

    // Append the necessary fields
    formData.append("passenger_name", currentCompanion.name);
    formData.append("arrival_date", currentCompanion.arrivalDate);
    formData.append("departure_date", currentCompanion.departureDate);
    formData.append("passport_image", currentCompanion.passportImage); // Uncomment if needed
    formData.append("departure_airport", currentCompanion.departureAirport);
    formData.append("arrival_airport", currentCompanion.returnAirport);
    formData.append("specific_flight_time", currentCompanion.flightTime);
    formData.append("flight_number", currentCompanion.flightNumber);
    formData.append("additional_requests", currentCompanion.otherRequests);
    formData.append("seat_preference", currentCompanion.seatNumber);
    formData.append("upgrade_class", currentCompanion.upgradeClass ? 1 : 0);
    formData.append("ticket_count", 1); // Set ticket count to 1 for a companion
    formData.append("is_companion", 1); // Specify companion status


    axios
      .post("http://127.0.0.1:8000/api/flights", formData, {
        headers: {
          Authorization: `Bearer ${token}`, // Include the token in the header
          // No need to set 'Content-Type' for FormData, it will be set automatically
        },
      })
      .then((response) => {
        // Handle success (like showing a success message, redirecting, etc.)
      })
      .catch((error) => {
        console.error(
          "There was an error creating the flight:",
          error.response.data
        );
        // Handle error (like showing an error message)
      });
  };

  return (
    <div className="companion-form">
      <div className="flight-information-header">Add Companion</div>
      <form className="form-section">
        <Input
          label="Name"
          type="text"
          inputValue={currentCompanion.name}
          setInputValue={(value) => handleCompanionChange("name", value)}
          placeholder="Name"
          required
        />
        <DateInput
          label="Arrival Date"
          inputValue={currentCompanion.arrivalDate}
          setInputValue={(value) => handleCompanionChange("arrivalDate", value)}
          placeholder="Arrival Date"
          required
        />
        <DateInput
          label="Departure Date"
          inputValue={currentCompanion.departureDate}
          setInputValue={(value) =>
            handleCompanionChange("departureDate", value)
          }
          placeholder="Departure Date"
          required
        />

        <ImageUpload
          errorMsg={""}
          required={true}
          label="Profile Picture"
          allowedExtensions={["jpg", "jpeg", "png", "gif"]}
          inputValue={currentCompanion.passportImage}
          setInputValue={(value) =>
            handleCompanionChange("passportImage", value)
          }
        />
        <Input
          label="Departure Airport"
          type="text"
          inputValue={currentCompanion.departureAirport}
          setInputValue={(value) =>
            handleCompanionChange("departureAirport", value)
          }
          placeholder="Departure Airport"
          required
        />
        <Input
          label="Return Airport"
          type="text"
          inputValue={currentCompanion.returnAirport}
          setInputValue={(value) =>
            handleCompanionChange("returnAirport", value)
          }
          placeholder="Return Airport"
          required
        />

        <Checkbox
          label="Do you have specific flight time?"
          checkboxValue={currentCompanion.specificFlightTime}
          setCheckboxValue={(value) => {
            handleCompanionChange("specificFlightTime", value);
          }}
          icon={""}
          errorMsg={""}
        />
        {currentCompanion?.specificFlightTime && (
          <Fragment>
            <Input
              label="Flight Time"
              type="time"
              inputValue={currentCompanion.flightTime}
              setInputValue={(value) =>
                handleCompanionChange("flightTime", value)
              }
              placeholder="Flight Time"
              required
            />
            <Input
              label="Flight Number"
              type="text"
              inputValue={currentCompanion.flightNumber}
              setInputValue={(value) =>
                handleCompanionChange("flightNumber", value)
              }
              placeholder="Flight Number"
              required
            />
          </Fragment>
        )}

        <Input
          label="Seat Number"
          type="text"
          inputValue={currentCompanion.seatNumber}
          setInputValue={(value) => handleCompanionChange("seatNumber", value)}
          placeholder="Seat Number"
        />
        <Input
          label="Other Requests"
          type="text"
          inputValue={currentCompanion.otherRequests}
          setInputValue={(value) =>
            handleCompanionChange("otherRequests", value)
          }
          placeholder="Other Requests"
        />

        <Checkbox
          label="Do you want to upgrade from economy to business class?"
          checkboxValue={currentCompanion.upgradeClass}
          setCheckboxValue={(value) =>
            handleCompanionChange("upgradeClass", value)
          }
          icon={""}
          errorMsg={""}
        />
      </form>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpenForm(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" onClick={handleCompanionSubmit}>
          Submit
        </button>
      </div>
    </div>
  );
};

const FlightForm = () => {
  const [data, setData] = useState({});
  const [openFlight, setOpenFlight] = useState(false);
  const [openCompanion, setOpenCompanion] = useState(false);
  const getFlightData = () => {
    const token = localStorage.getItem("token");
    const userId = localStorage.getItem("user_id");

    axios
      .get("http://127.0.0.1:8000/api/flight", {
        headers: {
          Authorization: `Bearer ${token}`, // تمرير الـ token
        },
      })
      .then((response) => {
        setData(response.data[0]);
      })
      .catch((error) => {
      });
  };
  useEffect(() => {
    getFlightData();
  }, []);
  return (
    <div className="flight-form-page-container">
      <div className="flight-form-header-container">
        <div className="title-container">Flight Information Page</div>
        <div className="flight-actions">
          <button
            type="button"
            onClick={() => setOpenFlight(true)}
            disabled={Object.keys(data).length ? false : true}
            className={`add-companion-btn ${
              Object.keys(data).length ? "" : "disabled-btn"
            }`}
          >
            Add Companion
          </button>
          <button
            className={`${Object.keys(data).length ? "disabled-btn" : ""}`}
            type="button"
            disabled={Object.keys(data).length ? true : false}
            onClick={() => {
              setOpenCompanion(true);
            }}
          >
            Add Flight Information
          </button>
        </div>
      </div>
      {Object.keys(data).length ? (
        <div className="view-flight-details">
          <SimpleLabelValue label="Arrival Date" value={data.arrival_date} />
          <SimpleLabelValue
            label="Departure Date"
            value={data.departure_date}
          />
          <SimpleLabelValue
            label="Departure Airport"
            value={data.departure_airport}
          />
          <SimpleLabelValue
            label="Arrival Airport"
            value={data.arrival_airport}
          />
          <SimpleLabelValue
            label="Specific Flight Time"
            value={data.specific_flight_time ? "Yes" : "No"}
          />
          <SimpleLabelValue
            label="Flight Time"
            value={data.specific_flight_time}
          />{" "}
          {/* Adjust if necessary */}
          <SimpleLabelValue label="Flight Number" value={data.flight_number} />
          <SimpleLabelValue
            label="Seat Number"
            value={data.seat_preference}
          />{" "}
          {/* Changed from seatNumber */}
          <SimpleLabelValue
            label="Upgrade Class"
            value={data.upgrade_class ? "Yes" : "No"}
          />
          <SimpleLabelValue label="Ticket Count" value={data.ticket_count} />
          <SimpleLabelValue
            label="Other Requests"
            value={data.additional_requests}
          />
        </div>
      ) : (
        <div className="no-data">
          No Data Available , Please Enter Flight Information
        </div>
      )}

      <MySideDrawer isOpen={openCompanion} setIsOpen={setOpenCompanion}>
        <MainFlightForm
          setOpenForm={setOpenCompanion}
          getFlightData={getFlightData}
        />
      </MySideDrawer>

      <MySideDrawer isOpen={openFlight} setIsOpen={setOpenFlight}>
        <CompanionForm setOpenForm={setOpenFlight} />
      </MySideDrawer>
    </div>
  );
};

export default FlightForm;
