import React from 'react';
import './style.scss';

const OurClients = () => {
  return (
    <div className="clients-container">
      <h2 className="clients-title">Our Clients</h2>
      <div className="clients-skew">

        <div className="clients-logo">
          <img src={require("./logo/unicef.png")} alt="Client Logo" className="client-logo" />
       
        </div>

        <div className="clients-logo">
        <img src={require("./logo/USAID.png")} alt="Client Logo" className="client-logo" />
       
        </div>

        <div className="clients-logo">
          {/* <img src={require("./logo/منظمة2.jfif")} alt="Client Logo" className="client-logo" /> */}
       
        </div>

        <div className="clients-logo">
        <img src={require("./logo/logo3.png")} alt="Client Logo" className="client-logo" />
       
        </div>

        <div className="clients-logo">
          <img src={require("./logo/unicef.png")} alt="Client Logo" className="client-logo" />
       
        </div>

        <div className="clients-logo">
        <img src={require("./logo/USAID.png")} alt="Client Logo" className="client-logo" />
       
        </div>
        
      </div>
    </div>
  );
};

export default OurClients;
