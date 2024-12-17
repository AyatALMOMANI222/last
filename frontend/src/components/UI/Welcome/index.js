import React from "react";
import "./style.scss";
import welcomeImage from "./welcome.jpeg"; // Import the image properly

const Welcome = () => {
  return (
    <div className="welcome-container-section">
      <div className="welcome-container">
        <div className="welcome-header">
          <h3>Welcome to the Conference!</h3>
          <h4>
            On behalf of the Organizing Committee, we are excited to invite you
            to join us at this prestigious conference, bringing together experts
            and professionals from around the world. The event will be held in
            a dynamic and welcoming city, offering a platform for collaboration,
            innovation, and knowledge exchange.
          </h4>
        </div>

        <div className="welcome-content">
          <div
            className="welcome-image"
            style={{ backgroundImage: `url(${welcomeImage})` }} // Set background image correctly
          ></div>

          <div className="welcome-description">
            <p>
              This conference is designed to provide a comprehensive overview
              of the latest developments and trends in various fields. It will
              feature a diverse range of topics and sessions, aimed at fostering
              collaboration and advancing knowledge across industries.
            </p>
            <p>
              We hope you will find the conference both enriching and inspiring,
              and that the interactions with distinguished speakers and fellow
              participants will stimulate creative exchanges and new ideas.
            </p>
            <p>
              Thank you for being part of this exciting event, and we look
              forward to welcoming you to an unforgettable experience.
            </p>
            <p>
              <strong>Chairman of the Conference</strong>
            </p>
          </div>
        </div>

        <div className="topics-section">
          <h3>Topics</h3>
          <ul>
            <li>Innovation and Research</li>
            <li>Technology and Trends</li>
            <li>Global Collaboration</li>
            <li>Future Prospects</li>
            <li>Industry Challenges</li>
            <li>Networking Opportunities</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Welcome;
