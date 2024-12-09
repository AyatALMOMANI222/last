import React, { useEffect, useState } from "react";
import axios from "axios";
import Input from "../../../../CoreComponent/Input";
import MySideDrawer from "../../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../../CoreComponent/CustomFormWrapper";
import { toast } from "react-toastify";
import "./style.scss";
import httpService from "../../../../common/httpService";

const AirportTransferPrice = ({ isOpen, setIsOpen, selectedConference }) => {
  const [fromAirportPrice, setFromAirportPrice] = useState("");
  const [toAirportPrice, setToAirportPrice] = useState("");
  const [roundTripPrice, setRoundTripPrice] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  // Function to get Authorization token
  const getAuthToken = () => localStorage.getItem("token");

  // Function to handle the form submission
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Prepare the data to be sent
    const prices = {
      conference_id: selectedConference?.id,
      from_airport_price: parseFloat(fromAirportPrice),
      to_airport_price: parseFloat(toAirportPrice),
      round_trip_price: parseFloat(roundTripPrice),
    };

    const token = getAuthToken();

    try {
      const response = await axios.post(
        `${BaseUrl}/airport-transfer-prices`,
        prices,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      console.log("Response:", response.data);
      setIsOpen(false);
      toast.success("Airport Transfer Price Added successfully!");
    } catch (error) {
      console.error("There was an error submitting the prices!", error);
      toast.error("Failed to submit prices. Please try again.");
    }
  };

  // Function to fetch the airport prices
  const fetchData = async () => {
    if (!selectedConference?.id) return;
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/test/${selectedConference?.id}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: false,
      });

      if (response.success && response.data.length > 0) {
        const priceData = response.data[0];
        setFromAirportPrice(priceData.from_airport_price);
        setToAirportPrice(priceData.to_airport_price);
        setRoundTripPrice(priceData.round_trip_price);
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    if (!isOpen) {
      // Reset the form values when the side drawer opens
      setFromAirportPrice("");
      setToAirportPrice("");
      setRoundTripPrice("");
    } else {
      fetchData(); // Fetch data only if the drawer is closed
    }
  }, [selectedConference, isOpen, BaseUrl]);

  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Airport Transfer Price"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          <form onSubmit={handleSubmit} className="price-airport-form9">
            <Input
              label="From Airport Price"
              inputValue={fromAirportPrice}
              setInputValue={setFromAirportPrice}
              placeholder="Enter price"
              type="number"
              step="0.01"
              required
            />
            <Input
              label="To Airport Price"
              inputValue={toAirportPrice}
              setInputValue={setToAirportPrice}
              placeholder="Enter price"
              type="number"
              step="0.01"
              required
            />
            <Input
              label="Round Trip Price"
              inputValue={roundTripPrice}
              setInputValue={setRoundTripPrice}
              placeholder="Enter price"
              type="number"
              step="0.01"
              required
            />
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default AirportTransferPrice;
