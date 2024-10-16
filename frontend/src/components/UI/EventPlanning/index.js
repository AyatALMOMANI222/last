import React from 'react';
import './style.scss';

const Planning = () => {
  return (
    <div className="planning">
      {/* قسم العنوان الرئيسي مع الصورة */}
      <div className="headline-section">
        <div className="overlay">
          <h1 className="title">EVENT PLANNING</h1>
        </div>
      </div>

      {/* قسم المحتوى */}
      <div className="content-section">
        <h2 className="subtitle">Success Doesn't Just Happen—It’s Planned</h2>
        <p className="description">
          Success is never accidental; it’s the result of meticulous planning. In the realm of event management, careful planning is the foundation that ensures every detail aligns perfectly to create an unforgettable experience. Effective event planning is crucial because it sets the stage for a seamless execution, anticipates potential challenges, and maximizes the impact of the event.
        </p>

        <p className="description">
          At Events Consultant we are committed to mastering the art of planning. You can trust that we consistently deliver outstanding results. Our expert planning and budgeting processes guarantee that deadlines are met, and budget overruns are avoided, allowing you to focus on the success of your event without concern.
        </p>

        <p className="description">
          The importance of planning cannot be overstated—it’s what transforms a vision into reality. By prioritizing detailed preparation, we ensure that each event runs smoothly, meets its objectives, and leaves a lasting impression on all attendees. With [Your Company Name], you are not just planning an event; you are crafting a memorable experience that reflects your goals and values.
        </p>
      </div>
    </div>
  );
};

export default Planning;
