import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import Checkbox from "../../CoreComponent/Checkbox/index";
import DateInput from "../../CoreComponent/Date";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../CoreComponent/SideDrawer";

const RoomForm = ({openRoom , setOpenRoom}) => {
  const [roomType, setRoomType] = useState("");
  const [occupantName, setOccupantName] = useState("");
  const [specialRequests, setSpecialRequests] = useState("");
  const [cost, setCost] = useState("0.00");
  const [updateDeadline, setUpdateDeadline] = useState("");
  const [checkInDate, setCheckInDate] = useState("");
  const [checkOutDate, setCheckOutDate] = useState("");
  const [lateCheckOut, setLateCheckOut] = useState(false);
  const [earlyCheckIn, setEarlyCheckIn] = useState(false);
  const [errorMsg, setErrorMsg] = useState("");

  const options = [
    { value: "Single", label: "Single" },
    { value: "Double", label: "Double" },
    { value: "Triple", label: "Triple" },
  ];

  const handleSubmit = (e) => {
    e.preventDefault();
    const formData = {
      roomType,
      occupantName,
      specialRequests,
      cost,
      updateDeadline,
      checkInDate,
      checkOutDate,
      lateCheckOut,
      earlyCheckIn,
    };
  };

  return (
    <MySideDrawer isOpen={openRoom} setIsOpen={setOpenRoom}>
      <CustomFormWrapper
        title="Room Information"
        handleSubmit={handleSubmit}
        setOpenForm={setOpenRoom}
      >
        <form className="room-form-container">
          <Select
            options={options}
            value={roomType}
            setValue={setRoomType}
            errorMsg={errorMsg}
            label="Room Type"
            required={true}
          />
          <Input
            label="Occupant Name"
            type="text"
            inputValue={occupantName}
            setInputValue={setOccupantName}
            placeholder="Enter occupant name"
          />
          <Input
            label="Special Requests"
            type="text"
            inputValue={specialRequests}
            setInputValue={setSpecialRequests}
            placeholder="Enter any special requests"
          />
          <Input
            label="Cost"
            type="number"
            inputValue={cost}
            setInputValue={setCost}
            placeholder="Enter cost"
          />
          <DateInput
            label="Check In Date"
            type="datetime-local"
            inputValue={checkInDate}
            setInputValue={setCheckInDate}
          />
          <DateInput
            label="Check Out Date"
            type="datetime-local"
            inputValue={checkOutDate}
            setInputValue={setCheckOutDate}
          />
          <Checkbox
            label="Late Check Out?"
            checkboxValue={lateCheckOut}
            setCheckboxValue={setLateCheckOut}
            icon={""}
            errorMsg={""}
          />
          <Checkbox
            label="Early Check In?"
            checkboxValue={earlyCheckIn}
            setCheckboxValue={setEarlyCheckIn}
            icon={""}
            errorMsg={""}
          />
          <DateInput
            label="Update Deadline"
            type="datetime-local"
            inputValue={updateDeadline}
            setInputValue={setUpdateDeadline}
          />
        </form>{" "}
      </CustomFormWrapper>
    </MySideDrawer>
  );
};

export default RoomForm;
