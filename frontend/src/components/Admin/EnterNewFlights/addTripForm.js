import React, { useState } from "react";
import Input from "../../../CoreComponent/Input";
import Checkbox from "../../../CoreComponent/Checkbox";
import DateInput from "../../../CoreComponent/Date";
import SVG from "react-inlinesvg";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import { deleteIcon } from "../../../icons";
import httpService from "../../../common/httpService";

const AddTripForm = ({ isOpen, setIsOpen, flight_id, main_user_id }) => {
  const [trips, setTrips] = useState([
    {
      departure_date: "",
      departure_time: "",
      price: "",
      is_free: false,
      flight_id: flight_id,
    },
  ]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handleAddTrip = () => {
    setTrips([
      ...trips,
      {
        departure_date: "",
        departure_time: "",
        price: "",
        is_free: false,
        flight_id: flight_id,
      },
    ]);
  };

  const handleDeleteTrip = (index) => {
    const updatedTrips = trips.filter((_, idx) => idx !== index);
    setTrips(updatedTrips);
  };

  const handleSave = async () => {
    const token = localStorage.getItem("token");

    // Format trips data for the API
    const formattedTrips = trips.map((trip) => ({
      flight_id: flight_id,
      // main_user_id: main_user_id,
      data: [
        {
          departure_date: trip.departure_date,
          departure_time: trip.departure_time,
          price: trip.price,
          is_free: trip.is_free,
        },
      ],
    }));

    const response = await httpService({
      method: "POST",
      url: `${BaseUrl}/available-flights/all`,
      headers: { Authorization: `Bearer ${token}` },
      data: { flights: formattedTrips },
      showLoader: false,
      withToast: true,
    });
    setTrips([]);
    setIsOpen(false);
    console.log({ response });
  };

  return (
    <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
      <CustomFormWrapper
        title="Add Extra Flight Choices"
        handleSubmit={() => {
          handleSave();
        }}
        setOpenForm={setIsOpen}
        noActions={false}
      >
        <div className="add-trip-form">
          <div className="add-trip-btn-container">
            <button
              className="add-trip-btn"
              type="button"
              onClick={handleAddTrip}
            >
              + Add Trip
            </button>
          </div>
          <div className="trips-container">
            {trips.map((trip, index) => (
              <div className="trip-card" key={index}>
                <div className="trip-card-header">
                  <SVG
                    className="delete-icon"
                    src={deleteIcon}
                    onClick={() => handleDeleteTrip(index)}
                  />
                </div>
                <div className="trip-form">
                  <DateInput
                    label="Departure Date"
                    placeholder="Enter departure date"
                    inputValue={trip.departure_date}
                    setInputValue={(value) => {
                      const updatedTrips = [...trips];
                      updatedTrips[index].departure_date = value;
                      setTrips(updatedTrips);
                    }}
                    required={true}
                  />
                  <Input
                    label="Departure Time"
                    placeholder="Enter departure time"
                    inputValue={trip.departure_time}
                    setInputValue={(value) => {
                      const updatedTrips = [...trips];
                      updatedTrips[index].departure_time = value;
                      setTrips(updatedTrips);
                    }}
                    type="time"
                    required={true}
                  />
                  <Input
                    label="Price"
                    placeholder="Enter price"
                    inputValue={trip.price}
                    setInputValue={(value) => {
                      const updatedTrips = [...trips];
                      updatedTrips[index].price = value;
                      setTrips(updatedTrips);
                    }}
                    type="number"
                    required={true}
                  />
                  <div className="free-trip-checkbox">
                    <Checkbox
                      label="Is Free?"
                      checkboxValue={trip.is_free}
                      setCheckboxValue={(value) => {
                        const updatedTrips = [...trips];
                        updatedTrips[index].is_free = value;
                        setTrips(updatedTrips);
                      }}
                      icon={""}
                      errorMsg={""}
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </CustomFormWrapper>
    </MySideDrawer>
  );
};

export default AddTripForm;
