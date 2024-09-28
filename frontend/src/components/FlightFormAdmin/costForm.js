import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import "./style.scss";

const SeatCostForm = ({ setOpen,data }) => {
  const [seatCost, setSeatCost] = useState("");
  const [upgradeClassCost, setUpgradeClassCost] = useState("");
  const [additionalRequestsCost, setAdditionalRequestsCost] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    const formData = {
      seatCost,
      upgradeClassCost,
      additionalRequestsCost,
    };
    console.log("Form Data:", formData);
  };

  return (
    <div className="cost-form-container">
      <div className="header">Add Cost</div>
      <div className="form-section">
        <Input
          label="Seat Cost"
          placeholder="Enter Seat Cost"
          inputValue={seatCost}
          setInputValue={setSeatCost}
          type="text"
          required={true}
        />{" "}
        <Input
          label="Upgrade Class Cost"
          placeholder="Enter Upgrade Class Cost"
          inputValue={upgradeClassCost}
          setInputValue={setUpgradeClassCost}
          type="text"
          required={true}
        />
        <Input
          label="Additional Requests Cost"
          placeholder="Enter Additional Requests Cost"
          inputValue={additionalRequestsCost}
          setInputValue={setAdditionalRequestsCost}
          type="text"
          required={true}
        />
      </div>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpen(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" type="submit">
          Submit
        </button>
      </div>{" "}
    </div>
  );
};

export default SeatCostForm;
