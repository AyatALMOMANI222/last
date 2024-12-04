import React, { Fragment, useState, useEffect } from "react";
import Input from "../../../CoreComponent/Input/index";
import Checkbox from "../../../CoreComponent/Checkbox/index";
import DateInput from "../../../CoreComponent/Date/index";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import SVG from "react-inlinesvg";
import deleteIcon from "../../../icons/deleteIcon.svg";
import { useFlightStepper } from "../StepperContext";
import { toast } from "react-toastify";
import { getFromLocalStorage } from "../../../common/localStorage";
import httpService from "../../../common/httpService";
import "./style.scss";
import { useNavigate } from "react-router-dom";

const FlightInformation = () => {
  const navigate = useNavigate();
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
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const { passportImage } = useFlightStepper();
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

  const formatFlightData = (flights) => {
    return flights.map((flight) => {
      return {
        departureAirport: flight.departureAirport,
        returnAirport: flight.returnAirport,
        departureDate: flight.departureDate,
        arrivalDate: flight.arrivalDate,
        specificFlightTime: flight.specificFlightTime
          ? flight.flightTime
          : null,
        flightNumber: flight.flightNumber || 0,
        seatNumber: flight.seatNumber || 0,
        upgradeClass: flight.upgradeClass ? 1 : 0,
        otherRequests: flight.otherRequests || null,
        ticket_count: flight.ticketCount || 1,
        name: flight.name || "i",
        passportImage: flight.passportImage || null,
      };
    });
  };

  const getAuthToken = () => localStorage.getItem("token");
  // function formatFlightDataToFormData(flights) {
  //   const formData = new FormData();

  //   flights.forEach((flight, index) => {
  //     formData.append(`flights[${index}][flightTime]`, flight.flightTime || "");
  //     formData.append(
  //       `flights[${index}][departureAirport]`,
  //       flight.departureAirport
  //     );
  //     formData.append(`flights[${index}][returnAirport]`, flight.returnAirport);
  //     formData.append(`flights[${index}][departureDate]`, flight.departureDate);
  //     formData.append(`flights[${index}][arrivalDate]`, flight.arrivalDate);
  //     formData.append(
  //       `flights[${index}][specificFlightTime]`,
  //       flight.specificFlightTime ? 1 : 0
  //     );
  //     formData.append(
  //       `flights[${index}][flightNumber]`,
  //       flight.flightNumber || "0"
  //     );
  //     formData.append(`flights[${index}][seatNumber]`, flight.seatNumber || "");
  //     formData.append(
  //       `flights[${index}][upgradeClass]`,
  //       flight.upgradeClass ? 1 : 0
  //     );
  //     formData.append(
  //       `flights[${index}][otherRequests]`,
  //       flight.otherRequests || ""
  //     );
  //     formData.append(
  //       `flights[${index}][ticket_count]`,
  //       flight.ticketCount || 1
  //     );
  //     formData.append(`flights[${index}][name]`, flight.name || "");

  //     if (flight.passportImage) {
  //       formData.append(
  //         `flights[${index}][passportImage]`,
  //         flights[index].passportImage
  //       );
  //     }
  //   });

  //   return formData;
  // }

  const formatFlightDataToFormData = (flights) => {
    const formData = new FormData();
    flights.forEach((flight, index) => {
      for (const [key, value] of Object.entries(flight)) {
        const fieldKey = `flights[${index}][${key}]`;
        formData.append(fieldKey, value || "");
      }
    });
    return formData;
  };
  const submitFlightData = async (flightDataArray) => {
    const formattedData = formatFlightData(flightDataArray);
    const formData = formatFlightDataToFormData(formattedData);

    await httpService({
      method: "POST",
      url: `${BaseUrl}/flights`,
      headers: { Authorization: `Bearer ${getAuthToken()}` },

      data: formData,
      onSuccess: () => {
        // toast.success("Flights created successfully!");
        navigate("/reservation/form");
      },
      onError: () => {
        toast.error("Failed to create flights");
      },
      withToast: true,
      showLoader: true,
    });
  };

  const handleSubmit = () => {
    const flightDetails = getFromLocalStorage("flightDetails");
    const data = [
      { ...flightDetails, passportImage: passportImage },
      ...companions,
    ];
    submitFlightData(data);
  };
  const isCompanionFormValid = (companion) => {
    return (
      companion.name &&
      companion.arrivalDate &&
      companion.departureDate &&
      companion.passportImage &&
      companion.departureAirport &&
      companion.returnAirport
    );
  };

  const isSubmitDisabled = companions.some(
    (companion) => !isCompanionFormValid(companion)
  );

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
          className={`next-button ${isSubmitDisabled ? "disabled" : ""}`}
          onClick={() => {
            handleSubmit();
          }}
          disabled={isSubmitDisabled}
        >
          Submit
        </button>
      </div>
    </div>
  );
};

export default FlightInformation;
