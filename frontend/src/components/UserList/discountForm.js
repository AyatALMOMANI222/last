import React, { useEffect, useState } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import axios from "axios";
import "./style.scss";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../CoreComponent/SideDrawer";

const AddDiscountForm = ({ isOpen, setIsOpen, userId }) => {
  const [participantId, setParticipantId] = useState("");
  const [selectedOptionId, setSelectedOptionId] = useState("");
  const [discountAmount, setDiscountAmount] = useState(0);
  const [isDiscountVisible, setIsDiscountVisible] = useState(false);
  const [conferenceOptions, setConferenceOptions] = useState([]);
  const [tripOptions, setTripOptions] = useState([]);
  const [additionalOptions, setAdditionalOptions] = useState([]);
  const [selectedTripId, setSelectedTripId] = useState(null);
  const [selectedConferenceId, setSelectedConferenceId] = useState(null);

  const getAuthToken = () => localStorage.getItem("token");

  const fetchUserConferences = async () => {
    try {
      const token = getAuthToken();
      const response = await axios.get(
        `http://127.0.0.1:8000/api/user/${userId}/conferences`,
        { headers: { Authorization: `Bearer ${token}` } }
      );

      const formattedConferences = response.data.map(({ title, id }) => ({
        label: title,
        value: id,
      }));
      setConferenceOptions(formattedConferences);
    } catch (error) {
      console.error("Error fetching conferences", error);
    }
  };

  const fetchConferenceTrips = async (conferenceId) => {
    if (!conferenceId) return;
    try {
      const token = getAuthToken();
      const response = await axios.get(
        "http://127.0.0.1:8000/api/conference-trips",
        { headers: { Authorization: `Bearer ${token}` } }
      );

      const filteredTrips = response.data.data.filter(
        ({ conference_id }) => conference_id === conferenceId
      );

      const formattedTrips = filteredTrips.map(({ trip }) => ({
        label: trip.name,
        value: trip.id,
      }));

      setTripOptions(formattedTrips || []);
    } catch (error) {
      console.error("Error fetching trips", error);
    }
  };

  const fetchTripOptions = async (tripId) => {
    if (!selectedConferenceId) return;
    try {
      const token = getAuthToken();
      const response = await axios.get(
        `http://127.0.0.1:8000/api/additional-options/trip/${tripId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );

      const formattedOptions = response?.data?.data?.map(
        ({ option_name, id }) => ({
          label: option_name,
          value: id,
        })
      );

      setAdditionalOptions(formattedOptions);
    } catch (error) {
      console.error("Error fetching options", error);
    }
  };

  const handleFormSubmit = async (e) => {
    e.preventDefault();
    try {
      const token = getAuthToken();
      const discountData = {
        user_id: userId,
        option_id: selectedOptionId?.value,
        trip_id: selectedTripId?.value,
        price: discountAmount,
        show_price: isDiscountVisible,
      };
      await axios.post("http://127.0.0.1:8000/api/discounts", discountData, {
        headers: { Authorization: `Bearer ${token}` },
      });
    } catch (error) {
      console.error("Error submitting discount", error);
    }
  };

  useEffect(() => {
    if (userId) fetchUserConferences();
  }, [isOpen, userId]);

  useEffect(() => {
    if (selectedConferenceId) fetchConferenceTrips(selectedConferenceId.value);
  }, [selectedConferenceId]);

  useEffect(() => {
    setSelectedTripId(null);
  }, [selectedConferenceId]);
  useEffect(() => {
    setSelectedOptionId(null);
  }, [selectedTripId]);
  useEffect(() => {
    selectedTripId?.value && fetchTripOptions(selectedTripId.value);
  }, [selectedTripId]);

  return (
    <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
      <CustomFormWrapper
        title="Add Discount for User"
        handleSubmit={handleFormSubmit}
        setOpenForm={setIsOpen}
      >
        <form className="discount-form-container" onSubmit={handleFormSubmit}>
          <Select
            options={conferenceOptions}
            value={selectedConferenceId}
            setValue={setSelectedConferenceId}
            label="Conference"
          />
          <Select
            options={tripOptions}
            value={selectedTripId}
            setValue={setSelectedTripId}
            label="Trip"
          />
          <Select
            options={additionalOptions}
            value={selectedOptionId}
            setValue={setSelectedOptionId}
            label="Option"
          />
          <Input
            label="Discount Value"
            inputValue={discountAmount}
            setInputValue={(value) => setDiscountAmount(parseFloat(value) || 0)}
            placeholder="Enter discount value"
            type="number"
          />
          <Select
            options={[
              { value: true, label: "Show Discount" },
              { value: false, label: "Hide Discount" },
            ]}
            value={{
              value: isDiscountVisible,
              label: isDiscountVisible ? "Show" : "Hide",
            }}
            setValue={(option) => setIsDiscountVisible(option.value)}
            label="Show Discount"
          />
        </form>
      </CustomFormWrapper>
    </MySideDrawer>
  );
};

export default AddDiscountForm;
