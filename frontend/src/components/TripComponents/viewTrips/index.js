import React, { useEffect, useState } from "react";
import Table from "../../../CoreComponent/Table";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import axios from "axios";
import CreateTrip from "../AddTrip";
import "./style.scss";
import AddOption from "../AddOptions";

const headers = [
  { key: "id", label: "ID" },
  { key: "trip_type", label: "Trip Type" },
  { key: "name", label: "Name" },
  { key: "description", label: "Description" },
  { key: "location", label: "Location" },
  { key: "trip_details", label: "Trip Details" },
  { key: "actions", label: "Actions" },
];

const tripTypes = [
  { value: "private", label: "Private" },
  { value: "group", label: "Group" },
  { value: "", label: "" },
];

const ViewTrip = () => {
  const [tripData, setTripData] = useState([]);
  const [tripName, setTripName] = useState("");
  const [tripType, setTripType] = useState("");
  const [isAddTrip, setAddTrip] = useState(false);
  const [isAddPrice, setAddPrice] = useState(false);
  const [tripId, setTripId] = useState(false);


  const fetchTrips = async () => {
    const params = {};
    if (tripType) {
      params.trip_type = tripType;
    }
    if (tripName) {
      params.name = tripName;
    }

    try {
      const response = await axios.get("http://127.0.0.1:8000/api/all-trip", {
        headers: {
          Authorization:
            "Bearer 89|qY9SDEGFapyEzrh8nMcBgCRwW5m021rMcBvbsZ6K60a16cbf",
          Accept: "application/json",
        },
        params: params,
      });

      //   setTripData(response?.data?.trips);
      const newData = response?.data?.trips?.map((item) => {
        return {
          ...item,
          actions: (
            <div>
              <button
                className="add-price-btn"
                onClick={() => {
                  setAddPrice(true);
                  setTripId(item?.id)
                }}
              >
                Add Prices
              </button>
            </div>
          ),
        };
      });
      setTripData(newData);
    } catch (error) {
      console.error("Error fetching trips:", error);
    }
  };

  useEffect(() => {
    fetchTrips();
  }, [tripType, tripName]);

  return (
    <div className="trips-page-container">
      <div className="trips-form-admin-header">
        <div className="filters">
          <Input
            label="Trip Name"
            placeholder="Enter trip name"
            inputValue={tripName}
            setInputValue={setTripName}
            type="text"
          />
          <Select
            options={tripTypes}
            value={tripType}
            setValue={setTripType}
            label="Trip Type"
            placeholder="Select trip type"
          />
        </div>
        <button className="add-trips-btn" onClick={() => setAddTrip(true)}>
          Add new Trip
        </button>
      </div>
      <CreateTrip isOpen={isAddTrip} setIsOpen={setAddTrip} />
      <AddOption isOpen={isAddPrice} setIsOpen={setAddPrice} tripId={tripId}/>
      <Table data={tripData} headers={headers} />
    </div>
  );
};

export default ViewTrip;
