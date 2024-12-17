import React, { Fragment, useEffect, useState } from "react";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import DateInput from "../../../CoreComponent/Date";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import axios from "axios";
import { toast } from "react-toastify";
import SVG from "react-inlinesvg";
import "./style.scss";
import { deleteIcon } from "../../../icons";

const AvailableDatesManager = ({ availableDates, setAvailableDates }) => {
  const [dateInputs, setDateInputs] = useState([""]);

  const handleDateChange = (value, index) => {
    const updatedDates = [...dateInputs];
    updatedDates[index] = value;
    setDateInputs(updatedDates);
    const validDates = updatedDates.filter((date) => date.trim() !== "");
    setAvailableDates(validDates);
  };

  const addDateInput = () => {
    setDateInputs([...dateInputs, ""]);
  };

  const removeDateInput = (index) => {
    const updatedDates = dateInputs.filter((_, i) => i !== index);
    setDateInputs(updatedDates);
    const validDates = updatedDates.filter((date) => date.trim() !== "");
    setAvailableDates(validDates);
  };

  return (
    <div className="available-dates-manager">
      <div className="date-inputs">
        {dateInputs.map((inputValue, index) => (
          <div key={index} className="date-input-group-test">
            <DateInput
              label={`Available Date ${index + 1}`}
              inputValue={inputValue}
              setInputValue={(value) => handleDateChange(value, index)}
            />
            <SVG
              className="delete-icon5"
              src={deleteIcon}
              onClick={() => removeDateInput(index)}
            />
          </div>
        ))}
        <button type="button" className="add-input-btn" onClick={addDateInput}>
          Add Another Date
        </button>
      </div>
    </div>
  );
};

const CreateTrip = ({ isOpen, setIsOpen, fetchTrips }) => {
  // State for trip parameters
  const [tripType, setTripType] = useState("private");
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [additionalInfo, setAdditionalInfo] = useState("");
  const [image1, setImage1] = useState(null);
  const [image2, setImage2] = useState(null);
  const [pricePerPerson, setPricePerPerson] = useState(0);
  const [priceForTwo, setPriceForTwo] = useState(0);
  const [priceForThreeOrMore, setPriceForThreeOrMore] = useState(0);
  const [inclusions, setInclusions] = useState("");
  const [groupPricePerPerson, setGroupPricePerPerson] = useState(0);
  const [groupPricePerSpeaker, setGroupPricePerSpeaker] = useState(0);
  const [location, setLocation] = useState("");
  const [duration, setDuration] = useState(0);
  const [availableDates, setAvailableDates] = useState("");
  const [tripDetails, setTripDetails] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState(0);

  const getConference = () => {
    const url = `${BaseUrl}/conferences/all`;
    axios
      .get(url)
      .then((response) => {
        console.log(response.data.data);

        setAllConference(
          response.data.data?.map((item) => {
            return {
              label: item?.title,
              value: item?.title,
              id: item?.id,
            };
          })
        );
      })
      .catch((error) => {
        console.log("erooooooor");
      });
  };
  const resetForm = () => {
    setTripType("private");
    setName("");
    setDescription("");
    setAdditionalInfo("");
    setImage1(null);
    setImage2(null);
    setPricePerPerson(0);
    setPriceForTwo(0);
    setPriceForThreeOrMore(0);
    setInclusions("");
    setGroupPricePerPerson(0);
    setGroupPricePerSpeaker(0);
    setLocation("");
    setDuration(0);
    setAvailableDates("");
    setTripDetails("");
    setConferenceId(0);
    setAllConference([]); // If you want to reset all conference data as well
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    const formData = new FormData();

    // Append all fields to formData
    formData.append("conference_id", conferenceId.id);

    formData.append("trip_type", tripType);
    formData.append("name", name);
    formData.append("description", description);
    formData.append("additional_info", additionalInfo);

    // Append images individually
    formData.append("images[0]", image1 || null);
    formData.append("images[1]", image2 || null);
    formData.append("images[2]", image2 || null);
    formData.append("images[3]", image2 || null);
    formData.append("images[4]", image2 || null);

    formData.append("price_per_person", pricePerPerson);
    formData.append("price_for_two", priceForTwo);
    formData.append("price_for_three_or_more", priceForThreeOrMore);

    formData.append("inclusions", inclusions);
    formData.append("group_accompanying_price", groupPricePerPerson);
    formData.append("location", location);
    if (tripType == "group") {
      formData.append("duration", duration);
      formData.append("available_dates", availableDates);
      formData.append("trip_details", tripDetails);
    } else {
      formData.append("duration", 0);
      formData.append("available_dates", null);
      formData.append("trip_details", null);
    }

    try {
      const response = await axios.post(`${BaseUrl}/trips`, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      resetForm();
      toast.success("The data was updated successfully!");
      setIsOpen(false);
      fetchTrips();
    } catch (error) {
      console.error(
        "Error adding trip:",
        error.response ? error.response.data : error
      );
    }
  };
  useEffect(() => {
    getConference();
  }, [isOpen]);

  useEffect(() => {
    console.log(tripType);
  }, [tripType]);
  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Create a New Trip"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <form className="trip-form-container7">
            <Select
              options={allConference}
              value={conferenceId}
              setValue={(option) => setConferenceId(option)}
              label="Conference"
              errorMsg={""}
            />
            <Select
              options={[
                { value: "private", label: "Private" },
                { value: "group", label: "Group" },
              ]}
              value={{ value: tripType, label: tripType }}
              setValue={(option) => setTripType(option.value)}
              label="Trip Type"
              errorMsg={""}
            />
            <Input
              label="Trip Name"
              inputValue={name}
              setInputValue={setName}
              placeholder="Enter trip name"
            />
            <Input
              label="Description"
              inputValue={description}
              setInputValue={setDescription}
              placeholder="Enter trip description"
            />
            <Input
              label="Additional Info"
              inputValue={additionalInfo}
              setInputValue={setAdditionalInfo}
              placeholder="Enter additional info"
            />

            <ImageUpload
              label="Image 1"
              allowedExtensions={["jpg", "png", "jpeg"]}
              inputValue={image1}
              setInputValue={setImage1}
            />
            <ImageUpload
              label="Image 2"
              allowedExtensions={["jpg", "png", "jpeg"]}
              inputValue={image2}
              setInputValue={setImage2}
            />

            {tripType === "private" && (
              <Fragment>
                <Input
                  label="Price per Person"
                  inputValue={pricePerPerson}
                  setInputValue={(value) =>
                    setPricePerPerson(parseFloat(value) || 0)
                  }
                  placeholder="Enter price per person"
                  type="number"
                />
                <Input
                  label="Price for Two"
                  inputValue={priceForTwo}
                  setInputValue={(value) =>
                    setPriceForTwo(parseFloat(value) || 0)
                  }
                  placeholder="Enter price for two"
                  type="number"
                />
                <Input
                  label="Price for Three or More"
                  inputValue={priceForThreeOrMore}
                  setInputValue={(value) =>
                    setPriceForThreeOrMore(parseFloat(value) || 0)
                  }
                  placeholder="Enter price for three or more"
                  type="number"
                />
              </Fragment>
            )}

            <Input
              label="Inclusions"
              inputValue={inclusions}
              setInputValue={setInclusions}
              placeholder="Enter inclusions"
            />
            {tripType === "group" && (
              <Fragment>
                <Input
                  label="Price per Companion"
                  inputValue={groupPricePerPerson}
                  setInputValue={(value) =>
                    setGroupPricePerPerson(parseFloat(value) || 0)
                  }
                  placeholder="Enter group price per person"
                  type="number"
                />
              </Fragment>
            )}
            <Input
              label="Location"
              inputValue={location}
              setInputValue={setLocation}
              placeholder="Enter location"
            />
            {tripType === "group" && (
              <>
                <Input
                  label="Duration (in hours"
                  inputValue={duration}
                  setInputValue={(value) => setDuration(parseInt(value) || 0)}
                  placeholder="Enter duration"
                  type="number"
                />
                <AvailableDatesManager
                  availableDates={availableDates}
                  setAvailableDates={setAvailableDates}
                />
                <Input
                  label="Trip Details"
                  inputValue={tripDetails}
                  setInputValue={setTripDetails}
                  placeholder="Enter trip details"
                />
              </>
            )}
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default CreateTrip;
