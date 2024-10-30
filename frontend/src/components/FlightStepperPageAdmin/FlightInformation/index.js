import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input/index";
import Checkbox from "../../../CoreComponent/Checkbox/index";
import DateInput from "../../../CoreComponent/Date/index";
import { toast } from "react-toastify";
import deleteIcon from "../../../icons/deleteIcon.svg";
import SVG from "react-inlinesvg";
import { useFlightStepperAdmin } from "../StepperContext";
import {
  getFromLocalStorage,
  saveToLocalStorage,
} from "../../../common/localStorage";
import "./style.scss";
import { useNavigate } from "react-router-dom";

const FlightInformation = () => {
  const navigate = useNavigate();
  const { currentStep, completeStep, passportImage } = useFlightStepperAdmin();

  // State to manage an array of trips
  const [trips, setTrips] = useState([
    {
      departureDate: "",
      departureTime: "",
      price: "",
      isFree: false,
    },
  ]);

  const handleSubmit = () => {
    toast.success("The data was updated successfully!");
    saveToLocalStorage("flightTrips", trips);
    completeStep(currentStep);
    console.log({ passportImage });
  };

  const handleDeleteTrip = (index) => {
    const updatedTrips = trips.filter((_, i) => i !== index);
    setTrips(updatedTrips);
    saveToLocalStorage("flightTrips", updatedTrips);
    toast.success("Trip deleted successfully!");
  };

  const handleAddTrip = () => {
    const newTrip = {
      departureDate: "",
      departureTime: "",
      price: "",
      isFree: false,
    };
    setTrips((prevTrips) => [...prevTrips, newTrip]);
  };

  useEffect(() => {
    const data = getFromLocalStorage("flightTrips");
    if (data) {
      setTrips(data);
    }
  }, []);

  return (
    <div className="flight-admin">
      <div className="add-room-btn-container">
        <button type="button" onClick={handleAddTrip}>
          Add Trip
        </button>
      </div>

      <div className="room-form-container">
        {trips.map((trip, index) => (
          <div className="room-form-stepper-container">
            <div className="delete-icon-container">
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={() => handleDeleteTrip(index)}
              />
            </div>
            <div key={index} className="room-form-stepper">
              <DateInput
                label="Departure Date"
                placeholder="Enter departure date"
                inputValue={trip.departureDate}
                setInputValue={(value) => {
                  const updatedTrips = [...trips];
                  updatedTrips[index].departureDate = value;
                  setTrips(updatedTrips);
                }}
                required={true}
              />
              <Input
                label="Departure Time"
                placeholder="Enter departure time"
                inputValue={trip.departureTime}
                setInputValue={(value) => {
                  const updatedTrips = [...trips];
                  updatedTrips[index].departureTime = value;
                  setTrips(updatedTrips);
                }}
                type="time"
                required={true}
              />
              <Input
                label="Price"
                placeholder="Enter price"
                inputValue={trip.price}
                setInputValue={(value) => {
                  const updatedTrips = [...trips];
                  updatedTrips[index].price = value;
                  setTrips(updatedTrips);
                }}
                type="number"
                required={true}
              />
              <div className="check-in-input-container">
                <Checkbox
                  label="Is Free?"
                  checkboxValue={trip.isFree}
                  setCheckboxValue={(value) => {
                    const updatedTrips = [...trips];
                    updatedTrips[index].isFree = value;
                    setTrips(updatedTrips);
                  }}
                  icon={""}
                  errorMsg={""}
                />
              </div>
            </div>{" "}
          </div>
        ))}
      </div>

      <div className="actions-section">
        <button
          className={`next-button ${false ? "disabled" : ""}`}
          onClick={() => {
            handleSubmit();
            navigate("/");
          }}
          disabled={false}
        >
          Submit
        </button>
      </div>
    </div>
  );
};

export default FlightInformation;
