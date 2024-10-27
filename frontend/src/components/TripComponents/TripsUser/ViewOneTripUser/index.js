import React, { useEffect, useState } from "react";
import "./style.scss";
import Slider from "../../../Slider";
import httpService from "../../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import { backendUrlImages } from "../../../../constant/config";

const ViewOneTripUser = () => {
  const { id } = useParams();
  const [tripData, setTripData] = useState({});
  const getAuthToken = () => localStorage.getItem("token");
  const navigate = useNavigate();
  const getTripById = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/trip_option/${id}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },

        showLoader: true,
      });

      console.log(response?.trip);
      setTripData(response?.trip);
    } catch (error) {
      console.error("Error submitting discount", error);
    }
  };
  useEffect(() => {
    getTripById();
  }, []);
  return (
    <div className="view-one-trip-for-user">
      <div className="slider">
        <Slider
          slides={[
            <img
              src={`${backendUrlImages}${tripData.image_1}`}
              alt="Trip Image 1"
            />,
            <img
              src={`${backendUrlImages}${tripData.image_2}`}
              alt="Trip Image 2"
            />,
            <img
              src={`${backendUrlImages}${tripData.image_3}`}
              alt="Trip Image 3"
            />,
            <img
              src={`${backendUrlImages}${tripData.image_4}`}
              alt="Trip Image 4"
            />,
            <img
              src={`${backendUrlImages}${tripData.image_5}`}
              alt="Trip Image 5"
            />,
          ]}
        />
      </div>
      <div>
        <h1>{tripData?.name}</h1>
        <p>{tripData?.description}</p>
        <h3>Price Information</h3>
        <ul>
          <li>Price per person: ${tripData?.price_per_person}</li>
          <li>Price for two: ${tripData?.price_for_two}</li>
          <li>Price for three or more: ${tripData?.price_for_three_or_more}</li>
        </ul>
        {tripData?.additional_options?.map((item) => {
          return (
            <div>
              <div>{item?.option_name}</div>
              <div>{`Price : ${item?.price}$`} </div>
            </div>
          );
        })}
        <button
          className="register-trip-btn"
          onClick={() => {
            navigate(`/trip/user/${id}`);
          }}
        >
          Register now
        </button>
      </div>
    </div>
  );
};

export default ViewOneTripUser;
