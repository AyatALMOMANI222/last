import React, { useState } from "react";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import DateInput from "../../../CoreComponent/Date";
import ImageUpload from "../../../CoreComponent/ImageUpload"; // Use your ImageUpload component
import axios from "axios";
import "./style.scss";

const CreateTrip = ({ isOpen, setIsOpen }) => {
  // State for trip parameters
  const [tripType, setTripType] = useState("private");
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [additionalInfo, setAdditionalInfo] = useState("");
  const [image1, setImage1] = useState(null);
  const [image2, setImage2] = useState(null);
  const [image3, setImage3] = useState(null);
  const [image4, setImage4] = useState(null);
  const [image5, setImage5] = useState(null);
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
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    const formData = new FormData();

    // Append all fields to formData
    formData.append("trip_type", tripType);
    formData.append("name", name);
    formData.append("description", description);
    formData.append("additional_info", additionalInfo);

    // Append images individually
    formData.append("images[0]", image1 || null);
    formData.append("images[1]", image2 || null);
    formData.append("images[2]", image3 || null);
    formData.append("images[3]", image4 || null);
    formData.append("images[4]", image5 || null);

    formData.append("price_per_person", pricePerPerson);
    formData.append("price_for_two", priceForTwo);
    formData.append("price_for_three_or_more", priceForThreeOrMore);

    formData.append("inclusions", inclusions);
    formData.append("group_price_per_person", groupPricePerPerson);
    formData.append("group_price_per_speaker", groupPricePerSpeaker);
    formData.append("location", location);
    formData.append("duration", duration);
    formData.append("available_dates", availableDates);
    formData.append("trip_details", tripDetails);

    try {
      const response = await axios.post(
        `${BaseUrl}/trips`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

    } catch (error) {
      console.error(
        "Error adding trip:",
        error.response ? error.response.data : error
      );
    }
  };

  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Create a New Trip"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <form className="trip-form-container">
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

            {/* Using the ImageUpload component for image uploads */}
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
            <ImageUpload
              label="Image 3"
              allowedExtensions={["jpg", "png", "jpeg"]}
              inputValue={image3}
              setInputValue={setImage3}
            />
            <ImageUpload
              label="Image 4"
              allowedExtensions={["jpg", "png", "jpeg"]}
              inputValue={image4}
              setInputValue={setImage4}
            />
            <ImageUpload
              label="Image 5"
              allowedExtensions={["jpg", "png", "jpeg"]}
              inputValue={image5}
              setInputValue={setImage5}
            />

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
              setInputValue={(value) => setPriceForTwo(parseFloat(value) || 0)}
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
            <Input
              label="Inclusions"
              inputValue={inclusions}
              setInputValue={setInclusions}
              placeholder="Enter inclusions"
            />
            <Input
              label="Group Price per Person"
              inputValue={groupPricePerPerson}
              setInputValue={(value) =>
                setGroupPricePerPerson(parseFloat(value) || 0)
              }
              placeholder="Enter group price per person"
              type="number"
            />
            <Input
              label="Group Price per Speaker"
              inputValue={groupPricePerSpeaker}
              setInputValue={(value) =>
                setGroupPricePerSpeaker(parseFloat(value) || 0)
              }
              placeholder="Enter group price per speaker"
              type="number"
            />
            <Input
              label="Location"
              inputValue={location}
              setInputValue={setLocation}
              placeholder="Enter location"
            />
            <Input
              label="Duration (in hours/days)"
              inputValue={duration}
              setInputValue={(value) => setDuration(parseInt(value) || 0)}
              placeholder="Enter duration"
              type="number"
            />
            <DateInput
              label="Available Dates"
              inputValue={availableDates}
              setInputValue={setAvailableDates}
            />
            <Input
              label="Trip Details"
              inputValue={tripDetails}
              setInputValue={setTripDetails}
              placeholder="Enter trip details"
            />
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default CreateTrip;
