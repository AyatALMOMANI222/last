import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import DateInput from "../../CoreComponent/Date";
import Checkbox from "../../CoreComponent/Checkbox";
import "./style.scss";

const AddTripForm = ({ data, setOpen }) => {
  const [availableId, setAvailableId] = useState("");
  const [flightId, setFlightId] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [departureTime, setDepartureTime] = useState("");
  const [price, setPrice] = useState("");
  const [isFree, setIsFree] = useState(false);
  return (
    <div className="add-trip-admin">
      <div className="header">{data.passenger_name}</div>
      <div className="form-section">
        <Input
          label="Available ID"
          placeholder="Enter available ID"
          inputValue={availableId}
          setInputValue={setAvailableId}
          type="text"
          required={true}
        />
        <Input
          label="Flight ID"
          placeholder="Enter flight ID"
          inputValue={flightId}
          setInputValue={setFlightId}
          type="text"
          required={true}
        />
        <DateInput
          label="Departure Date"
          placeholder="Enter departure date"
          inputValue={departureDate}
          setInputValue={setDepartureDate}
          required={true}
        />
        <Input
          label="Departure Time"
          placeholder="Enter departure time"
          inputValue={departureTime}
          setInputValue={setDepartureTime}
          type="time"
          required={true}
        />
        <Input
          label="Price"
          placeholder="Enter price"
          inputValue={price}
          setInputValue={setPrice}
          type="number"
          required={true}
        />
        <Checkbox
          label="Is Free?"
          checkboxValue={isFree}
          setCheckboxValue={setIsFree}
          icon={""}
          errorMsg={""}
        />
      </div>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpen(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn">Submit</button>
      </div>
    </div>
  );
};
export default AddTripForm;
