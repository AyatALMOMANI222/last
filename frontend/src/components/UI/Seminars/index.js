import React from 'react';
import './style.scss';

const Seminars = () => {
  return (
    <div className="seminars-container">
      {/* Headline picture section */}
      <div className="headline-picture">
        <h1 className="headline-title">Seminars</h1>
      </div>

      {/* Content section */}
      <div className="seminars-content">
        <p>
          Conferences have traditionally provided opportunities for networking, socializing, and hearing the latest management speak. However, they have rarely been exploited to their full potential as a forum for creative problem-solving and for mobilizing delegates into meaningful action. Our expert event consultants will guide you in achieving this.
        </p>
        <p>
          The stage setting for any conference is critical to the reception of the message. Set design, lighting, quality of sound, and projection all contribute to effective communication. Our highly skilled staff handles all phases of a conference with care, from planning to preparation and management.
        </p>
        <p>
          With years of experience in events management, we leverage our knowledge and resources to deliver successful outcomes for our clients. We offer comprehensive services including budget formulation, multilingual assistance, translations, and technical support to meet all types of requirements.
        </p>
      </div>
    </div>
  );
};

export default Seminars;
