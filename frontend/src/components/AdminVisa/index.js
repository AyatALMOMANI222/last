import React, { useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox";
import Select from "../../CoreComponent/Select";
import "./style.scss";

const AdminVisa = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [isFree, setIsFree] = useState(false);
  const [visaCost, setVisaCost] = useState("");
  const [status, setStatus] = useState(null); // Change to null for better initial state
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  const statusOptions = [
    { id: 1, label: "pending" },
    { id: 2, label: "approved" },
    { id: 3, label: "rejected" },
  ];

  const getStatusValue = (status) => {
    return status ? status.label : ""; // Return label if status is selected
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    // Validate the visa status
    if (!status) {
      setError("Status is required.");
      return;
    }

    // Validate the visa cost if it is not free
    if (!isFree && (!visaCost || isNaN(parseFloat(visaCost)))) {
      setError("Please specify a valid visa cost if it is not free.");
      return;
    }

    const visaData = {
      visa_cost: isFree ? 0 : parseFloat(visaCost),
      payment_required: !isFree,
      status: getStatusValue(status), // Use the updated getStatusValue function
    };

    setIsLoading(true);
    try {
      const response = await axios.put(
        `${BaseUrl}/admin/update-visa/43`,
        visaData
      );
      console.log(response.data);
      // Optionally reset the form values or show a success message here
    } catch (err) {
      if (err.response) {
        setError(`Error: ${err.response.data.message}`);
      } else {
        setError(
          "An error occurred while updating the visa. Please try again."
        );
      }
      console.error(err);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="admin-visa-container">
      <form onSubmit={handleSubmit} className="visa-form">
        <h2>Visa Management</h2>

        <Checkbox
          label="Is Free?"
          checkboxValue={isFree}
          setCheckboxValue={setIsFree}
          errorMsg={error}
        />

        {!isFree && (
          <Input
            label="Visa Cost"
            placeholder="Enter visa cost"
            inputValue={visaCost}
            setInputValue={setVisaCost}
            required={!isFree} // Only required if it's not free
            errorMsg={error}
          />
        )}

        <Select
          options={statusOptions}
          value={status}
          setValue={setStatus} // Ensure this is setting the whole selected option object
          label="Visa Status"
          errorMsg={error}
        />

        {error && <span className="error-msg">{error}</span>}

        <button type="submit" className="submit-btn" disabled={isLoading}>
          {isLoading ? "Submitting..." : "Submit"}
        </button>
      </form>
    </div>
  );
};

export default AdminVisa;
