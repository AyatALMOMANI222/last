import React, { Fragment, useEffect, useState } from "react";
import axios from "axios";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import SimpleLabelValue from "../../../components/SimpleLabelValue";
import "./style.scss";
import { backendUrlImages } from "../../../constant/config";
const ViewOneTrip = ({ isOpen, setIsOpen, tripId }) => {
  const [data, setData] = useState(null);
  const [options, setOptions] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const fetchTripData = async (tripId) => {
    if (!tripId) {
      return;
    }
    try {
      const token = localStorage.getItem("token"); // Get the token from localStorage
      const response = await axios.get(
        `http://127.0.0.1:8000/api/trip/${tripId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`, // Set the Authorization header
          },
        }
      );
      console.log(response.data.trip.additional_options);
      setOptions(response.data.trip.additional_options);
      setData(response.data?.trip);
    } catch (err) {
      setError("Error fetching trip data");
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    tripId && fetchTripData(tripId);
  }, [tripId]);

  if (data && options) {
    return (
      <div>
        <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
          <CustomFormWrapper
            title="Create a New Trip"
            //   handleSubmit={handleSubmit}
            setOpenForm={setIsOpen}
          >
            <div className="view-one-trip-container">
              <SimpleLabelValue label="Name" value={data?.name} />

              <SimpleLabelValue label="Trip Type" value={data?.trip_type} />
              <SimpleLabelValue label="Description" value={data?.description} />
              <SimpleLabelValue
                label="Additional Info"
                value={data?.additional_info}
              />
              <SimpleLabelValue
                label="Price per Person"
                value={`$${data?.price_per_person}`}
              />
              <SimpleLabelValue
                label="Price for Two"
                value={`$${data?.price_for_two}`}
              />
              <SimpleLabelValue
                label="Price for Three or More"
                value={`$${data?.price_for_three_or_more}`}
              />
              <SimpleLabelValue
                label="Created At"
                value={new Date(data?.created_at).toLocaleString()}
              />
              <SimpleLabelValue
                label="Updated At"
                value={new Date(data?.updated_at).toLocaleString()}
              />

              {options?.map((item) => {
                return (
                  <Fragment>
                    <SimpleLabelValue
                      label="Option Name"
                      value={item?.option_name || ""}
                    />
                    <SimpleLabelValue label="Price" value={item?.price || ""} />
                  </Fragment>
                );
              })}

              {/* Additional data fields */}
              <SimpleLabelValue
                label="Available Dates"
                value={data?.available_dates || "N/A"}
              />
              <SimpleLabelValue
                label="Location"
                value={data?.location || "N/A"}
              />
              <SimpleLabelValue
                label="Duration"
                value={data?.duration || "N/A"}
              />
              <SimpleLabelValue
                label="Inclusions"
                value={data?.inclusions || "N/A"}
              />
              <SimpleLabelValue
                label="Group Price per Person"
                value={data?.group_price_per_person || "N/A"}
              />
              <SimpleLabelValue
                label="Group Price per Speaker"
                value={data?.group_price_per_speaker || "N/A"}
              />
              <SimpleLabelValue
                label="Trip Details"
                value={data?.trip_details || "N/A"}
              />
              {/* Display all images */}
              <h2>Images</h2>

              <img src={`${backendUrlImages}${data?.image_1}`} alt="Image 1" />
              <img src={`${backendUrlImages}${data?.image_2}`} alt="Image 2" />
              <img src={`${backendUrlImages}${data?.image_3}`} alt="Image 3" />
              <img src={`${backendUrlImages}${data?.image_4}`} alt="Image 4" />
              <img src={`${backendUrlImages}${data?.image_5}`} alt="Image 5" />
            </div>
          </CustomFormWrapper>
        </MySideDrawer>
      </div>
    );
  }
};

export default ViewOneTrip;
