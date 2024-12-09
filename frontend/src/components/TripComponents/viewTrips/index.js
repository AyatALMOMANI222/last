import React, { useEffect, useState } from "react";
import Table from "../../../CoreComponent/Table";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import axios from "axios";
import CreateTrip from "../AddTrip";
import AddOption from "../AddOptions";
import ViewOneTrip from "../ViewOneTrip";
import "./style.scss";
import { useNavigate } from "react-router-dom";
import EditTrip from "../EditTrip";
import httpService from "../../../common/httpService";

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
  const navigate = useNavigate();
  const [tripData, setTripData] = useState([]);
  const [tripName, setTripName] = useState("");
  const [tripType, setTripType] = useState("");
  const [isAddTrip, setAddTrip] = useState(false);
  const [isAddPrice, setAddPrice] = useState(false);
  const [tripId, setTripId] = useState(false);
  const [viewOneTrip, setViewOneTrip] = useState(false);
  const [openEditTrip, setOpenEditTrip] = useState(true);
  const [open, setOpen] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const fetchTrips = async () => {
    const token = localStorage.getItem("token");

    const params = {};
    if (tripType) {
      params.trip_type = tripType?.value;
    }
    if (tripName) {
      params.name = tripName;
    }

    const headers = {
      Authorization: `Bearer ${token}`,
      Accept: "application/json",
    };

    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/all-trip`,
        headers,
        params,
        onSuccess: (data) => {
          const newData = data?.trips?.map((item) => ({
            ...item,
            actions: (
              <div>
                <button
                  className="add-price-btn price2"
                  onClick={() => {
                    setAddPrice(true);
                    setTripId(item?.id);
                  }}
                >
                  Add Prices
                </button>
                <button
                  className="add-price-btn view2"
                  onClick={() => {
                    setViewOneTrip(true);
                    setTripId(item?.id);
                  }}
                >
                  View
                </button>
                <button
                  className="add-price-btn edit2"
                  onClick={() => {
                    setOpenEditTrip(true);
                    setOpen(true);
                    setTripId(item?.id);
                  }}
                >
                  Edit
                </button>
              </div>
            ),
          }));
          setTripData(newData);
        },
        onError: (error) => {
          console.error("Error fetching trips:", error);
        },
        withLoadder: true,
        withToast: true, // Show toast notifications
      });
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

      <CreateTrip isOpen={isAddTrip} setIsOpen={setAddTrip} fetchTrips={fetchTrips} />
      <AddOption isOpen={isAddPrice} setIsOpen={setAddPrice} tripId={tripId} />
      <ViewOneTrip
        isOpen={viewOneTrip}
        setIsOpen={setViewOneTrip}
        tripId={tripId}
      />

      <EditTrip isOpen={open} setIsOpen={setOpen} tripId={tripId} />
      <Table data={tripData} headers={headers} />
    </div>
  );
};

export default ViewTrip;
