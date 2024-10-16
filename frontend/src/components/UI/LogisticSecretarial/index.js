import React from 'react';
import './style.scss'; // استيراد ملف CSS للمكونات

const LogisticSecretarial = () => {
  return (
    <div className="logistic-secretarial">
      <div className="headline-section">
        <div className="overlay">
          <h1 className="title">Logistic Secretarial Services</h1>
        </div>
      </div>
      <div className="content-section">
        <h2 className="subtitle">Our Services Include:</h2>
        <ul className="services-list">
          <li>Coordination: Liaise with the event initiator, speakers, participants, and suppliers to ensure smooth communication and execution.</li>
          <li>Communication: Mail invitations, registration forms, and essential information to all relevant parties.</li>
          <li>Abstract Management: Receive and manage abstracts for review and inclusion in the event.</li>
          <li>Registration Handling: Process registration forms and participants' fees, ensuring all data is accurately recorded.</li>
          <li>Invoicing: Prepare and mail invoices to participants and sponsors as required.</li>
          <li>Document Management: Update and maintain all event documents and lists to reflect the latest information.</li>
          <li>Payments: Handle payments for event-related expenses in a timely manner.</li>
          <li>On-Site Registration: Oversee site registration procedures, including the distribution of badges, conference kits, and other materials.</li>
        </ul>
        <p className="description">
          Our comprehensive logistic and secretarial services are designed to ensure that every administrative detail is managed efficiently, allowing you to focus on delivering a successful event.
        </p>
      </div>
    </div>
  );
};

export default LogisticSecretarial;
