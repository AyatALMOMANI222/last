import React, { useState, useRef, useEffect } from "react";
import SVG from "react-inlinesvg";
import notification from "../../icons/notification.svg";
import "./style.scss";

// Sample notifications data
const notifications = [
  { id: 1, title: "New Comment", description: "You have a new comment on your post.", read: false },
  { id: 2, title: "New Like", description: "Someone liked your post.", read: true },
  { id: 3, title: "Friend Request", description: "You have a new friend request.", read: false },
  { id: 4, title: "New Comment", description: "You have a new comment on your post.", read: false },
  { id: 5, title: "New Like", description: "Someone liked your post.", read: true },
  { id: 6, title: "Friend Request", description: "You have a new friend request.", read: false },
  { id: 7, title: "New Comment", description: "You have a new comment on your post.", read: false },
  { id: 8, title: "New Like", description: "Someone liked your post.", read: true },
  { id: 9, title: "Friend Request", description: "You have a new friend request.", read: false },
  { id: 10, title: "New Comment", description: "You have a new comment on your post.", read: false },
  { id: 11, title: "New Like", description: "Someone liked your post.", read: true },
  { id: 12, title: "Friend Request", description: "You have a new friend request.", read: false },
  { id: 13, title: "New Comment", description: "You have a new comment on your post.", read: false },
  { id: 14, title: "New Like", description: "Someone liked your post.", read: true },
  { id: 15, title: "Friend Request", description: "You have a new friend request.", read: false },
  { id: 16, title: "New Comment", description: "You have a new comment on your post.", read: false },
];

const NotificationDropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef(null);

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleMarkAsRead = (id) => {
    // Handle marking the notification as read
    console.log(`Marking notification ${id} as read`);
  };

  const handleClickOutside = (event) => {
    if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
      setIsOpen(false);
    }
  };

  useEffect(() => {
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

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
                <div className="notification-title">{notification.title}</div>
                <p>{notification.description}</p>
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
