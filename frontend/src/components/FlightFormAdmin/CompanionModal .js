import React from "react";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import SimpleLabelValue from "../SimpleLabelValue";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import "./CompanionModal.scss";

const FlightDetails = ({ flights }) => {
  console.log({flights});
  
  if (!flights?.length) return;
  const flightsToDisplay = flights?.slice(1);
  return (
    <div className="FlightDetails">
      {flightsToDisplay?.map((flight) => (
        <div key={flight.flight_id} className="FlightDetails-section">
          <SimpleLabelValue
            label="Passport Image"
            value={flight.passport_image ? "Available" : "Not Provided"}
          />
          <SimpleLabelValue
            label="Departure Airport"
            value={flight.departure_airport}
          />
          <SimpleLabelValue
            label="Arrival Airport"
            value={flight.arrival_airport}
          />
          <SimpleLabelValue
            label="Departure Date"
            value={flight.departure_date}
          />
          <SimpleLabelValue label="Arrival Date" value={flight.arrival_date} />
          <SimpleLabelValue
            label="Flight Number"
            value={flight.flight_number}
          />
          <SimpleLabelValue
            label="Seat Preference"
            value={flight.seat_preference}
          />
          <SimpleLabelValue
            label="Upgrade Class"
            value={flight.upgrade_class}
          />
          <SimpleLabelValue label="Ticket Count" value={flight.ticket_count} />
          <SimpleLabelValue
            label="Additional Requests"
            value={flight.additional_requests}
          />
          <SimpleLabelValue
            label="Passenger Name"
            value={flight.passenger_name}
          />
          <SimpleLabelValue
            label="Business Class Upgrade Cost"
            value={flight.business_class_upgrade_cost}
          />
          <SimpleLabelValue
            label="Reserved Seat Cost"
            value={flight.reserved_seat_cost}
          />
          <SimpleLabelValue
            label="Additional Baggage Cost"
            value={flight.additional_baggage_cost}
          />
          <SimpleLabelValue
            label="Other Additional Costs"
            value={flight.other_additional_costs}
          />
          <SimpleLabelValue
            label="Admin Update Deadline"
            value={flight.admin_update_deadline || "Not Set"}
          />
          <SimpleLabelValue
            label="Is Free"
            value={flight.is_free ? "Yes" : "No"}
          />
          <SimpleLabelValue
            label="Ticket Number"
            value={flight.ticket_number || "Not Assigned"}
          />

          <SimpleLabelValue
            label="Specific Flight Time"
            value={flight.specific_flight_time}
          />
          <SimpleLabelValue
            label="Base Ticket Price"
            value={flight.base_ticket_price || "Not Set"}
          />
        </div>
      ))}
    </div>
  );
};
const CompanionModal = ({ isOpen, setIsOpen, companions, headers }) => {
  return (
    <div className="companion-modal">
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Companions Information"
          handleSubmit={() => {}}
          setOpenForm={setIsOpen}
          noActions={true}
        >
          <FlightDetails flights={companions} />
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default CompanionModal;
