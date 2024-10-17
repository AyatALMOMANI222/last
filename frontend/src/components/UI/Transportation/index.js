import React from 'react';
import './style.scss';

const Transportation = () => {
  return (
    <div className="transportation-booking">
      <div className="booking-hero">
        <img 
          src={require("./transportation2.webp")} 
          alt="Transportation Background" 
          className="hero-image" 
        />
        <h1 className="hero-title">Transportation</h1>
      </div>
    </div>
  );
};

export default Transportation;
