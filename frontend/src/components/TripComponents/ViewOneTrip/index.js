import React, { Fragment, useEffect, useState } from "react";
import axios from "axios";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import SimpleLabelValue from "../../../components/SimpleLabelValue";
import "./style.scss";
const ViewOneTrip = ({ isOpen, setIsOpen, tripId }) => {
  const [data, setData] = useState(null);
  const [options, setOptions] = useState(null);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const fetchTripData = async (tripId) => {
    if (!tripId) {
      return;
    }
    try {
      const token = localStorage.getItem("token"); // Get the token from localStorage
      const response = await axios.get(`${BaseUrl}/trip/${tripId}`, {
        headers: {
          Authorization: `Bearer ${token}`, // Set the Authorization header
        },
      });
      setOptions(response.data.trip.additional_options);
      setData(response.data?.trip);
    } catch (err) {}
  };
  useEffect(() => {
    tripId && fetchTripData(tripId);
  }, [tripId]);

  if (data && options) {
    return (
      <div>
        <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
          <CustomFormWrapper title="Create a New Trip" setOpenForm={setIsOpen}>
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

              <SimpleLabelValue
                label="Available Dates"
                value={data?.available_dates || "-"}
              />
              <SimpleLabelValue
                label="Location"
                value={data?.location || "-"}
              />
              <SimpleLabelValue
                label="Duration"
                value={data?.duration || "-"}
              />
              <SimpleLabelValue
                label="Inclusions"
                value={data?.inclusions || "-"}
              />
              <SimpleLabelValue
                label="Group Price per Person"
                value={data?.group_price_per_person || "-"}
              />
              <SimpleLabelValue
                label="Group Price per Speaker"
                value={data?.group_price_per_speaker || "-"}
              />
              <SimpleLabelValue
                label="Trip Details"
                value={data?.trip_details || "-"}
              />
            </div>
          </CustomFormWrapper>
        </MySideDrawer>
      </div>
    );
  }
};

export default ViewOneTrip;
