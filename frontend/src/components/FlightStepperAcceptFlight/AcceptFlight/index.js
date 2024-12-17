import React, { Fragment, useEffect, useState } from "react";
import { toast } from "react-toastify";
import { useFlightStepperAdmin } from "../StepperContext";
import httpService from "../../../common/httpService";
import "./style.scss";
import {
  getFromLocalStorage,
  saveToLocalStorage,
} from "../../../common/localStorage";
import DialogMessage from "../../DialogMessage";
import { useNavigate } from "react-router-dom";

const AcceptFlight = ({ member, index }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const navigate = useNavigate();
  const { currentStep, completeStep, passportImage, flightMembers } =
    useFlightStepperAdmin();
  const otherData = {
    available_id: 0,
    flight_id: member?.flight_id,
    price: 0,
    is_free: 0,
    departure_time: null,
    departure_date: null,
    isOther: 1,
  };
  const [availableFlights, setAvailableFlights] = useState([]);
  const [selectedFlight, setSelectedFlight] = useState({});
  const [noData, setNoData] = useState(false);

  const getAuthToken = () => localStorage.getItem("token");

  const getAvailableFlights = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/available-flights/${member?.flight_id}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        withToast: false,
      });
      if (Array.isArray(response?.data) && response?.data.length === 0) {
        setNoData(true);

        return;
      }
      setAvailableFlights([otherData, ...response?.available_flights] || []);
    } catch (error) {
      // toast.error("Failed to fetch available flights");
    }
  };

  const getFlights = () => {
    const flightTrips = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key.startsWith("Available_Trip_ID_")) {
        const value = localStorage.getItem(key);
        try {
          flightTrips.push(JSON.parse(value));
        } catch {
          console.error("Error parsing localStorage data", value);
        }
      }
    }
    return flightTrips;
  };
  function checkIsOther(data) {
    return data.some((item) => item.isOther === 1);
  }

  const submit = async () => {
    const data = getFlights();
    const isOther = checkIsOther(data);
    if (!isOther) {
      const getAuthToken = () => localStorage.getItem("token");

      try {
        await httpService({
          method: "POST",
          url: `${BaseUrl}/accepted-flights/user/all`,
          headers: { Authorization: `Bearer ${getAuthToken()}` },
          showLoader: true,
          data: {
            flights: data,
          },
          withToast: true,
        });
        completeStep(currentStep);
      } catch (error) {
        console.error("Error submitting form:", error);
      }
    } else {
      try {
        await httpService({
          method: "POST",
          url: `${BaseUrl}/accepted-flights/user/all`,
          headers: { Authorization: `Bearer ${getAuthToken()}` },
          showLoader: true,
          data: {
            flights: data.filter((item) => item.isOther === 1),
          },
          withToast: false,
        });
        setIsDialogOpen(true);
      } catch (error) {
        console.error("Error submitting form:", error);
      }
    }
  };

  const handleSubmit = () => {
    const isFinalStep = flightMembers.length === index + 1;

    if (!isFinalStep) {
      completeStep(currentStep);
      toast.success("The data was updated successfully!");
    } else {
      submit();
    }
  };

  useEffect(() => {
    getAvailableFlights();
    const storedFlight = getFromLocalStorage(
      `Available_Trip_ID_${member?.flight_id}`
    );
    if (storedFlight) {
      setSelectedFlight(storedFlight);
    }
  }, []);
  if (noData) {
    return <div className="no-data-biv">No Available Flights yet</div>;
  }
  return (
    <Fragment>
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
        message="Your additional flight options will be entered shortly. You will be notified once they have been successfully added to your selection."
        onOk={() => {
          navigate("/flight/form");
        }}
        onClose={() => {
          navigate("/flight/form");
        }}
      />
      <div className="accept-flight-information">
        <div className="title">Available Flights</div>
        <div className="flight-cards-container">
          {availableFlights.map((flight) => (
            <div
              key={flight.available_id}
              className={`flight-card ${
                selectedFlight?.available_id === flight.available_id
                  ? "selected"
                  : ""
              }`}
              onClick={() => {
                setSelectedFlight(flight);
                saveToLocalStorage(
                  `Available_Trip_ID_${member?.flight_id}`,
                  flight
                );
              }}
            >
              {flight.available_id !== 0 ? (
                <Fragment>
                  <div className="flight-card__detail">
                    <span>Departure Date:</span> {flight.departure_date}
                  </div>
                  <div className="flight-card__detail">
                    <span>Departure Time:</span> {flight.departure_time}
                  </div>
                  <div className="flight-card__detail">
                    <span>Price:</span> {flight.price}$
                  </div>
                </Fragment>
              ) : (
                <div className="other">Other</div>
              )}
            </div>
          ))}
        </div>

        <div className="actions-section">
          <button
            className="next-button"
            onClick={handleSubmit}
            disabled={!selectedFlight}
          >
            Next
          </button>
        </div>
      </div>
    </Fragment>
  );
};

export default AcceptFlight;
