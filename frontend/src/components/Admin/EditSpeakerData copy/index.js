import React, { useState } from "react";
import Checkbox from "../../../CoreComponent/Checkbox";
import { useParams } from "react-router-dom";
import httpService from "../../../common/httpService";
import { toast } from "react-toastify";
import "./style.scss";

const EditSpeakerData = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const { conferenceId, userId } = useParams();
  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [isOnlineApproved, setIsOnlineApproved] = useState(true);
  const [ticketStatus, setTicketStatus] = useState("1");
  const [dinnerInvitation, setDinnerInvitation] = useState(true);
  const [airportPickup, setAirportPickup] = useState(true);
  const [freeTrip, setFreeTrip] = useState(true);
  const [isCertificateActive, setIsCertificateActive] = useState(true);
  // const [isCostCovered, setIsCostCovered] = useState(false);
  const [isVisaPaymentRequired, setIsVisaPaymentRequired] = useState(false); // حالة جديدة لـ is_visa_payment_required

  const handleSubmit = async (e) => {
    e.preventDefault();
    const getAuthToken = () => localStorage.getItem("token");

    try {
      await httpService({
        method: "POST",
        url: `${BaseUrl}/admin/speakers/${userId}/${conferenceId}`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          is_online_approved: isOnlineApproved ? 1 : 0,
          ticket_status: ticketStatus,
          dinner_invitation: dinnerInvitation ? 1 : 0,
          airport_pickup: airportPickup ? 1 : 0,
          free_trip: freeTrip ? 1 : 0,
          is_certificate_active: isCertificateActive ? 1 : 0,
          is_visa_payment_required: isVisaPaymentRequired ? 1 : 0, // تحويل القيمة إلى 0 أو 1

        },
        withToast: true,
        onError: (error) => {
          toast.error("Failed to submit the form: " + error);
        },
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
        {/* <Checkbox
          label="Is the cost covered?"
          checkboxValue={isCostCovered}
          setCheckboxValue={setIsCostCovered}
          className="form-checkbox"
        /> */}
           <Checkbox
        label="Is Visa Payment Required?"
        checkboxValue={isVisaPaymentRequired}
        setCheckboxValue={setIsVisaPaymentRequired}
        className="form-checkbox"
      />
      </div>

      <button type="submit" className="submit-btn">
        Submit
      </button>
    </form>
  );
};

export default EditSpeakerData;
