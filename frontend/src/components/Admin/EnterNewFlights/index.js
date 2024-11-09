import React, { useEffect, useState } from "react";
import httpService from "../../../common/httpService";
import Table from "../../../CoreComponent/Table";
import "./style.scss";
import AddTripForm from "./addTripForm";
const EnterNewFlights = () => {
  const [flights, setFlights] = useState([]);
  const [flight_id, setFlight_id] = useState(0);
  const [main_user_id, setMain_user_id] = useState(0);

  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [isOpen, setIsOpen] = useState(false);
  const headers = [
    { key: "flight_id", label: "Flight ID" },
    { key: "main_user_id", label: "main_user_id" },
    { key: "passenger_name", label: "Passenger Name" },
    { key: "departure_airport", label: "Departure Airport" },
    { key: "arrival_airport", label: "Arrival Airport" },
    { key: "departure_date", label: "Departure Date" },
    { key: "arrival_date", label: "Arrival Date" },
    { key: "flight_number", label: "Flight Number" },
    { key: "actions", label: "Actions" },
  ];

  const getData = async () => {
    try {
      const token = localStorage.getItem("token");
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/other/accepted-flights`,
        headers: { Authorization: `Bearer ${token}` },
        withToast: false,
        showLoader: true,
      });
      console.log(response);

      // Check if response contains data
      if (response?.accepted_flights) {
        const flightsData = response.accepted_flights.map((flight) => ({
          flight_id: flight?.flight?.flight_id,
          main_user_id: flight?.flight?.main_user_id,
          price: flight.price,
          departure_airport: flight.flight?.departure_airport || "N/A",
          arrival_airport: flight.flight?.arrival_airport || "N/A",
          departure_date: flight.flight?.departure_date || "N/A",
          arrival_date: flight.flight?.arrival_date || "N/A",
          flight_number: flight.flight?.flight_number || "N/A",
          passenger_name: flight.flight?.passenger_name || "N/A",
          actions: (
            <div>
              <button
                onClick={() => {
                  setFlight_id(flight?.flight?.flight_id);
                  // setMain_user_id(flight?.flight?.main_user_id)
                  setTimeout(() => {
                    setIsOpen(true);
                  }, 1000);
                }}
              >
                Add Trip
              </button>
            </div>
          ),
        }));

        setFlights(flightsData);
      }
    } catch (error) {
      console.error("Error fetching flight data:", error);
    }
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <div className="flights-container-other">
      <h1>Enter Extra Flight Choices</h1>
      <AddTripForm
        isOpen={isOpen}
        setIsOpen={setIsOpen}
        flight_id={flight_id}
        main_user_id={main_user_id}
      />
      <Table headers={headers} data={flights} />
    </div>
  );
};

export default EnterNewFlights;
