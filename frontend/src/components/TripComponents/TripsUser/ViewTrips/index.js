import React, { useEffect, useState } from "react";
import axios from "axios";
import httpService from "../../../../common/httpService";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import { backendUrlImages } from "../../../../constant/config";
import tripImage from "../../../../icons/tripImage.webp";
import { useAuth } from "../../../../common/AuthContext";

const ViewUserTrips = () => {
  const navigate = useNavigate();
  const [allTrips, setAllTrips] = useState([]);
  const [hasFreeTrip, setHasFreeTrip] = useState(false);
  const [selectedTripType, setSelectedTripType] = useState("private");
  const { myConferenceId } = useAuth();

  const token = localStorage.getItem("token");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getSpeakerInfo = async () => {
    try {
      const response = await axios.get(
        `${BaseUrl}/speakers/${myConferenceId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const speakerData = response.data.speaker;
      console.log({ speakerData });
      setHasFreeTrip(speakerData.free_trip);
    } catch (error) {
      console.error(
        "Failed to fetch speaker info:",
        error.response?.data || error.message
      );
    }
  };

  const fetchTrips = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/all-trip`,
        params: { trip_type: selectedTripType },
        headers: { Authorization: `Bearer ${token}` },
        showLoader: true,
        withToast: true,
      });
      setAllTrips(response?.trips || []);
    } catch (error) {
      console.error("Failed to fetch trips:", error.message);
    }
  };

  useEffect(() => {
    fetchTrips();
    getSpeakerInfo();
  }, [selectedTripType]);

  return (
    <div className="trips-page">
      <div className="trips-users-container">
        <div className="trips-types-btn">
          {hasFreeTrip && (
            <button
              className={`trip-type-btn ${
                selectedTripType === "group" ? "active" : ""
              }`}
              onClick={() => setSelectedTripType("group")}
            >
              Group Trips
            </button>
          )}
          <button
            className={`trip-type-btn ${
              selectedTripType === "private" ? "active" : ""
            }`}
            onClick={() => setSelectedTripType("private")}
          >
            Private Trips
          </button>
        </div>
      </div>

      <div className="trip-cards">
        {allTrips.length > 0  ? (
          allTrips.map((trip) => (
            <div className="trip-card" key={trip.id}>
              <img
                src={`${backendUrlImages}${trip.image_1}`}
                onError={(e) => {
                  e.currentTarget.src = tripImage;
                }}
                className="trip-image"
                alt="Trip"
              />

              <div className="trip-info">
                <div className="main-info">
                  <div className="name">{trip.name}</div>
                  <div className="desc">{trip.description}</div>
                </div>
                <div className="actions-btns">
                  <button
                    className="view"
                    onClick={() => navigate(`/view/trip/${trip.id}`)}
                  >
                    Register for a Trip
                  </button>
                </div>
              </div>
            </div>
          ))
        ) : (
          <p className="no-trips-message">No trips available for this type.</p>
        )}
      </div>
    </div>
  );
};

export default ViewUserTrips;
