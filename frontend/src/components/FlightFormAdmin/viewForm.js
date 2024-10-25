import React from "react";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import "./style.scss";
const FlightDetails = ({ data }) => {
  return (
    <div className="view-form-flight-details-admin">
      <div className="header">{data.passenger_name}</div>
      <div className="view-section">
        <SimpleLabelValue label="Flight ID" value={data.flight_id} />
        <SimpleLabelValue label="Passenger Name" value={data.passenger_name} />
        <SimpleLabelValue
          label="Departure Airport"
          value={data.departure_airport}
        />

        <SimpleLabelValue
          label="Arrival Airport"
          value={data.arrival_airport}
        />
        <SimpleLabelValue label="Departure Date" value={data.departure_date} />
        <SimpleLabelValue label="Arrival Date" value={data.arrival_date} />
        <SimpleLabelValue label="Flight Number" value={data.flight_number} />
        <SimpleLabelValue
          label="Seat Preference"
          value={data.seat_preference}
        />
        <SimpleLabelValue label="Upgrade Class" value={data.upgrade_class} />
        <SimpleLabelValue label="Ticket Count" value={data.ticket_count} />
        <SimpleLabelValue
          label="Additional Requests"
          value={data.additional_requests}
        />
        <SimpleLabelValue
          label="Admin Update Deadline"
          value={data.admin_update_deadline}
        />
        <SimpleLabelValue label="Last Update At" value={data.last_update_at} />
        <SimpleLabelValue
          label="Is Deleted"
          value={data.is_deleted ? "Yes" : "No"}
        />
      </div>
    </div>
  );
};

export default FlightDetails;
