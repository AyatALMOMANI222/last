import React, { useState } from 'react';
import Checkbox from "../../../CoreComponent/Checkbox";
import { useParams } from 'react-router-dom';
import httpService from "../../../../src/common/httpService"; 
import { toast } from "react-toastify";

const EditSpeakerData = () => {
  // جلب معرف المؤتمر من الـ Route
  const {conferenceId ,userId} = useParams();

  // متغيرات الحالة لـ Checkboxes
  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [isOnlineApproved, setIsOnlineApproved] = useState(true); 
  const [ticketStatus, setTicketStatus] = useState("1"); 
  const [dinnerInvitation, setDinnerInvitation] = useState(true); 
  const [airportPickup, setAirportPickup] = useState(true); 
  const [freeTrip, setFreeTrip] = useState(true); 
  const [isCertificateActive, setIsCertificateActive] = useState(true);

  // التعامل مع الفورم عند الإرسال
  const handleSubmit = async (e) => {
    e.preventDefault();
    const getAuthToken = () => localStorage.getItem("token");

    try {
      // إرسال البيانات مباشرة كـ داتا عادية
      await httpService({
        method: "POST",
        url: `http://127.0.0.1:8000/api/admin/speakers/${userId}/${conferenceId}`,
       
        headers: { Authorization: `Bearer ${getAuthToken()}` },

        showLoader: true,
        data: {
          is_online_approved: isOnlineApproved ? 1 : 0,
          ticket_status: ticketStatus,
          dinner_invitation: dinnerInvitation ? 1 : 0,
          airport_pickup: airportPickup ? 1 : 0,
          free_trip: freeTrip ? 1 : 0,
          is_certificate_active: isCertificateActive ? 1 : 0
        },
        withToast: true, // لتفعيل الـ toast في حالة النجاح أو الخطأ
        onSuccess: (data) => {
          toast.success("Form submitted successfully!"); // رسالة نجاح
        },
        onError: (error) => {
          toast.error("Failed to submit the form: " + error); // رسالة فشل
        },
      });
    } catch (error) {
      console.error('Error submitting form:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <Checkbox
        label="Do you have specific flight time?"
        checkboxValue={specificFlightTime}
        setCheckboxValue={setSpecificFlightTime}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Is Online Approved?"
        checkboxValue={isOnlineApproved}
        setCheckboxValue={setIsOnlineApproved}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Ticket Status (Active)"
        checkboxValue={ticketStatus}
        setCheckboxValue={setTicketStatus}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Dinner Invitation?"
        checkboxValue={dinnerInvitation}
        setCheckboxValue={setDinnerInvitation}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Airport Pickup?"
        checkboxValue={airportPickup}
        setCheckboxValue={setAirportPickup}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Free Trip?"
        checkboxValue={freeTrip}
        setCheckboxValue={setFreeTrip}
        icon={""}
        errorMsg={""}
      />

      <Checkbox
        label="Is Certificate Active?"
        checkboxValue={isCertificateActive}
        setCheckboxValue={setIsCertificateActive}
        icon={""}
        errorMsg={""}
      />

      <button type="submit">Submit</button>
    </form>
  );
};

export default EditSpeakerData;
