import React, { useState } from "react";
import "./style.scss";
import Checkbox from "../../../CoreComponent/Checkbox";
import httpService from "../../../common/httpService";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";

const AdminForm = () => {
  const [isAdmin, setIsAdmin] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const { userId } = useParams();
  const navigate = useNavigate();
  const handleApprove = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    try {
      await httpService({
        method: "PUT",
        url: `${BaseUrl}/user/${userId}/update-admin-status`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          isAdmin: isAdmin,
          status: "approved",
        },
        withToast: true,
        onError: (error) => {
          toast.error("Failed to submit the form: " + error);
        },
      });
      navigate("/pending/users");
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  const handleReject = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    try {
      await httpService({
        method: "PUT",
        url: `${BaseUrl}/user/${userId}/update-admin-status`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          isAdmin: 0,
          status: "rejected",
        },
        withToast: true,
        onError: (error) => {
          toast.error("Failed to submit the form: " + error);
        },
      });

      navigate("/pending/users");
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  return (
    <div className="admin-form">
      <div className="form-field">
        <Checkbox
          label=" Is Admin"
          checkboxValue={isAdmin}
          setCheckboxValue={setIsAdmin}
          className="form-checkbox"
        />
      </div>
      <div className="approve-button-reject-button">
        <button className="approve-button" onClick={handleApprove}>
          Approve
        </button>

        <button className="reject-button" onClick={handleReject}>
          Reject
        </button>
      </div>
    </div>
  );
};

export default AdminForm;
