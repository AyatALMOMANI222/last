import React, { useState } from "react";
import Select from "../../../CoreComponent/Select";
import Input from "../../../CoreComponent/Input";
import DateInput from "../../../CoreComponent/Date";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import axios from "axios";
import Checkbox from "../../../CoreComponent/Checkbox";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import { useAuth } from "../../../common/AuthContext";
import "./style.scss";
const AirportTransferForm = () => {
  const { userId } = useAuth();
  const [isOpen, setIsOpen] = useState(false);
  const [tripType, setTripType] = useState(
    "One-way trip from the airport to the hotel"
  );
  const [arrivalDate, setArrivalDate] = useState("");
  const [arrivalTime, setArrivalTime] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [departureTime, setDepartureTime] = useState("");
  const [flightNumber, setFlightNumber] = useState("");
  const [companionName, setCompanionName] = useState("");
  const [hasCompanion, setHasCompanion] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    try {
      const response = await axios.post(
        `${BaseUrl}/airport-transfer-bookings`,
        {
          userId: userId,
          trip_type: tripType,
          arrival_date: arrivalDate,
          arrival_time: arrivalTime,
          departure_date: departureDate,
          departure_time: departureTime,
          flight_number: flightNumber,
          companion_name: hasCompanion ? companionName : null,
        },
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );

      alert("Request submitted successfully.");
      console.log(response.data);
    } catch (error) {
      alert("An error occurred while submitting the request.");
      console.log(error);
    }
  };

  return (
    <div className="airport-transfer-form">
      {/* <p> Airport Transfer </p> */}
      <button
        className="airport-transfer-button"
        onClick={() => setIsOpen(true)}
      >
        Add Airport Transfer
      </button>

      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Airport Transfer Request"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <form className="airport-transfer-form-container">
            <Select
              options={[
                {
                  value: "One-way trip from the airport to the hotel",
                  label: "One-way trip from the airport to the hotel",
                },
                {
                  value: "One-way trip from the hotel to the airport",
                  label: "One-way trip from the hotel to the airport",
                },
                { value: "Round trip", label: "Round trip" },
              ]}
              value={{ value: tripType, label: tripType }}
              setValue={(option) => setTripType(option.value)}
              label="Trip Type"
            />

            <DateInput
              label="Arrival Date"
              inputValue={arrivalDate}
              setInputValue={setArrivalDate}
              required
            />

            <DateInput
              label="Arrival Time"
              inputValue={arrivalTime}
              setInputValue={setArrivalTime}
              placeholder="Enter Arrival Time"
              type="time"
              required
            />

            <DateInput
              label="Departure Date"
              inputValue={departureDate}
              setInputValue={setDepartureDate}
              placeholder="Enter Departure Date"
              type="date"
            />

            <DateInput
              label="Departure Time"
              inputValue={departureTime}
              setInputValue={setDepartureTime}
              placeholder="Enter Departure Time"
              type="time"
            />

            <Input
              label="Flight Number"
              inputValue={flightNumber}
              setInputValue={setFlightNumber}
              placeholder="Enter Flight Number"
              required
            />

            <Checkbox
              label="Do you have a companion?"
              checkboxValue={hasCompanion}
              setCheckboxValue={setHasCompanion}
            />

            {hasCompanion && (
              <Input
                label="Companion Name"
                inputValue={companionName}
                setInputValue={setCompanionName}
                placeholder="Enter Companion's Name"
              />
            )}
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default AirportTransferForm;
