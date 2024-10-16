import React from 'react';
import './style.scss';

const SocialEvents = () => {
  return (
    <div className="social-events">
      {/* قسم العنوان الرئيسي مع الصورة */}
      <div className="headline-section">
        <div className="overlay">
          <h1 className="title">SOCIAL EVENTS</h1>
        </div>
      </div>

      {/* قسم المحتوى */}
      <div className="content-section">
        <h2 className="subtitle">Enhancing Your Event with Exceptional Social Programs</h2>
        <p className="description">
          A key highlight of many events is the social program that runs alongside the main activities. Our team specializes in advising on suitable social events and handles the complete logistics and planning for any agreed-upon program. This may include opening and closing ceremonies, lunches and dinners, receptions, and themed parties, all designed to enhance the overall experience of your event.
        </p>

        <p className="description">
          For participants and their accompanying guests who wish to explore the country before or after the event, we also organize a variety of excursions and tours. These curated experiences ensure that every participant leaves with unforgettable memories, adding an extra dimension of enjoyment to their visit.
        </p>
      </div>
    </div>
  );
};

export default SocialEvents;
