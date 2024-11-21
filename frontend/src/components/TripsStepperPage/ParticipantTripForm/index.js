import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import { toast } from "react-toastify";
import { nationalitiesOptions } from "../../../constant/index";
import SVG from "react-inlinesvg";
import deleteIcon from "../../../icons/deleteIcon.svg";
import {
  saveToLocalStorage,
  getFromLocalStorage,
} from "../../../common/localStorage";
import { useTripsStepper } from "../StepperContext";
import "./style.scss";
import DateInput from "../../../CoreComponent/Date";

const ParticipantTripForm = () => {
  const intialValue = {
    id: Date.now(),
    name: "",
    nationality: "",
    phone_number: "",
    whatsapp_number: "",
    is_companion: true,
    include_accommodation: false,
    accommodation_stars: "",
    nights_count: "",
  };
  const { currentStep, completeStep } = useTripsStepper();
  const [participants, setParticipants] = useState([intialValue]);
  const addParticipant = () => {
    setParticipants([
      ...participants,
      {
        id: Date.now(),
        name: "",
        nationality: "",
        phone_number: "",
        whatsapp_number: "",
        is_companion: true,
        include_accommodation: false,
        accommodation_stars: "",
        nights_count: "",
      },
    ]);
  };

  const deleteParticipant = (id) => {
    setParticipants(
      participants.filter((participant) => participant.id !== id)
    );
  };

  const handleInputChange = (id, key, value) => {
    const updatedParticipants = participants?.map((participant) =>
      participant.id === id ? { ...participant, [key]: value } : participant
    );
    setParticipants(updatedParticipants);
  };

  const handleSubmit = () => {
    toast.success("The data was updated successfully!");
    completeStep(currentStep);
    saveToLocalStorage("participants", participants);
  };

  useEffect(() => {
    const data = getFromLocalStorage("participants");
    if (data) {
      setParticipants(data);
    }
  }, []);
  return (
    <div className="participant-form-container-stepper">
      <div className="add-button-container">
        <button className="add-button-participant" onClick={addParticipant}>
          Add Participant
        </button>
      </div>
      <div className="all-participants-contaoner">
        {participants?.map((participant) => (
          <div key={participant.id} className="participant-member">
            <div className="delete-button-participant">
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={() => deleteParticipant(participant.id)}
              />{" "}
            </div>
            <div className="participant-member-one">
              <Input
                label="Name"
                placeholder="Enter name"
                inputValue={participant.name}
                setInputValue={(value) =>
                  handleInputChange(participant.id, "name", value)
                }
                className="name-input"
              />
              <Select
                options={nationalitiesOptions}
                value={participant.nationality}
                setValue={(value) =>
                  handleInputChange(participant.id, "nationality", value)
                }
                label="Nationality"
              />

              <PhoneNumberInput
                label="Phone Number"
                placeholder="Enter phone number"
                phone={participant.phone_number}
                setPhone={(value) =>
                  handleInputChange(participant.id, "phone_number", value)
                }
              />

              <PhoneNumberInput
                label="WhatsApp Number"
                placeholder="Enter WhatsApp number"
                phone={participant.whatsapp_number}
                setPhone={(value) =>
                  handleInputChange(participant.id, "whatsapp_number", value)
                }
              />

              <DateInput
                label="Check-In Date"
                inputValue={participant.check_in_date}
                setInputValue={(value) =>
                  handleInputChange(participant.id, "check_in_date", value)
                }
                required={true}
              />
              <DateInput
                label="Check-Out Date"
                inputValue={participant.check_out_date}
                setInputValue={(value) =>
                  handleInputChange(participant.id, "check_out_date", value)
                }
                required={true}
              />
              <Input
                label="Accommodation Stars"
                placeholder="Enter accommodation stars"
                inputValue={participant.accommodation_stars}
                setInputValue={(value) =>
                  handleInputChange(
                    participant.id,
                    "accommodation_stars",
                    value
                  )
                }
                className="stars-input"
              />

              <Input
                label="Nights Count"
                placeholder="Enter nights count"
                inputValue={participant.nights_count}
                setInputValue={(value) =>
                  handleInputChange(participant.id, "nights_count", value)
                }
                className="nights-input"
              />
            </div>
          </div>
        ))}
      </div>

      <div className="actions-section">
        <button className="next-button" onClick={handleSubmit}>
          Next
        </button>
      </div>
    </div>
  );
};
export default ParticipantTripForm;
