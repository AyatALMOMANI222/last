import React, { useEffect, useState } from "react";
import axios from "axios";
import Input from "../../../CoreComponent/Input";
import DateInput from "../../../CoreComponent/Date";
import Select from "../../../CoreComponent/Select";
import "./style.scss";
import { toast } from "react-toastify";

const GalaDinner = ({ isOpen, setIsOpen }) => {
  // Defining the state variables
  const [dinnerDate, setDinnerDate] = useState("");
  const [restaurantName, setRestaurantName] = useState("");
  const [location, setLocation] = useState("");
  const [gatheringPlace, setGatheringPlace] = useState("");
  const [transportationMethod, setTransportationMethod] = useState("");
  const [gatheringTime, setGatheringTime] = useState("");
  const [dinnerTime, setDinnerTime] = useState("");
  const [duration, setDuration] = useState("");
  const [dressCode, setDressCode] = useState("");
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState("");
  const token = localStorage.getItem("token");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getConference = () => {
    const url = `${BaseUrl}/conferences/all`;

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`, // مرر الـ token هنا
        },
      })
      .then((response) => {
        console.log(response);

        setAllConference(
          response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          })
        );
      })
      .catch((error) => {});
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();

    const dinnerDetails = {
      conference_id: conferenceId?.value,
      dinner_date: dinnerDate,
      restaurant_name: restaurantName,
      location,
      gathering_place: gatheringPlace,
      transportation_method: transportationMethod,
      gathering_time: gatheringTime,
      dinner_time: dinnerTime,
      duration: parseInt(duration),
      dress_code: dressCode,
    };

    const token = localStorage.getItem("token");

    try {
      const response = await axios.post(
        `${BaseUrl}/dinner-details`,
        dinnerDetails,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      console.log("Response:", response.data);
      toast.success(response?.data?.message);
    } catch (error) {
      console.error("There was an error submitting the dinner details!", error);
    }
  };

  return (
    <div className="dinner-container5">
    <form className="trip-form-container5" onSubmit={handleSubmit}>
      <h2 className="form-title">Gala Dinner Details</h2>
      <Select
        options={allConference}
        value={conferenceId}
        setValue={setConferenceId}
        label="Conference Id"
        errorMsg={""}
      />
      <DateInput
        label="Dinner Date"
        inputValue={dinnerDate}
        setInputValue={setDinnerDate}
        required={true}
      />
      <Input
        label="Restaurant Name"
        inputValue={restaurantName}
        setInputValue={setRestaurantName}
        placeholder="Enter Restaurant Name"
        required={true}
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Location"
        inputValue={location}
        setInputValue={setLocation}
        placeholder="Enter Location"
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Gathering Place"
        inputValue={gatheringPlace}
        setInputValue={setGatheringPlace}
        placeholder="Enter Gathering Place"
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Transportation Method"
        inputValue={transportationMethod}
        setInputValue={setTransportationMethod}
        placeholder="Enter Transportation Method"
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Gathering Time"
        inputValue={gatheringTime}
        setInputValue={setGatheringTime}
        type="time"
        required={true}
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Dinner Time"
        inputValue={dinnerTime}
        setInputValue={setDinnerTime}
        type="time"
        required={true}
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Duration (minutes)"
        inputValue={duration}
        setInputValue={setDuration}
        type="number"
        placeholder="Enter Duration"
        className="input-field" // Add class for custom styling
      />
      <Input
        label="Dress Code"
        inputValue={dressCode}
        setInputValue={setDressCode}
        placeholder="Enter Dress Code"
        className="input-field" // Add class for custom styling
      />
      <div className="submit-button-container">
        <button type="submit" className="submit-button2">
          Submit
        </button>
      </div>
    </form>
    </div>

  );
};

export default GalaDinner;
