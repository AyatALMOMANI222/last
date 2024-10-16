import React from 'react';
import './style.scss';

const MediaCampaign = () => {
    return (
        <div className="media-campaign">
            <div className="headline-section">
                <div className="overlay">
                    <h1 className="title">Media Campaign</h1>
                </div>
            </div>
            <div className="content-section">
                <h2 className="subtitle">Comprehensive Media and Marketing Services</h2>
                <ul className="principles-list">
                    <li>Conduct a thorough media campaign study.</li>
                    <li>Coordinate all press releases.</li>
                    <li>Organize and manage press conferences.</li>
                    <li>Arrange for all necessary media advertisements.</li>
                    <li>Oversee and control the pressroom during the congress.</li>
                </ul>
                <p className="description">
                    Our dedicated marketing department manages all aspects of publicity and marketing to help you effectively reach potential sponsors, participants, and delegates. Our creative team excels in designing and developing all print materials and oversees the production and distribution of information to your target audience.
                </p>
                <h3 className="principles-title">Concept Creation:</h3>
                <ul className="principles-list">
                    <li>Establishing objectives to creatively design and develop the overall branding and image for meetings and events.</li>
                    <li>Assisting in setting appropriate pricing for the event.</li>
                    <li>Developing sponsorship and exhibition opportunities.</li>
                    <li>Managing the budget and building strategic alliances effectively.</li>
                </ul>
            </div>
        </div>
    );
}

export default MediaCampaign;
