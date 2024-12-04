import React, { useState } from "react";
import axios from "axios";
import Select from "../../../CoreComponent/Select";
import Input from "../../../CoreComponent/Input";
import DateInput from "../../../CoreComponent/Date";
import Checkbox from "../../../CoreComponent/Checkbox";
import { useAuth } from "../../../common/AuthContext";
import { toast } from "react-toastify";
import "./style.scss";

const TripTypeOptions = [
  {
    value: "One-way trip from the airport to the hotel",
    label: "One-way trip from the airport to the hotel",
  },
  {
    value: "One-way trip from the hotel to the airport",
    label: "One-way trip from the hotel to the airport",
  },
  { value: "Round trip", label: "Round trip" },
];

const AirportTransferForm = () => {
  const { userId } = useAuth();
  const [formData, setFormData] = useState({
    tripType: "",
    arrivalDate: "",
    arrivalTime: "",
    departureDate: "",
    departureTime: "",
    flightNumber: "",
    companionName: "",
    hasCompanion: false,
  });

  const {
    tripType,
    arrivalDate,
    arrivalTime,
    departureDate,
    departureTime,
    flightNumber,
    companionName,
    hasCompanion,
  } = formData;
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handleChange = (field) => (value) => {
    setFormData((prevData) => ({ ...prevData, [field]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    try {
      const response = await axios.post(
        `${BaseUrl}/airport-transfer-bookings`,
        {
          userId,
          trip_type: tripType,
          arrival_date: arrivalDate,
          arrival_time: arrivalTime,
          departure_date: departureDate,
          departure_time: departureTime,
          flight_number: flightNumber,
          companion_name: hasCompanion ? companionName : null,
        },
        { headers: { Authorization: `Bearer ${token}` } }
      );
      toast.success("Request submitted successfully.");
    } catch (error) {
      toast.error("An error occurred while submitting the request.");
    }
  };

  return (
    <div className="airport-transfer-form-section">
      <div className="airport-transfer-form">
        <form
          className="airport-transfer-form-container"
          onSubmit={handleSubmit}
        >
          <h3>Airport Transfer Request</h3>

          <Select
            options={TripTypeOptions}
            value={{ value: tripType, label: tripType }}
            setValue={(option) => handleChange("tripType")(option.value)}
            label="Trip Type"
          />

          <DateInput
            label="Arrival Date"
            inputValue={arrivalDate}
            setInputValue={handleChange("arrivalDate")}
            required
          />

          <DateInput
            label="Arrival Time"
            inputValue={arrivalTime}
            setInputValue={handleChange("arrivalTime")}
            placeholder="Enter Arrival Time"
            type="time"
            required
          />

          <DateInput
            label="Departure Date"
            inputValue={departureDate}
            setInputValue={handleChange("departureDate")}
            placeholder="Enter Departure Date"
            type="date"
          />

          <DateInput
            label="Departure Time"
            inputValue={departureTime}
            setInputValue={handleChange("departureTime")}
            placeholder="Enter Departure Time"
            type="time"
          />

          <Input
            label="Flight Number"
            inputValue={flightNumber}
            setInputValue={handleChange("flightNumber")}
            placeholder="Enter Flight Number"
            required
          />

          <Checkbox
            label="Do you have a companion?"
            checkboxValue={hasCompanion}
            setCheckboxValue={handleChange("hasCompanion")}
          />

          {hasCompanion && (
            <Input
              label="Companion Name"
              inputValue={companionName}
              setInputValue={handleChange("companionName")}
              placeholder="Enter Companion's Name"
            />
          )}

          <div className="form-action">
            <button type="submit" className="submit-btn">
              Submit
            </button>
          </div>
        </form>
      </div>{" "}
    </div>
  );
};

export default AirportTransferForm;
