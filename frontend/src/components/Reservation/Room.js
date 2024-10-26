import React, { useEffect, useState } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import Checkbox from "../../CoreComponent/Checkbox/index";
import DateInput from "../../CoreComponent/Date";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import axios from 'axios'
const RoomForm = ({ openRoom, setOpenRoom }) => {
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

    //     id	bigint unsigned	NO	PRI		auto_increment
    // reservation_id	bigint unsigned	NO	MUL
    // room_type	enum('Single','Double','Triple')	NO
    // occupant_name	varchar(255)	YES
    // special_requests	text	YES
    // check_in_date	datetime	NO
    // check_out_date	datetime	NO
    // late_check_out	tinyint(1)	NO		0
    // early_check_in	tinyint(1)	NO		0
    
    // total_nights	int	NO

    // user_type	enum('main','companion')	NO
    // is_delete	tinyint(1)	NO		0

    // cost	decimal(10,2)	YES
    // additional_cost	decimal(10,2)	YES		0.00
    // update_deadline	datetime	YES
    // is_confirmed	tinyint(1)	YES		0
    // confirmation_message_pdf	text	YES
    
    // last_user_update_at	timestamp	YES
    // last_admin_update_at	timestamp	YES
    const handleSubmit = (e) => {

    // e.preventDefault();

    const formData = {
      // reservation_id ,
      room_type:   roomType,
      occupant_name: occupantName,
      special_requests: specialRequests,
      cost: cost,
      update_deadline: updateDeadline,
      check_in_date: checkInDate,
      check_out_date: checkOutDate,
      late_check_out: lateCheckOut,
      early_check_in: earlyCheckIn,
    };
  

    axios
      .post("http://127.0.0.1:8000/api/room", formData)
      .then((response) => {
        // Handle success
        console.log("Room data submitted successfully:", response.data);
        setErrorMsg(""); // Clear any previous error
      })
      .catch((error) => {
        // Handle error
        console.error("There was an error submitting the room data:", error);
        setErrorMsg("Failed to submit room data. Please try again.");
      });
     
    }
    useEffect(()=>{
      handleSubmit()
    })
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
