import React from 'react';
import './style.scss';
import welcomeImage from './welcome.jpeg'; // Import the image properly

const Welcome = () => {
  return (
    <div className="welcome-container">
      <div className="welcome-header">
        <h3>Welcome to the Congress!</h3>
        <h4>
          On behalf of the Organizing Committee, we are delighted to invite you to join us at The 
          Pan Arab Society of Urology Congress & the 13th International Congress of The Jordanian 
          Association of Urological Surgeons, which will be held in Amman, Jordan, on 20 - 22 Oct 2022.
        </h4>
      </div>

      <div className="welcome-content">
        <div
          className="welcome-image"
          style={{ backgroundImage: `url(${welcomeImage})` }} // Set background image correctly
        ></div>

        <div className="welcome-description">
          <p>
            The Congress has been designed to provide an innovative and comprehensive overview of 
            the latest developments and updates in Urological surgery. It will also focus on 
            regional cooperation between the Arab countries. 
          </p>
          <p>
            We hope you will find the Congress refreshing and rewarding, and the interaction with 
            our distinguished speakers, as well as between all participants, will stimulate a 
            creative exchange of ideas. 
          </p>
          <p>
            Thank you for your participation, and we look forward to welcoming you all to Amman.
          </p>
          <p><strong>Chairman of the Congress</strong></p>
          <p><strong>Dr. Rami Al Azab</strong></p>
        </div>
      </div>

      <div className="topics-section">
        <h3>Topics</h3>
        <ul>
          <li>Uro Oncology</li>
          <li>Minimally Invasive Urology</li>
          <li>Pediatric and Reconstructive Urology</li>
          <li>EndoUrology</li>
          <li>Andrology and Infertility</li>
          <li>Female and Functional Urology</li>
        </ul>
      </div>
    </div>
  );
};

export default Welcome;
