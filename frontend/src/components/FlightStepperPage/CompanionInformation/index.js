import React, { Fragment, useState ,useEffect} from "react";
import Input from "../../../CoreComponent/Input/index";
import Checkbox from "../../../CoreComponent/Checkbox/index";
import DateInput from "../../../CoreComponent/Date/index";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import SVG from "react-inlinesvg";
import deleteIcon from "../../../icons/deleteIcon.svg";
import { useFlightStepper } from "../StepperContext";

import { toast } from "react-toastify";
import {
  getFromLocalStorage,
  saveToLocalStorage,
} from "../../../common/localStorage";
import "./style.scss";
const FlightInformation = () => {
  const initialValue = {
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
  };
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
  useFlightStepper();
  const [companions, setCompanions] = useState([initialValue]);

  const handleCompanionChange = (index, field, value) => {
    setCompanions((prevCompanions) => {
      const updatedCompanions = [...prevCompanions];
      updatedCompanions[index][field] = value;
      return updatedCompanions;
    });
  };

  const addNewCompanion = () => {
    setCompanions([...companions, { ...initialValue }]);
  };

  const deleteCompanion = (index) => {
    setCompanions(companions.filter((_, i) => i !== index));
  };
  const handleSubmit = () => {
    toast.success("The data was updated successfully!");

    // Save companions array to local storage
    saveToLocalStorage("flightCompanions", companions);

    // Call complete step function
    completeStep(currentStep);
    console.log({ currentStep });
  };
  // Load companions from local storage on mount
  useEffect(() => {
    const savedCompanions = getFromLocalStorage("flightCompanions");
    if (savedCompanions) {
      setCompanions(savedCompanions);
    }
  }, []);
  return (
    <div>
      <div className="add-flight-btn-container">
        <button type="button" onClick={addNewCompanion}>
          Add Companion
        </button>
      </div>
      <div className="flight-form-container">
        {companions.map((companion, index) => (
          <div className="flight-form-stepper-container" key={index}>
            <div className="delete-icon-container">
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={() => deleteCompanion(index)}
              />
            </div>
            <form className="flight-form-stepper">
              <Input
                label="Name"
                type="text"
                inputValue={companion.name}
                setInputValue={(value) =>
                  handleCompanionChange(index, "name", value)
                }
                placeholder="Name"
                required
              />
              <DateInput
                label="Arrival Date"
                inputValue={companion.arrivalDate}
                setInputValue={(value) =>
                  handleCompanionChange(index, "arrivalDate", value)
                }
                placeholder="Arrival Date"
                required
              />
              <DateInput
                label="Departure Date"
                inputValue={companion.departureDate}
                setInputValue={(value) =>
                  handleCompanionChange(index, "departureDate", value)
                }
                placeholder="Departure Date"
                required
              />
              <ImageUpload
                errorMsg=""
                required
                label="Passport Image"
                allowedExtensions={["jpg", "jpeg", "png", "gif"]}
                inputValue={companion.passportImage}
                setInputValue={(value) =>
                  handleCompanionChange(index, "passportImage", value)
                }
              />
              <Input
                label="Departure Airport"
                type="text"
                inputValue={companion.departureAirport}
                setInputValue={(value) =>
                  handleCompanionChange(index, "departureAirport", value)
                }
                placeholder="Departure Airport"
                required
              />
              <Input
                label="Return Airport"
                type="text"
                inputValue={companion.returnAirport}
                setInputValue={(value) =>
                  handleCompanionChange(index, "returnAirport", value)
                }
                placeholder="Return Airport"
                required
              />
              <Checkbox
                label="Do you have specific flight time?"
                checkboxValue={companion.specificFlightTime}
                setCheckboxValue={(value) =>
                  handleCompanionChange(index, "specificFlightTime", value)
                }
                icon=""
                errorMsg=""
              />
              {companion.specificFlightTime && (
                <Fragment>
                  <Input
                    label="Flight Time"
                    type="time"
                    inputValue={companion.flightTime}
                    setInputValue={(value) =>
                      handleCompanionChange(index, "flightTime", value)
                    }
                    placeholder="Flight Time"
                    required
                  />
                  <Input
                    label="Flight Number"
                    type="text"
                    inputValue={companion.flightNumber}
                    setInputValue={(value) =>
                      handleCompanionChange(index, "flightNumber", value)
                    }
                    placeholder="Flight Number"
                    required
                  />
                </Fragment>
              )}
              <Input
                label="Seat Number"
                type="text"
                inputValue={companion.seatNumber}
                setInputValue={(value) =>
                  handleCompanionChange(index, "seatNumber", value)
                }
                placeholder="Seat Number"
              />
              <Input
                label="Other Requests"
                type="text"
                inputValue={companion.otherRequests}
                setInputValue={(value) =>
                  handleCompanionChange(index, "otherRequests", value)
                }
                placeholder="Other Requests"
              />
              <Checkbox
                label="Do you want to upgrade from economy to business class?"
                checkboxValue={companion.upgradeClass}
                setCheckboxValue={(value) =>
                  handleCompanionChange(index, "upgradeClass", value)
                }
                icon=""
                errorMsg=""
              />
            </form>
          </div>
        ))}
      </div>
      <div className="actions-section">
        <button
          className="next-button"
          onClick={() => {
            handleSubmit();
          }}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default FlightInformation;
