import React, { useEffect, useState } from "react";
import httpService from "../../../../common/httpService";
import { useNavigate } from "react-router-dom";
import "./style.scss";

const ViewUserTrips = () => {
  const navigate = useNavigate()
  const [allTrips, setAllTrips] = useState([]);
  const getAuthToken = () => localStorage.getItem("token");

  const getAllTrips = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/all-trip`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      });

      console.log( response?.trips
      );
      setAllTrips( response?.trips)
    } catch (error) {
      console.error("Error fetching conferences", error);
    }
  };

  useEffect(() => {
    getAllTrips();
  }, []);
  return (
    <div className="trips-page">
      <div className="trips-users-container">
        <div className="trips-types-btn">
          <button>Group Trips</button>
          <button>Private Trips</button>
        </div>
      </div>

      <div className="trip-cards">
        {allTrips?.map((trip) => (
          <div className="trip-card" key={trip.id}>
            <img src={trip.image_1} alt={trip.name} className="trip-image" />
            <div className="trip-info">
              <div className="main-info">
                <div className="name">{trip.name}</div>
                <div className="desc">{trip.description}</div>
              </div>
              <div className="actions-btns">
                <button className="view" onClick={() => {

                  navigate(`/view/trip/${trip?.id}`)
                }}>
                  Register for a Trip
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ViewUserTrips;
