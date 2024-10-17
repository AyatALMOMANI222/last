import React from 'react';
import './style.scss';

const HotelBooking = () => {
  return (
    <div className="hotel-booking">
      <div className="booking-hero">
        <img 
          src={require("./HotelBooking.jpg")} 
          alt="Hotel Booking Background" 
          className="hero-image" 
        />
        <h1 className="hero-title">Hotel Booking</h1>
      </div>
    </div>
  );
};

export default HotelBooking;
