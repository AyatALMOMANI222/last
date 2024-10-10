import React, { useState, useRef, useEffect } from "react";
import SVG from "react-inlinesvg";
import notification from "../../icons/notification.svg";
import "./style.scss";
import axios from "axios";


const NotificationDropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [notifications,setNotifications]=useState([])

  const dropdownRef = useRef(null);

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleMarkAsRead = (id) => {
    // Handle marking the notification as read
  };

  const handleClickOutside = (event) => {
    if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
      setIsOpen(false);
    }
  };
  const getAllNotification = () => {
    const token = localStorage.getItem('token');
    const userId = localStorage.getItem('user_id');
  
    axios.get(`http://127.0.0.1:8000/api/not/${userId}`, {
      headers: {
        Authorization: `Bearer ${token}`, 
      },
    })
    .then(response => {
      setNotifications(response.data.data)
     
    })
    .catch(error => {
      console.error("Error fetching notifications:", error);
    });
  };
  
  // useEffect(() => {
  //   document.addEventListener("mousedown", handleClickOutside);
  //   getAllNotification()
  //   return () => {
  //     document.removeEventListener("mousedown", handleClickOutside);
  //   };
  // }, []);

  return (
    <div className="notification-container" ref={dropdownRef}>
      <div className="notification-icon" onClick={toggleDropdown}>
        <SVG src={notification} fill="#000" />
        {notifications.some((notif) => !notif.read) && (
          <span className="notification-badge">
            {notifications.filter((item) => !item.read).length}
          </span>
        )}
      </div>
      {isOpen && (
        <div className="notification-dropdown">
          {notifications.map((notification) => (
            <div
              key={notification.id}
              className={`notification-item ${
                notification.read ? "read" : "unread"
              }`}
              onClick={() => handleMarkAsRead(notification.id)}
            >
              {!notification.read && <span className="notification-dot"></span>}
              <div className="notification-content">
                <div className="notification-title">{notification.message}</div>
                {/* <p>{notification.description}</p> */}
                <small>{notification.read ? "Read" : "Unread"}</small>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default NotificationDropdown;
