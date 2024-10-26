import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import Checkbox from "../../../CoreComponent/Checkbox/index";
import DateInput from "../../../CoreComponent/Date";
import { toast } from "react-toastify";
import { useStepper } from "../StepperContext";
import { getFromLocalStorage, saveToLocalStorage } from "..";
import "./style.scss";
import Select from "../../../CoreComponent/Select";

const ReservationForm = () => {
  const { currentStep, completedSteps, setCurrentStep, completeStep } =
    useStepper();
  const [checkInDate, setCheckInDate] = useState("");
  const [checkOutDate, setCheckOutDate] = useState("");
  const [lateCheckOut, setLateCheckOut] = useState(false);
  const [earlyCheckIn, setEarlyCheckIn] = useState(false);
  const [totalNights, setTotalNights] = useState(1);
  const [roomType, setRoomType] = useState();
  const options = [
    { value: "Single", label: "Single" },
    { value: "Double", label: "Double" },
    { value: "Triple", label: "Triple" },
  ];
  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");
    const formData = {
      checkInDate,
      checkOutDate,
      lateCheckOut,
      earlyCheckIn,
      totalNights,
      roomType,
    };
    completeStep(currentStep);
    saveToLocalStorage("mainRoom", formData);
  };
  useEffect(() => {
    const data = getFromLocalStorage("mainRoom");
    if (data) {
      setCheckInDate(data?.checkInDate);
      setCheckOutDate(data?.checkOutDate);
      setLateCheckOut(data?.lateCheckOut);
      setEarlyCheckIn(data?.earlyCheckIn);
      setTotalNights(data?.totalNights);
      setRoomType(data?.roomType)
    }
  }, []);
  return (
    <div>
      <form className="reservation-form-container-stepper">
        <Select
          options={options}
          value={roomType}
          setValue={setRoomType}
          label="Room Type"
          required={true}
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
        <div className="check-in-input-container">
          <Checkbox
            label="Early Check In?"
            checkboxValue={earlyCheckIn}
            setCheckboxValue={setEarlyCheckIn}
            icon={""}
            errorMsg={""}
          />
        </div>

        <Input
          label="Total Nights"
          type="number"
          inputValue={totalNights}
          setInputValue={setTotalNights}
          placeholder="Enter total nights"
        />
        <div className="check-in-input-container">
          <Checkbox
            label="Late Check Out?"
            checkboxValue={lateCheckOut}
            setCheckboxValue={setLateCheckOut}
            icon={""}
            errorMsg={""}
          />
        </div>
      </form>
      <div className="actions-section">
        <button
          className={`next-button ${
            !checkInDate || !checkOutDate || !totalNights || !roomType
              ? "disabled"
              : ""
          }`}
          onClick={() => {
            handleSubmit();
          }}
          disabled={!checkInDate || !checkOutDate || !totalNights || !roomType}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default ReservationForm;
