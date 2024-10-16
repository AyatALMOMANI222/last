import React, { useState } from 'react';
import Checkbox from "../../../CoreComponent/Checkbox"
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper"; // Ensure the correct path to your CustomFormWrapper
import MySideDrawer from "../../../CoreComponent/SideDrawer";

const EditSpeakerData = () => {
  // State variables for checkboxes
  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [isOnlineApproved, setIsOnlineApproved] = useState(true); // Assuming 1 means true
  const [ticketStatus, setTicketStatus] = useState("1"); // Using string for ticket status
  const [dinnerInvitation, setDinnerInvitation] = useState(true); // Assuming 1 means true
  const [airportPickup, setAirportPickup] = useState(true); // Assuming 1 means true
  const [freeTrip, setFreeTrip] = useState(true); // Assuming 1 means true
  const [isCertificateActive, setIsCertificateActive] = useState(true); // Assuming 1 means true

  const handleSubmit = (e) => {
    e.preventDefault();
    // Gather all form data
    const formData = {
      specificFlightTime,
      isOnlineApproved,
      ticketStatus,
      dinnerInvitation,
      airportPickup,
      freeTrip,
      isCertificateActive,
    };

    console.log('Form Data Submitted:', formData);
    // Handle form submission (e.g., send to server)
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
