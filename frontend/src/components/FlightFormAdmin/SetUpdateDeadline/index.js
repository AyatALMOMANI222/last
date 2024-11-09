import React, { useState } from "react";
import axios from "axios";
import DateInput from "../../../CoreComponent/Date";
import "./style.scss";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";

const UpdateDeadline = ({ data, setOpen }) => {
  const [adminUpdateDeadline, setAdminUpdateDeadline] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const flightId = data.flight_id;
  const handleSubmit = () => {
    const token = localStorage.getItem("token");

    const formData = {
      admin_update_deadline: adminUpdateDeadline,
    };

    axios
      .put(
        `${BaseUrl}/admin/update-flight/${flightId}`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        }
      )
      .then((response) => {
        setOpen(false);
      })
      .catch((error) => {
        if (error.response) {
          console.error("Error data:", error.response.data);
          console.error("Error status:", error.response.status);
          console.error("Error headers:", error.response.headers);
        } else if (error.request) {
          console.error("No response received:", error.request);
        } else {
          console.error("Error setting up request:", error.message);
        }
      });
  };

  return (
    <CustomFormWrapper
      title="Gala Dinner Details"
      handleSubmit={handleSubmit}
      setOpenForm={setOpen}
      noActions={false}
    >
      <div>
        <div>
          <DateInput
            label="Update Deadline"
            placeholder="Enter Admin Update Deadline"
            inputValue={adminUpdateDeadline}
            setInputValue={setAdminUpdateDeadline}
            required={true}
          />
        </div>
      </div>
    </CustomFormWrapper>
  );
};

export default UpdateDeadline;
