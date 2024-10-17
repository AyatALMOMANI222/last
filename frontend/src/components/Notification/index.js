import React, { useState, useRef, useEffect } from "react";
import SVG from "react-inlinesvg";
import notification from "../../icons/notification.svg";
import "./style.scss";
import axios from "axios";
import httpService from "../../common/httpService";
import { useNavigate } from "react-router-dom";

const NotificationDropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [notifications, setNotifications] = useState([]);
  const navigate = useNavigate();

  const dropdownRef = useRef(null);

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleMarkAsRead = (id) => {
    // Handle marking the notification as read
  };

  const handleClickOutside = (event) => {
    if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
      setIsOpen(false); // إغلاق الـ dropdown عند النقر خارجها
    }
  };

  const getAuthToken = () => localStorage.getItem("token");

  const getAllNotifications = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `http://127.0.0.1:8000/api/not`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      });

      console.log(response.data);
      setNotifications(response?.data);
    } catch (error) {
      console.error("Error fetching conferences", error);
    }
  };

  useEffect(() => {
    getAllNotifications();
  }, []);

  useEffect(() => {
    if (isOpen) {
      // إضافة مستمع للنقر عندما تكون القائمة مفتوحة
      document.addEventListener("mousedown", handleClickOutside);
    } else {
      // إزالة المستمع عندما تكون القائمة مغلقة
      document.removeEventListener("mousedown", handleClickOutside);
    }

    // إزالة المستمع عند إزالة المكون (لتجنب تسريب الذاكرة)
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [isOpen]);

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
              onClick={() => {
                console.log({ notification });
                if (
                  notification?.message?.includes("New speaker registration")
                ) {
                  navigate(
                    `/edit/speaker/data/${notification?.conference_id}/${notification?.register_id}`
                  );
                }
              }}
            >
              {!notification.read && <span className="notification-dot"></span>}
              <div className="notification-content">
                <div className="notification-title">{notification.message}</div>
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
