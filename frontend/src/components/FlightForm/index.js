import React, { Fragment, useState } from "react";
import Input from "../../CoreComponent/Input/index";
import Checkbox from "../../CoreComponent/Checkbox/index";
import DateInput from "../../CoreComponent/Date/index";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import "./style.scss";
import ImageUpload from "../../CoreComponent/ImageUpload";

const MainFlightForm = ({ setOpenForm }) => {
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

  const handlePassportUpload = (e) => {
    setPassportImage(e.target.files[0]);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const formData = {
      arrivalDate,
      departureDate,
      passportImage,
      departureAirport,
      returnAirport,
      specificFlightTime,
      flightTime,
      flightNumber,
      otherRequests,
      seatNumber,
      upgradeClass,
      ticketCount,
    };

    console.log(formData);
    // You can send the formData to an API or perform other actions here.
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
        <button className="submit-btn" type="submit">
          Submit
        </button>
      </div>
    </form>
  );
};

const CompanionForm = ({ setOpenForm }) => {
  const [companions, setCompanions] = useState([]); // Array to store companions' data
  const [currentCompanion, setCurrentCompanion] = useState({
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

  return (
    <div className="companion-form">
      <div className="flight-information-header">Add Companion</div>
      <form className="form-section">
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
        <button className="submit-btn" onClick={addCompanionToList}>
          Submit
        </button>
      </div>
    </div>
  );
};

const FlightForm = () => {
  const data = {
    arrivalDate: "2024-09-18",
    departureDate: "2024-09-25",
    passportImage: {},
    departureAirport: "JFK International Airport, New York",
    returnAirport: "Heathrow Airport, London",
    specificFlightTime: true,
    flightTime: "14:30",
    flightNumber: "BA117",
    otherRequests: "Vegetarian meal, aisle seat preference",
    seatNumber: "12A",
    upgradeClass: true,
    ticketCount: 2,
  };

  const [openFlight, setOpenFlight] = useState(false);
  const [openCompanion, setOpenCompanion] = useState(false);

  return (
    <div className="flight-form-page-container">
      <div className="flight-form-header-container">
        <div className="title-container">Flight Information Page</div>
        <div className="flight-actions">
          <button
            type="button"
            onClick={() => setOpenFlight(true)}
            className="add-companion-btn"
          >
            Add Companion
          </button>
          <button
            type="button"
            onClick={() => {
              setOpenCompanion(true);
            }}
          >
            Add Flight Information
          </button>
        </div>
      </div>

      <div className="view-flight-details">
        <SimpleLabelValue label="Arrival Date" value={data.arrivalDate} />
        <SimpleLabelValue label="Departure Date" value={data.departureDate} />
        <SimpleLabelValue
          label="Departure Airport"
          value={data.departureAirport}
        />
        <SimpleLabelValue label="Return Airport" value={data.returnAirport} />
        <SimpleLabelValue
          label="Specific Flight Time"
          value={data.specificFlightTime ? "Yes" : "No"}
        />
        <SimpleLabelValue label="Flight Time" value={data.flightTime} />
        <SimpleLabelValue label="Flight Number" value={data.flightNumber} />
        <SimpleLabelValue label="Seat Number" value={data.seatNumber} />
        <SimpleLabelValue
          label="Upgrade Class"
          value={data.upgradeClass ? "Yes" : "No"}
        />
        <SimpleLabelValue label="Ticket Count" value={data.ticketCount} />
        <SimpleLabelValue label="Other Requests" value={data.otherRequests} />
      </div>

      <MySideDrawer isOpen={openCompanion} setIsOpen={setOpenCompanion}>
        <MainFlightForm setOpenForm={setOpenCompanion} />
      </MySideDrawer>

      <MySideDrawer isOpen={openFlight} setIsOpen={setOpenFlight}>
        <CompanionForm setOpenForm={setOpenFlight} />
      </MySideDrawer>
    </div>
  );
};

export default FlightForm;
