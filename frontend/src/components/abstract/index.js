import React, { useState } from "react";
import { useParams } from "react-router-dom";

import { toast } from "react-toastify";
import "./style.scss";
import Checkbox from "../../CoreComponent/Checkbox";
import httpService from "../../common/httpService";
import Select from "../../CoreComponent/Select";
const EditAbstractData = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const {userId,conferenceId}=useParams()

  const statusOptions = [
    { value: "accepted", label: "Accepted" },
    { value: "rejected", label: "Rejected" },
  ]
//   const { conferenceId, userId } = useParams();

  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [isOnlineApproved, setIsOnlineApproved] = useState(true);
  const [ticketStatus, setTicketStatus] = useState("1");
  const [dinnerInvitation, setDinnerInvitation] = useState(true);
  const [airportPickup, setAirportPickup] = useState(true);
  const [freeTrip, setFreeTrip] = useState(true);
  const [isCertificateActive, setIsCertificateActive] = useState(true);
  const [isVisaPaymentRequired, setIsVisaPaymentRequired] = useState(false);
  const [paperStatus, setPaperStatus] = useState("under review"); // الحالة الجديدة

  const handleSubmit = async (e) => {
    e.preventDefault();
    const getAuthToken = () => localStorage.getItem("token");

    try {
      await httpService({
        method: "PUT",
        url: `http://127.0.0.1:8000/api/abstract/con/${userId}/user/${conferenceId}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          is_online_approved: isOnlineApproved ? 1 : 0,
          ticket_status: ticketStatus,
          dinner_invitation: dinnerInvitation ? 1 : 0,
          airport_pickup: airportPickup ? 1 : 0,
          free_trip: freeTrip ? 1 : 0,
          is_certificate_active: isCertificateActive ? 1 : 0,
          is_visa_payment_required: isVisaPaymentRequired ? 1 : 0, 
          paper_status: paperStatus.value, // إضافة status

        },
        withToast: true,
        // onError: (error) => {
        //   toast.succeee("Failed to submit the form: " + error);
        // },
      });
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="edit-speaker-form">
      <h2 className="form-title">Edit Speaker Data</h2>
      <div className="checkbox-group">
        <Checkbox
          label="Do you have specific flight time?"
          checkboxValue={specificFlightTime}
          setCheckboxValue={setSpecificFlightTime}
          className="form-checkbox"
        />

        <Checkbox
          label="Is Online Approved?"
          checkboxValue={isOnlineApproved}
          setCheckboxValue={setIsOnlineApproved}
          className="form-checkbox"
        />

        <Checkbox
          label="Ticket Status (Active)"
          checkboxValue={ticketStatus}
          setCheckboxValue={setTicketStatus}
          className="form-checkbox"
        />

        <Checkbox
          label="Dinner Invitation?"
          checkboxValue={dinnerInvitation}
          setCheckboxValue={setDinnerInvitation}
          className="form-checkbox"
        />

        <Checkbox
          label="Airport Pickup?"
          checkboxValue={airportPickup}
          setCheckboxValue={setAirportPickup}
          className="form-checkbox"
        />

        <Checkbox
          label="Free Trip?"
          checkboxValue={freeTrip}
          setCheckboxValue={setFreeTrip}
          className="form-checkbox"
        />

        <Checkbox
          label="Is Certificate Active?"
          checkboxValue={isCertificateActive}
          setCheckboxValue={setIsCertificateActive}
          className="form-checkbox"
        />

        <Checkbox
          label="Is Visa Payment Required?"
          checkboxValue={isVisaPaymentRequired}
          setCheckboxValue={setIsVisaPaymentRequired}
          className="form-checkbox"
        />
      </div>

      <Select
      
      
        options={statusOptions}
        value={paperStatus}
        setValue={setPaperStatus}
        label="Paper Status"
      />
  
          {/* <option value="accepted">Accepted</option>
          <option value="rejected">Rejected</option>
    */}
    
      <button type="submit" className="submit-btn">
        Submit
      </button>
    </form>
  );
};

export default EditAbstractData;
