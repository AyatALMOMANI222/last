import React, { Fragment, useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../../CoreComponent/Input/index";
import Select from "../../../CoreComponent/Select/index";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";
import "./style.scss";

const EditTrip = ({ isOpen, setIsOpen, tripId }) => {
  const [trip, setTrip] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  // States for trip data
  const [tripType, setTripType] = useState(""); // Trip type state
  const [tripName, setTripName] = useState("");
  const [tripDescription, setTripDescription] = useState("");
  const [additionalInfo, setAdditionalInfo] = useState(""); // Additional info state
  const [tripPricePerPerson, setTripPricePerPerson] = useState("");
  const [tripPriceForTwo, setTripPriceForTwo] = useState("");
  const [tripPriceForThreeOrMore, setTripPriceForThreeOrMore] = useState("");
  const [additionalOptions, setAdditionalOptions] = useState([]);
  const [groupPricePerPerson, setGroupPricePerPerson] = useState(0);
  const [groupPricePerSpeaker, setGroupPricePerSpeaker] = useState(0);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  // Get token from localStorage
  const token = localStorage.getItem("token");

  useEffect(() => {
    const fetchTrip = async () => {
      if (!tripId) return;
      try {
        const response = await axios.get(`${BaseUrl}/trip/${tripId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        const fetchedTrip = response.data.trip;
        console.log(fetchedTrip);

        setTrip(fetchedTrip);
        setTripType(fetchedTrip.trip_type); // Set trip type
        setTripName(fetchedTrip.name);
        setTripDescription(fetchedTrip.description);
        setTripPricePerPerson(fetchedTrip.price_per_person);
        setTripPriceForTwo(fetchedTrip.price_for_two);
        setTripPriceForThreeOrMore(fetchedTrip.price_for_three_or_more);
        setAdditionalInfo(fetchedTrip.additional_info); // Set additional info
        setAdditionalOptions(fetchedTrip.additional_options);
        setGroupPricePerPerson(fetchedTrip.group_accompanying_price);
        setGroupPricePerSpeaker(fetchedTrip.group_price_per_speaker);
        setLoading(false);
      } catch (error) {
        setError("Error fetching trip data");
        setLoading(false);
      }
    };

    fetchTrip();
  }, [tripId, token]);

  const handleUpdateTripAndOptions = async (e) => {
    e.preventDefault();

    const updatedTripData = {
      trip_type: tripType,
      name: tripName,
      description: tripDescription,
      additional_info: additionalInfo,
      price_per_person: tripPricePerPerson,
      price_for_two: tripPriceForTwo,
      price_for_three_or_more: tripPriceForThreeOrMore,
      group_accompanying_price: groupPricePerPerson,
      options: additionalOptions.map((option) => ({
        id: option.id,
        price: option.price,
      })),
    };

    try {
      await axios.post(`${BaseUrl}/trips_option/${tripId}`, updatedTripData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      toast.success("Trip and options updated successfully!");
      setIsOpen(false);
    } catch (error) {
      console.error("Error updating trip and options:", error);
    }
  };

  const tripTypeOptions = [
    { label: "Private", value: "private" },
    { label: "Group", value: "group" },
  ];

  return (
    <div className="edit-trip-form-container">
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Edit Trip"
          handleSubmit={handleUpdateTripAndOptions}
          setOpenForm={setIsOpen}
        >
          <form
            onSubmit={handleUpdateTripAndOptions}
            className="edit-trip-form"
          >
            <Select
              label="Trip Type"
              options={tripTypeOptions}
              value={tripTypeOptions.find(
                (option) => option.value === tripType
              )}
              setValue={(option) => setTripType(option.value)}
              placeholder="Select Trip Type"
              required
            />

            <Input
              label="Trip Name"
              inputValue={tripName}
              setInputValue={setTripName}
              placeholder="Enter Trip Name"
              required
            />

            <Input
              label="Trip Description"
              inputValue={tripDescription}
              setInputValue={setTripDescription}
              placeholder="Enter Trip Description"
              type="textarea"
              required
            />

            <Input
              label="Additional Info"
              inputValue={additionalInfo}
              setInputValue={setAdditionalInfo}
              placeholder="Enter Additional Information"
              type="textarea"
              required
            />

            {tripType === "private" && (
              <Fragment>
                <Input
                  label="Price per Person"
                  inputValue={tripPricePerPerson}
                  setInputValue={setTripPricePerPerson}
                  placeholder="Enter Price per Person"
                  type="number"
                  required
                />

                <Input
                  label="Price for Two"
                  inputValue={tripPriceForTwo}
                  setInputValue={setTripPriceForTwo}
                  placeholder="Enter Price for Two"
                  type="number"
                  required
                />

                <Input
                  label="Price for Three or More"
                  inputValue={tripPriceForThreeOrMore}
                  setInputValue={setTripPriceForThreeOrMore}
                  placeholder="Enter Price for Three or More"
                  type="number"
                  required
                />
              </Fragment>
            )}
            {tripType === "group" && (
              <Fragment>
                {" "}
                <Input
                  label="Price per Companion"
                  inputValue={groupPricePerPerson}
                  setInputValue={(value) =>
                    setGroupPricePerPerson(parseFloat(value) || 0)
                  }
                  placeholder="Enter group price per person"
                  type="number"
                />
                {/* <Input
                  label="Price per Speaker"
                  inputValue={groupPricePerSpeaker}
                  setInputValue={(value) =>
                    setGroupPricePerSpeaker(parseFloat(value) || 0)
                  }
                  placeholder="Enter group price per speaker"
                  type="number"
                /> */}
              </Fragment>
            )}
            {additionalOptions.map((option) => (
              <div key={option.id} className="option-container">
                <Input
                  label={option.option_name}
                  inputValue={option.price}
                  setInputValue={(newValue) => {
                    const updatedOptions = additionalOptions.map((o) =>
                      o.id === option.id ? { ...o, price: newValue } : o
                    );
                    setAdditionalOptions(updatedOptions);
                  }}
                  placeholder="Enter Option Price"
                  type="number"
                  required
                />
              </div>
            ))}
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default EditTrip;
