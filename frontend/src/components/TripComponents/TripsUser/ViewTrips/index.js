import React, { useEffect, useState } from "react";
import httpService from "../../../../common/httpService";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import { backendUrlImages } from "../../../../constant/config";
import tripImage from "../../../../icons/tripImage.webp";
const ViewUserTrips = () => {
  const navigate = useNavigate();
  const [allTrips, setAllTrips] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const getAuthToken = () => localStorage.getItem("token");

  const getAllTrips = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/all-trip`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        withLoadder: true,
        withToast: false,
      });

      console.log(response?.trips);
      setAllTrips(response?.trips);
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
            <img
              src={`${backendUrlImages}${trip.image_1}`}
              onError={(e) => {
                e.currentTarget.src = tripImage;
              }}
              className="trip-image"
              alt="Trip Image"
            />

            <div className="trip-info">
              <div className="main-info">
                <div className="name">{trip.name}</div>
                <div className="desc">{trip.description}</div>
              </div>
              <div className="actions-btns">
                <button
                  className="view"
                  onClick={() => {
                    navigate(`/view/trip/${trip?.id}`);
                  }}
                >
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
