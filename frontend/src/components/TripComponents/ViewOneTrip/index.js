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
      console.log(response.data?.trip);

      setData(response.data?.trip);
    } catch (err) {}
  };
  useEffect(() => {
    tripId && fetchTripData(tripId);
  }, [tripId]);

  if (data && options) {
    return (
      <div className="trip-container-sec">
        <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
          <CustomFormWrapper title="View Trip" setOpenForm={setIsOpen}>
            <div className="view-one-trip-container">
              <SimpleLabelValue label="Name" value={data?.name} />

              <SimpleLabelValue label="Trip Type" value={data?.trip_type} />
              <SimpleLabelValue label="Description" value={data?.description} />
              <SimpleLabelValue
                label="Additional Info"
                value={data?.additional_info}
              />
              {data?.trip_type == "private" ? (
                <>
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
                </>
              ) : (
                <></>
              )}

              <SimpleLabelValue
                label="Available Dates"
                value={
                  (data?.available_dates &&
                    data?.available_dates.split(",").map((item) => {
                      return <div> {item} </div>;
                    })) ||
                  "-"
                }
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

              {data?.trip_type !== "private" ? (
                <>
                  <SimpleLabelValue
                    label="Group Price per Companion"
                    value={data?.group_accompanying_price || "-"}
                  />
                </>
              ) : (
                <></>
              )}
            </div>
            {data?.trip_type == "private" && (
              <div className="additional_options">Additional Options</div>
            )}{" "}
            <div className="view-one-trip-container">
              {data?.trip_type == "private" &&
                options?.map((item) => {
                  return (
                    <Fragment>
                      <SimpleLabelValue
                        label="Option Name"
                        value={item?.option_name || ""}
                      />
                      <SimpleLabelValue
                        label="Price"
                        value={item?.price || ""}
                      />
                    </Fragment>
                  );
                })}
            </div>
          </CustomFormWrapper>
        </MySideDrawer>
      </div>
    );
  }
};

export default ViewOneTrip;
