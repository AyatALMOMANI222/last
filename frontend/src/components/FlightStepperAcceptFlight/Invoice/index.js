import React, { useEffect, useState } from "react";
import "./style.scss";

const Invoice = () => {
  const [flightTrips, setFlightTrips] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const getFlights = () => {
    const trips = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key.startsWith("Available_Trip_ID_")) {
        const value = localStorage.getItem(key);
        try {
          trips.push(JSON.parse(value));
        } catch {
          console.error("Error parsing localStorage data", value);
        }
      }
    }
    return trips;
  };

  const fetchFlightDetails = async (flightId) => {
    try {
      const response = await fetch(
        `${BaseUrl}/flight/id/${flightId}`
      );
      const data = await response.json();

      // Calculate individual costs
      const baseTicketPrice = parseFloat(data.base_ticket_price || 0);
      const businessClassUpgradeCost = data.upgrade_class
        ? parseFloat(data.business_class_upgrade_cost || 0)
        : 0;
      const reservedSeatCost = data.seat_preference
        ? parseFloat(data.reserved_seat_cost || 0)
        : 0;
      const otherAdditionalCosts = parseFloat(data.other_additional_costs || 0);
      const totalCost = data.is_free
        ? 0
        : baseTicketPrice +
          businessClassUpgradeCost +
          reservedSeatCost +
          otherAdditionalCosts;

      return {
        ...data,
        baseTicketPrice,
        businessClassUpgradeCost,
        reservedSeatCost,
        otherAdditionalCosts,
        totalCost,
      };
    } catch (error) {
      console.error("Error fetching flight data:", error);
      return null;
    }
  };

  useEffect(() => {
    const loadFlightData = async () => {
      const flights = getFlights();
      console.log({ flights });

      const detailedFlights = await Promise.all(
        flights.map(async (flight) => {
          const flightDetails = await fetchFlightDetails(flight.flight_id);
          return { ...flightDetails, ...flight };
        })
      );
      console.log({ detailedFlights });

      setFlightTrips(detailedFlights);
    };

    loadFlightData();
  }, []);

  const totalPayment = flightTrips.reduce((total, flight) => {
    console.log(flight.price);

    return (
      total +
      (flight.upgrade_class ? flight.businessClassUpgradeCost : 0) +
      (flight.seat_preference ? flight.reservedSeatCost : 0) +
      flight.otherAdditionalCosts +
      Number(flight.price)
    );
  }, 0);

  return (
    <div className="invoice">
      <h2 className="invoice__title">Invoice</h2>
      {flightTrips.length === 0 ? (
        <p className="invoice__message">No flights available</p>
      ) : (
        <table className="invoice__table">
          <thead>
            <tr>
              <th>Flight ID</th>
              <th>Departure Date</th>
              <th>Departure Time</th>
              <th>Base Price</th>
              <th>Business Class Upgrade</th>
              <th>Reserved Seat Cost</th>
              <th>Other Additional Costs</th>
              <th>Total Price</th>
            </tr>
          </thead>
          <tbody>
            {flightTrips.map((flight, index) => (
              <tr key={index} className="invoice__row">
                <td>{flight.flight_id}</td>
                <td>{flight.departure_date}</td>
                <td>{flight.specific_flight_time}</td>
                <td>${flight.price}</td>
                <td>
                  ${flight.upgrade_class ? flight.businessClassUpgradeCost : 0}
                </td>
                <td>${flight.seat_preference ? flight.reservedSeatCost : 0}</td>
                <td>${flight.otherAdditionalCosts}</td>
                <td>
                  $
                  {Number(flight.price) +
                    Number(
                      flight.upgrade_class ? flight.businessClassUpgradeCost : 0
                    ) +
                    Number(
                      flight.seat_preference ? flight.reservedSeatCost : 0
                    ) +
                    Number(flight.otherAdditionalCosts)}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
      <h3 className="invoice__total">
        Total: ${totalPayment}
        {/* Total payment corrected */}
      </h3>
      <div className="actions-section">
        <button className="next-button" onClick={() => {}} disabled={false}>
          Pay
        </button>
      </div>
    </div>
  );
};

export default Invoice;
