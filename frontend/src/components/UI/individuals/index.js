import React from 'react';
import './style.scss';

const AdventureSection = () => {
  return (
    <div className="adventure-section">
      <div className="adventure-hero">
        <img 
          src={require("./adventureSection2.jpeg")}
          alt="Adventure Background" 
          className="hero-image" 
        />
        <h1 className="hero-title">BUILD YOUR ADVENTURE YOUR WAY</h1>
      </div>

      <div className="features-container">
        <div className="feature-item">
          <div className="circle">Save money and time</div>
        </div>
        <div className="feature-item">
          <div className="circle">Tailor your trip to your preferences and needs</div>
        </div>
        <div className="feature-item">
          <div className="circle">Book and travel securely</div>
        </div>
      </div>
    </div>
  );
};

export default AdventureSection;
