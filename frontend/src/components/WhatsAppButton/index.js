import React from "react";

// WhatsAppButton Component
const WhatsAppButton = ({ phoneNumber, message, buttonText }) => {
  // Function to open WhatsApp
  const openWhatsApp = () => {
    const formattedNumber = phoneNumber.replace(/\s/g, ''); // Remove spaces from the phone number
    const url = `https://wa.me/${formattedNumber}?text=${encodeURIComponent(message)}`;
    window.open(url, '_blank');
  };

  return (
    <button onClick={openWhatsApp} className="whatsapp-btn">
      {buttonText}
    </button>
  );
};

export default WhatsAppButton;
