import React, { useEffect, useState } from "react";
import "./style.scss";
import httpService from "../../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import { backendUrlImages } from "../../../../constant/config";
import SimpleLabelValue from "../../../SimpleLabelValue";

const ViewOneTripUser = () => {
  const { id } = useParams();
  const [tripData, setTripData] = useState({});
  const getAuthToken = () => localStorage.getItem("token");
  const navigate = useNavigate();
  const BaseUrl = process.env.REACT_APP_BASE_URL;

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
      {/* Displaying the first image if available */}
      {tripData?.image_1 && (
        <div className="slider">
          <img
            src={`${backendUrlImages}${tripData.image_1}`}
            alt="Trip Image 1"
          />
        </div>
      )}

      <div className="trip-name-section">
        {/* Display trip name if available */}
        {tripData?.name && <h1>{tripData?.name}</h1>}

        {/* Display trip description if available */}
        {tripData?.description && (
          <div className="info-header">{tripData?.description}</div>
        )}

        {/* Display trip price details only if available */}
        {(tripData?.price_per_person || tripData?.price_for_two || tripData?.price_for_three_or_more) && (
          <>
            <h3>Price Information</h3>
            <div className="additional-options-container">
              {tripData?.price_per_person && (
                <SimpleLabelValue
                  label="Price per person"
                  value={` ${tripData?.price_per_person}$`}
                />
              )}
              {tripData?.price_for_two && (
                <SimpleLabelValue
                  label="Price for two"
                  value={` ${tripData?.price_for_two}$`}
                />
              )}
              {tripData?.price_for_three_or_more && (
                <SimpleLabelValue
                  label="Price for three or more"
                  value={` ${tripData?.price_for_three_or_more}$`}
                />
              )}
            </div>
          </>
        )}

        {/* Display trip additional options if available */}
        {tripData?.additional_options?.length > 0 && (
          <>
            <h3>Additional Options</h3>
            <div className="additional-options-container">
              {tripData?.additional_options?.map((item) => (
                <div key={item?.option_name}>
                  <SimpleLabelValue
                    label={item?.option_name}
                    value={`${item?.price}$`}
                  />
                </div>
              ))}
            </div>
          </>
        )}

        {/* Display more trip details if available */}
        {tripData?.trip_type && (
          <SimpleLabelValue label="Trip Type" value={tripData?.trip_type} />
        )}
        {tripData?.available_dates && (
          <SimpleLabelValue label="Available Dates" value={tripData?.available_dates} />
        )}
        {tripData?.location && (
          <SimpleLabelValue label="Location" value={tripData?.location} />
        )}
        {tripData?.duration && (
          <SimpleLabelValue label="Duration" value={`${tripData?.duration} days`} />
        )}
        {tripData?.inclusions && (
          <SimpleLabelValue label="Inclusions" value={tripData?.inclusions} />
        )}
        {tripData?.group_price_per_person && (
          <SimpleLabelValue
            label="Group Price per person"
            value={`${tripData?.group_price_per_person}$`}
          />
        )}
        {tripData?.group_price_per_speaker && (
          <SimpleLabelValue
            label="Group Price per speaker"
            value={`${tripData?.group_price_per_speaker}$`}
          />
        )}
        {tripData?.trip_details && (
          <SimpleLabelValue label="Trip Details" value={tripData?.trip_details} />
        )}
        {tripData?.group_accompanying_price && (
          <SimpleLabelValue
            label="Group Accompanying Price"
            value={`${tripData?.group_accompanying_price}$`}
          />
        )}
<button
  className="register-trip-btn"
  onClick={() => {
    if (tripData?.trip_type === "group") {
      navigate(`/group-trip/user/${id}`); // التنقل لمكون خاص بالرحلات الجماعية
    } else {
      navigate(`/trip/user/${id}`); // التنقل للرحلات الأخرى
    }
  }}
>
  Register now
</button>

      </div>
    </div>
  );
};

export default ViewOneTripUser;
