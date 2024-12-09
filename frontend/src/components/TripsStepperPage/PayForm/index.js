import React from "react";
import SimpleLabelValue from "../../SimpleLabelValue";
import "./style.scss";
import { useTripsStepper } from "../StepperContext";

const PayForm = () => {
  const { currentStep, completeStep, invoice, setInvoice } = useTripsStepper();

  return (
    <div className="pay-form-container">
      {invoice.length > 0 ? (
        <ul className="invoice-list">
          {invoice.map((invoice, index) => (
            <li key={index} className="invoice-item">
              <h3 className="invoice-title">
                Participant ID: {invoice.participant_id}
              </h3>
              <div className="invoice-details">
                <SimpleLabelValue
                  label="Base Price"
                  value={invoice.base_price}
                  className="invoice-detail"
                />
                <SimpleLabelValue
                  label="Options Price"
                  value={invoice.options_price}
                  className="invoice-detail"
                />
                <SimpleLabelValue
                  label="Total Price"
                  value={invoice.total_price}
                  className="invoice-detail"
                />
              </div>
            </li>
          ))}
        </ul>
      ) : (
        <p>No invoices available.</p>
      )}
      <div className="actions-section">
        <button className="next-button">Pay Now</button>
      </div>
    </div>
  );
};

export default PayForm;
