import CustomFormWrapper from "../../../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../../../CoreComponent/SideDrawer";
import Input from "../../../../CoreComponent/Input";
import Select from "../../../../CoreComponent/Select";
import Checkbox from "../../../../CoreComponent/Checkbox";
import PhoneNumberInput from "../../../../CoreComponent/PhoneNumber";
import axios from "axios";
import "./style.scss";
import React, { useEffect, useState } from "react";
import { nationalitiesOptions } from "../../../../constant";

import DateInput from "../../../../CoreComponent/Date";
import "./style.scss";

const AccommodationForm = ({
  includeAccommodation,
  setIncludeAccommodation,
  accommodationStars,
  setAccommodationStars,
  nightsCount,
  setNightsCount,
  checkInDate,
  setCheckInDate,
  checkOutDate,
  setCheckOutDate,
}) => {
  return (
    <form className="accommodation-form">
      <h2>Accommodation Details</h2>

      {/* Include Accommodation Checkbox */}
      <div className="checkbox-container">
        <label>
          <input
            type="checkbox"
            checked={includeAccommodation}
            onChange={(e) => setIncludeAccommodation(e.target.checked)}
          />
          Include Accommodation
        </label>
      </div>

      {/* Accommodation Stars Input */}
      <Input
        label="Accommodation Stars"
        placeholder="Enter star rating (1-5)"
        inputValue={accommodationStars}
        setInputValue={setAccommodationStars}
        type="number"
        required={true}
      />

      {/* Nights Count Input */}
      <Input
        label="Nights Count"
        placeholder="Enter number of nights"
        inputValue={nightsCount}
        setInputValue={setNightsCount}
        type="number"
        required={true}
      />

      {/* Check-In Date Input */}
      <DateInput
        label="Check-In Date"
        inputValue={checkInDate}
        setInputValue={setCheckInDate}
        required={true}
      />

      {/* Check-Out Date Input */}
      <DateInput
        label="Check-Out Date"
        inputValue={checkOutDate}
        setInputValue={setCheckOutDate}
        required={true}
      />
    </form>
  );
};

// OptionsCheckbox Component
const OptionsCheckbox = ({ options, selectedOptions, setSelectedOptions }) => {
  const handleCheckboxChange = (id) => {
    setSelectedOptions((prev) => ({
      ...prev,
      [id]: !prev[id],
    }));
  };

  return (
    <div>
      <div className="available-options-title">Available Options</div>
      {options?.map((option) => (
        <Checkbox
          key={option.id}
          label={`${option.option_name} - ${option.option_description} ($${option.price})`}
          checkboxValue={!!selectedOptions[option?.id]}
          setCheckboxValue={() => handleCheckboxChange(option.id)}
          required={false}
          icon={null}
        />
      ))}
    </div>
  );
};

// ParticipantForm Component
const ParticipantForm = ({ participants, setParticipants }) => {
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

  return (
    <div className="participant-form-container">
      <div className="title-participant">Trip Participants</div>
      <div className="button-section-container">
        <button className="add-button-participant" onClick={addParticipant}>
          Add Participant
        </button>
      </div>

      {participants?.map((participant) => (
        <div key={participant.id} className="participant-member">
          <div className="member-info">
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
              inputValue={participant.whatsapp_number}
              setPhone={(value) =>
                handleInputChange(participant.id, "whatsapp_number", value)
              }
            />

            <Select
              options={[
                { value: true, label: "Yes" },
                { value: false, label: "No" },
              ]}
              value={participant.include_accommodation}
              setValue={(value) =>
                handleInputChange(
                  participant.id,
                  "include_accommodation",
                  value
                )
              }
              label="Include Accommodation"
            />

            <Input
              label="Accommodation Stars"
              placeholder="Enter accommodation stars"
              inputValue={participant.accommodation_stars}
              setInputValue={(value) =>
                handleInputChange(participant.id, "accommodation_stars", value)
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

          <button
            className="delete-button-participant"
            onClick={() => deleteParticipant(participant.id)}
          >
            Delete
          </button>
        </div>
      ))}
    </div>
  );
};

// TripRegisterForm Component
const TripRegisterForm = ({ isOpen, setIsOpen, tripId, options }) => {
  const [selectedOptions, setSelectedOptions] = useState({});
  const [participants, setParticipants] = useState([]);
  const [includeAccommodation, setIncludeAccommodation] = useState(true);
  const [accommodationStars, setAccommodationStars] = useState(5);
  const [nightsCount, setNightsCount] = useState(3);
  const [checkInDate, setCheckInDate] = useState("2024-10-01");
  const [checkOutDate, setCheckOutDate] = useState("2024-10-04");
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Create a map of option names for easy lookup
    const optionMap = options.reduce((map, option) => {
      map[option.id] = option.option_name; // Assuming each option has an `option_name` property
      return map;
    }, {});

    // Transform selectedOptions to the required format
    const formattedOptions = Object.entries(selectedOptions || {}).map(
      ([id, value]) => ({
        option_id: Number(id),
        option_name: optionMap[id] || "", // Get the option name from the map
        value: value,
      })
    );

    // Prepare the data to log
   
      console.log(participants);
    const particpantsData= participants?.map((item)=>{
        return {...item , nationality : item?.nationality?.value , include_accommodation : item?.include_accommodation?.value}
    })
    const dataToLog = {
      trip_id: tripId,
      "name": "John Doe",
      "nationality": "American",
      "phone_number": "1234567890",
      "whatsapp_number": "0987654321",
      "is_companion": false,
      include_accommodation: includeAccommodation,
      accommodation_stars: accommodationStars,
      nights_count: nightsCount,
      check_in_date: checkInDate,
      check_out_date: checkOutDate,
      selectedOptions: formattedOptions,
      companions: particpantsData,
    };

    console.log(dataToLog);

    const token = localStorage.getItem("token");
    // Implement your submission logic here (e.g., POST to API)
  };

  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Register for the trip"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <div>
            <OptionsCheckbox
              options={options}
              selectedOptions={selectedOptions}
              setSelectedOptions={setSelectedOptions}
            />
            <AccommodationForm
              includeAccommodation={includeAccommodation}
              setIncludeAccommodation={setIncludeAccommodation}
              accommodationStars={accommodationStars}
              setAccommodationStars={setAccommodationStars}
              nightsCount={nightsCount}
              setNightsCount={setNightsCount}
              checkInDate={checkInDate}
              setCheckInDate={setCheckInDate}
              checkOutDate={checkOutDate}
              setCheckOutDate={setCheckOutDate}
            />
            <ParticipantForm
              participants={participants}
              setParticipants={setParticipants}
            />
          </div>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default TripRegisterForm;
