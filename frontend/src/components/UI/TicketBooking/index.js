import React from 'react';
import './style.scss';

const TicketBooking = () => {
  return (
    <div className="ticket-booking">
      <div className="booking-hero">
        <img 
          src={require("./ticketBooking.jpg" )}
          alt="Ticket Booking Background" 
          className="hero-image" 
        />
        <h1 className="hero-title">Ticket Booking</h1>
      </div>

      <div className="booking-description">
        <p>
          Event Consultant help you to book your Ticket in 2 steps, all you have to do 
          is to fill the form, make your payment, and we will take care of the rest from 
          finding the best deals to booking it for you.
        </p>
      </div>
    </div>
  );
};

export default TicketBooking;
