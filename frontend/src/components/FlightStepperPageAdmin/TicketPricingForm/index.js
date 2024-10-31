import React from "react";
import Input from "../../../CoreComponent/Input/index";

const TicketPricingForm = ({ ticketPricing, setTicketPricing }) => {
  const handleChange = (value, name) => {
    setTicketPricing((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  return (
    <div className="ticket-pricing-form-container">
      <Input
        label="Business Class Upgrade Cost"
        placeholder="Enter Business Class Upgrade Cost"
        inputValue={ticketPricing.business_class_upgrade_cost}
        setInputValue={(value) =>
          handleChange(value, "business_class_upgrade_cost")
        }
        type="text"
        name="business_class_upgrade_cost"
        required={true}
      />
      <Input
        label="Reserved Seat Cost"
        placeholder="Enter Reserved Seat Cost"
        inputValue={ticketPricing.reserved_seat_cost}
        setInputValue={(value) => handleChange(value, "reserved_seat_cost")}
        type="text"
        name="reserved_seat_cost"
        required={true}
      />
      <Input
        label="Other Additional Costs"
        placeholder="Enter Other Additional Costs"
        inputValue={ticketPricing.other_additional_costs}
        setInputValue={(value) => handleChange(value, "other_additional_costs")}
        type="text"
        name="other_additional_costs"
        required={true}
      />
    </div>
  );
};
export default TicketPricingForm;
