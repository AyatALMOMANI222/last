import React, { useEffect, useState } from "react";
import "./style.scss";
import Slider from "../../../Slider";
import httpService from "../../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import { backendUrlImages } from "../../../../constant/config";
import SimpleLabelValue from "../../../SimpleLabelValue";

const ViewOneTripUser = () => {
  const { id } = useParams();
  const [tripData, setTripData] = useState({});
  const getAuthToken = () => localStorage.getItem("token");
  const navigate = useNavigate();
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const getTripById = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/trip_option/${id}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,

      });

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
        <div className="info-header">{tripData?.description}</div>
        <h3>Price info-headerrmation</h3>
        <div className="additional-options-container">
          <SimpleLabelValue
            label="Price per person"
            value={` ${tripData?.price_per_person}$`}
          />
          <SimpleLabelValue
            label="Price for two"
            value={` ${tripData?.price_for_two}$`}
          />
          <SimpleLabelValue
            label="Price for three or more"
            value={` ${tripData?.price_for_three_or_more}$`}
          />
        </div>
        <h3>Additional Options</h3>

        <div className="additional-options-container">
          {tripData?.additional_options?.map((item) => {
            return (
              <div>
                <SimpleLabelValue
                  label={item?.option_name}
                  value={`${item?.price}$`}
                />
              </div>
            );
          })}
        </div>

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
