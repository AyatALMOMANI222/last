import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import Checkbox from "../../../CoreComponent/Checkbox";
import DateInput from "../../../CoreComponent/Date";
import deleteIcon from "../../../icons/deleteIcon.svg";
import { useStepper } from "../StepperContext";
import SVG from "react-inlinesvg";
import { getFromLocalStorage, saveToLocalStorage } from "..";
import { toast } from "react-toastify";
import "./style.scss";

const RoomForm = () => {
  const { currentStep, completeStep } = useStepper();

  const initialValue = {
    roomType: "",
    occupantName: "",
    specialRequests: "",
    checkInDate: "",
    checkOutDate: "",
    lateCheckOut: false,
    earlyCheckIn: false,
    totalNights: "",
  };

  const [rooms, setRooms] = useState([initialValue]);

  const options = [
    { value: "Single", label: "Single" },
    { value: "Double", label: "Double" },
    { value: "Triple", label: "Triple" },
  ];

  const addRoom = () => {
    setRooms([...rooms, { ...initialValue }]);
  };

  const deleteRoom = (index) => {
    setRooms(rooms.filter((_, i) => i !== index));
  };

  const handleChange = (index, field, value) => {
    const updatedRooms = rooms.map((room, i) =>
      i === index ? { ...room, [field]: value } : room
    );
    setRooms(updatedRooms);
  };

  const handleSubmit = (e) => {
    toast.success("The data was updated successfully!");
    completeStep(currentStep);
    saveToLocalStorage("otherRooms", rooms);
  };

  useEffect(() => {
    const data = getFromLocalStorage("otherRooms");
    if (data) {
      setRooms(data);
    }
  }, []);

  return (
    <div>
      <div className="add-room-btn-container77">
        <button type="button" onClick={addRoom}>
          Add Room
        </button>
      </div>

      <form className="room-form-container">
        {rooms.map((room, index) => (
          <div className="room-form-stepper-container" key={index}>
            <div className="delete-icon-container">
             <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={() => deleteRoom(index)}
              /> 
            </div>

            <div className="room-form-stepper">
              <Select
                options={options}
                value={room.roomType}
                setValue={(value) => handleChange(index, "roomType", value)}
                label="Room Type"
                required={true}
              />
              <Input
                label="Occupant Name"
                type="text"
                inputValue={room.occupantName}
                setInputValue={(value) =>
                  handleChange(index, "occupantName", value)
                }
                placeholder="Enter occupant name"
              />
              <Input
                label="Special Requests"
                type="text"
                inputValue={room.specialRequests}
                setInputValue={(value) =>
                  handleChange(index, "specialRequests", value)
                }
                placeholder="Enter any special requests"
              />
              <div className="check-in-input-container">
                <Checkbox
                  label="Late Check Out?"
                  checkboxValue={room.lateCheckOut}
                  setCheckboxValue={(value) =>
                    handleChange(index, "lateCheckOut", value)
                  }
                />
              </div>
              <DateInput
                label="Check In Date"
                type="datetime-local"
                inputValue={room.checkInDate}
                setInputValue={(value) =>
                  handleChange(index, "checkInDate", value)
                }
              />
              <div className="check-in-input-container">
                <Checkbox
                  label="Early Check In?"
                  checkboxValue={room.earlyCheckIn}
                  setCheckboxValue={(value) =>
                    handleChange(index, "earlyCheckIn", value)
                  }
                />
              </div>
              <DateInput
                label="Check Out Date"
                type="datetime-local"
                inputValue={room.checkOutDate}
                setInputValue={(value) =>
                  handleChange(index, "checkOutDate", value)
                }
              />
              <Input
                label="Total Nights"
                type="text"
                inputValue={room.totalNights}
                setInputValue={(value) =>
                  handleChange(index, "totalNights", value)
                }
                placeholder="Enter Total Nights"
              />
            </div>
          </div>
        ))}
      </form>
      <div className="actions-section">
        <button className="next-button" onClick={() => handleSubmit()}>
          Next
        </button>
      </div>
    </div>
  );
};

export default RoomForm;
