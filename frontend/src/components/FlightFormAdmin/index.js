import React, { useState } from "react";
import Table from "../../CoreComponent/Table";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import AddTripForm from "./tripForm";
import SeatCostForm from "./costForm";
import FlightDetails from "./viewForm";
import Input from "../../CoreComponent/Input";
import "./style.scss";

const FlightFormAdmin = () => {
  const flights = [
    {
      flight_id: "FL001",
      user_id: "USR123",
      is_companion: false,
      main_user_id: null,
      passport_image: "passport_usr123.jpg",
      departure_airport: "JFK",
      arrival_airport: "LAX",
      departure_date: "2024-09-25T10:30:00",
      arrival_date: "2024-09-25T13:30:00",
      flight_number: "AA101",
      seat_preference: "Window",
      upgrade_class: "Business",
      ticket_count: 1,
      additional_requests: "Vegetarian meal",
      admin_update_deadline: "2024-09-24T18:00:00",
      last_update_at: "2024-09-19T15:45:00",
      is_deleted: false,
      passenger_name: "John Doe",
    },
    {
      flight_id: "FL002",
      user_id: "USR456",
      is_companion: true,
      main_user_id: "USR123",
      passport_image: "passport_usr456.jpg",
      departure_airport: "JFK",
      arrival_airport: "LAX",
      departure_date: "2024-09-25T10:30:00",
      arrival_date: "2024-09-25T13:30:00",
      flight_number: "AA101",
      seat_preference: "Aisle",
      upgrade_class: null,
      ticket_count: 1,
      additional_requests: "Extra legroom",
      admin_update_deadline: "2024-09-24T18:00:00",
      last_update_at: "2024-09-19T15:45:00",
      is_deleted: false,
      passenger_name: "Jane Smith",
    },
    {
      flight_id: "FL003",
      user_id: "USR789",
      is_companion: false,
      main_user_id: null,
      passport_image: "passport_usr789.jpg",
      departure_airport: "LAX",
      arrival_airport: "SFO",
      departure_date: "2024-10-02T14:00:00",
      arrival_date: "2024-10-02T15:30:00",
      flight_number: "UA205",
      seat_preference: "Window",
      upgrade_class: "First Class",
      ticket_count: 2,
      additional_requests: "Wheelchair assistance",
      admin_update_deadline: "2024-10-01T17:00:00",
      last_update_at: "2024-09-19T15:50:00",
      is_deleted: false,
      passenger_name: "Emily Johnson",
    },
  ];
  const headers = [
    // { key: "flight_id", label: "Flight ID" },
    { key: "passenger_name", label: "Passenger Name" },
    { key: "departure_airport", label: "Departure Airport" },
    { key: "arrival_airport", label: "Arrival Airport" },
    { key: "departure_date", label: "Departure Date" },
    // { key: "arrival_date", label: "Arrival Date" },
    // { key: "flight_number", label: "Flight Number" },
    // { key: "seat_preference", label: "Seat Preference" },
    // { key: "additional_requests", label: "Additional Requests" },
    { key: "actions", label: "Actions" },
  ];

  const [openView, setOpenView] = useState(false);
  const [openTripForm, setOpenTripForm] = useState(false);
  const [openPriceForm, setOpenPriceForm] = useState(false);
  const [selectedItem, setSelectedItem] = useState({});
  const [travelerName, setTravelerName] = useState("");

  const handleTableData = () => {
    return flights?.map((item) => {
      return {
        ...item,
        actions: (
          <div className="table-actions-container">
            <button
              className="trip-btn"
              onClick={() => {
                setOpenTripForm(true);
                setSelectedItem(item);
              }}
            >
              Add Trip
            </button>
            <button
              className="price-btn"
              onClick={() => {
                setOpenPriceForm(true);
                setSelectedItem(item);
              }}
            >
              Add Price
            </button>
            <button
              onClick={() => {
                setOpenView(true);
                setSelectedItem(item);
              }}
            >
              View
            </button>
          </div>
        ),
      };
    });
  };

  return (
    <div className="flight-form">
      <div className="flight-form-admin-header">
        <div className="header">
          <Input
            placeholder="Search"
            inputValue={travelerName}
            setInputValue={setTravelerName}
            type="text"
          />
        </div>
      </div>
      <div className="flight-table-container">
        <Table headers={headers} data={handleTableData()} />
      </div>
      <MySideDrawer isOpen={openView} setIsOpen={setOpenView}>
        <FlightDetails data={selectedItem} />
      </MySideDrawer>
      <MySideDrawer isOpen={openTripForm} setIsOpen={setOpenTripForm}>
        <AddTripForm data={selectedItem} setOpen={setOpenTripForm} />
      </MySideDrawer>
      <MySideDrawer isOpen={openPriceForm} setIsOpen={setOpenPriceForm}>
        <SeatCostForm data={selectedItem} setOpen={setOpenPriceForm} />
      </MySideDrawer>
    </div>
  );
};

export default FlightFormAdmin;
