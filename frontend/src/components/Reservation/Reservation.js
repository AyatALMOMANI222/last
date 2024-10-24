import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox/index";
import DateInput from "../../CoreComponent/Date";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import { toast } from "react-toastify";

const ReservationForm = ({ openReservation, setOpenReservation }) => {
  const [checkInDate, setCheckInDate] = useState("");
  const [checkOutDate, setCheckOutDate] = useState("");
  const [lateCheckOut, setLateCheckOut] = useState(false);
  const [earlyCheckIn, setEarlyCheckIn] = useState(false);
  const [totalNights, setTotalNights] = useState(1);
  const [roomCount, setRoomCount] = useState(1);

  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");

    e.preventDefault();
    const formData = {
      checkInDate,
      checkOutDate,
      lateCheckOut,
      earlyCheckIn,
      totalNights,
      roomCount,
    };
  };

  return (
    <MySideDrawer isOpen={openReservation} setIsOpen={setOpenReservation}>
      <CustomFormWrapper
        title="Reservation Information"
        handleSubmit={handleSubmit}
        setOpenForm={setOpenReservation}
      >
        <form className="reservation-form-container">
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

          <Input
            label="Total Nights"
            type="number"
            inputValue={totalNights}
            setInputValue={setTotalNights}
            placeholder="Enter total nights"
          />
          <Input
            label="Room Count"
            type="number"
            inputValue={roomCount}
            setInputValue={setRoomCount}
            placeholder="Enter room count"
          />
        </form>{" "}
      </CustomFormWrapper>
    </MySideDrawer>
  );
};

export default ReservationForm;
