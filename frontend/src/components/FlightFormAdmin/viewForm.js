import React from "react";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import "./style.scss";

const FlightDetails = ({ data }) => {
  const getValueOrDefault = (value) => (value ? value : "-");

  return (
    <div className="view-form-flight-details-admin">
      <div className="header">{getValueOrDefault(data.passenger_name)}</div>
      <div className="view-section">
        <SimpleLabelValue label="Flight ID" value={getValueOrDefault(data.flight_id)} />
        <SimpleLabelValue label="Passenger Name" value={getValueOrDefault(data.passenger_name)} />
        <SimpleLabelValue
          label="Departure Airport"
          value={getValueOrDefault(data.departure_airport)}
        />
        <SimpleLabelValue
          label="Arrival Airport"
          value={getValueOrDefault(data.arrival_airport)}
        />
        <SimpleLabelValue label="Departure Date" value={getValueOrDefault(data.departure_date)} />
        <SimpleLabelValue label="Arrival Date" value={getValueOrDefault(data.arrival_date)} />
        <SimpleLabelValue label="Flight Number" value={getValueOrDefault(data.flight_number)} />
        <SimpleLabelValue
          label="Seat Preference"
          value={getValueOrDefault(data.seat_preference)}
        />
        <SimpleLabelValue label="Upgrade Class" value={getValueOrDefault(data.upgrade_class)} />
        <SimpleLabelValue label="Ticket Count" value={getValueOrDefault(data.ticket_count)} />
        <SimpleLabelValue
          label="Additional Requests"
          value={getValueOrDefault(data.additional_requests)}
        />
        <SimpleLabelValue
          label="Admin Update Deadline"
          value={getValueOrDefault(data.admin_update_deadline)}
        />
      </div>
    </div>
  );
};

export default FlightDetails;
