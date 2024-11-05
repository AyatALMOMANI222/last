import React from "react";
import "./style.scss";

const NotificationMessage = () => {
  return (
    <div className="notification-container-msg2">
      <div className="notification-icon">📧</div>
      <div className="notification-content">
        <h3 className="notification-title">Notification</h3>
        <p className="notification-text">
          You will be notified via email after your request is accepted to
          download the registered names. These names must be in English and in
          an Excel file format.
        </p>
      </div>
    </div>
  );
};

export default NotificationMessage;
