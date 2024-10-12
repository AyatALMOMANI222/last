import CustomFormWrapper from "../../../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../../../CoreComponent/SideDrawer";
import Input from "../../../../CoreComponent/Input";
import Select from "../../../../CoreComponent/Select";
import Checkbox from "../../../../CoreComponent/Checkbox";
import axios from "axios";
import "./style.scss";
import React, { useEffect, useState } from "react";

const OptionsCheckbox = ({ options, selectedOptions, setSelectedOptions }) => {
    const handleCheckboxChange = (id) => {
        setSelectedOptions((prev) => ({
            ...prev,
            [id]: !prev[id],
        }));
    };

    return (
        <div>
            <h3>Select Options:</h3>
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

const ParticipantForm = ({ participants, setParticipants }) => {
    const addParticipant = () => {
        setParticipants([
            ...participants,
            {
                id: Date.now(),
                user_id: "",
                trip_id: "",
                name: "",
                nationality: "",
                phone_number: "",
                whatsapp_number: "",
                is_companion: false,
                include_accommodation: false,
                accommodation_stars: "",
                nights_count: "",
            },
        ]);
    };

    const deleteParticipant = (id) => {
        setParticipants(participants.filter((participant) => participant.id !== id));
    };

    const handleInputChange = (id, key, value) => {
        const updatedParticipants = participants?.map((participant) =>
            participant.id === id ? { ...participant, [key]: value } : participant
        );
        setParticipants(updatedParticipants);
    };

    return (
        <div className="participant-form-container">
            <div className="title-participant"> Trip Participants</div>
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
                            setInputValue={(value) => handleInputChange(participant.id, "name", value)}
                            className="name-input"
                        />

                        <Input
                            label="Nationality"
                            placeholder="Enter nationality"
                            inputValue={participant.nationality}
                            setInputValue={(value) => handleInputChange(participant.id, "nationality", value)}
                            className="nationality-input"
                        />

                        <Input
                            label="Phone Number"
                            placeholder="Enter phone number"
                            inputValue={participant.phone_number}
                            setInputValue={(value) => handleInputChange(participant.id, "phone_number", value)}
                            className="phone-input"
                        />

                        <Input
                            label="WhatsApp Number"
                            placeholder="Enter WhatsApp number"
                            inputValue={participant.whatsapp_number}
                            setInputValue={(value) => handleInputChange(participant.id, "whatsapp_number", value)}
                            className="whatsapp-input"
                        />

                        <Select
                            options={[{ value: true, label: "Yes" }, { value: false, label: "No" }]}
                            value={participant.is_companion}
                            setValue={(value) => handleInputChange(participant.id, "is_companion", value)}
                            label="Is Companion"
                        />

                        <Select
                            options={[{ value: true, label: "Yes" }, { value: false, label: "No" }]}
                            value={participant.include_accommodation}
                            setValue={(value) => handleInputChange(participant.id, "include_accommodation", value)}
                            label="Include Accommodation"
                        />

                        <Input
                            label="Accommodation Stars"
                            placeholder="Enter accommodation stars"
                            inputValue={participant.accommodation_stars}
                            setInputValue={(value) => handleInputChange(participant.id, "accommodation_stars", value)}
                            className="stars-input"
                        />

                        <Input
                            label="Nights Count"
                            placeholder="Enter nights count"
                            inputValue={participant.nights_count}
                            setInputValue={(value) => handleInputChange(participant.id, "nights_count", value)}
                            className="nights-input"
                        />
                    </div>

                    <button className="delete-button-participant" onClick={() => deleteParticipant(participant.id)}>
                        Delete
                    </button>
                </div>
            ))}
        </div>
    );
};

const TripRegisterForm = ({ isOpen, setIsOpen, tripId, options }) => {
    const [selectedOptions, setSelectedOptions] = useState({});
    const [participants, setParticipants] = useState([]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        // Create a map of option names for easy lookup
        const optionMap = options.reduce((map, option) => {
            map[option.id] = option.option_name; // Assuming each option has an `option_name` property
            return map;
        }, {});

        // Transform selectedOptions to the required format
        const formattedOptions = Object.entries(selectedOptions || {}).map(([id, value]) => ({
            option_id: Number(id),
            option_name: optionMap[id] || "", // Get the option name from the map
            value: value,
        }));

        // Prepare the data to log
        const dataToLog = {
            selectedOptions: formattedOptions,
            participants: participants,
        };

        console.log(dataToLog);
        
        const token = localStorage.getItem("token");
    };

    useEffect(() => {
        console.log({ options });
    }, [options]);

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
