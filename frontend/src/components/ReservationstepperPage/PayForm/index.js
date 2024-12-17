import React from "react";
import SimpleLabelValue from "../../SimpleLabelValue";
import { useNavigate } from "react-router-dom";
import { useStepper } from "../StepperContext";
import "./style.scss";

const PayForm = () => {
  const { invoice } = useStepper();

  const submitReservation = async () => {};

  return (
    <div className="pay-form-container">
      {invoice && (
        <div className="pay-form-invoice-details">
          <h3>Invoice Details</h3>
          <div className="pay-form-section">
            <SimpleLabelValue
              label="Reservation ID"
              value={invoice.reservation_id}
            />
            <SimpleLabelValue
              label="Total Invoice"
              value={`$${invoice.total_invoice}`}
            />
          </div>
          <h3>Room Invoices</h3>
          {invoice.room_invoices.map((room, index) => (
            <div key={index} className="pay-form-section">
              <SimpleLabelValue label="Room Type" value={room.room_type} />
              <SimpleLabelValue
                label="Base Price"
                value={`$${room.base_price}`}
              />
              <SimpleLabelValue
                label="Early Check-In Price"
                value={`$${room.early_check_in_price}`}
              />
              <SimpleLabelValue
                label="Late Check-Out Price"
                value={`$${room.late_check_out_price}`}
              />
              <SimpleLabelValue label="Room ID" value={room.room_id} />
              <SimpleLabelValue
                label="Total Cost"
                value={`$${room.total_cost}`}
              />
            </div>
          ))}
        </div>
      )}

      <div className="actions-section">
        <button className="next-button" onClick={submitReservation}>
          Pay
        </button>
      </div>
    </div>
  );
};

export default PayForm;
