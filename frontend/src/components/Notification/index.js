import React, { useState, useRef, useEffect } from "react";
import SVG from "react-inlinesvg";
import notification from "../../icons/notification.svg";
import "./style.scss";
import axios from "axios";
import httpService from "../../common/httpService";
import { useNavigate } from "react-router-dom";
import { ToastContainer, toast } from "react-toastify"; // استيراد ToastContainer و toast
import Echo from "laravel-echo"; // استيراد Echo
import Pusher from "pusher-js"; // استيراد Pusher
import "react-toastify/dist/ReactToastify.css"; // استيراد الأنماط

const NotificationDropdown = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [notifications, setNotifications] = useState([]);
  const navigate = useNavigate();
  const dropdownRef = useRef(null);

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
  };

  const handleClickOutside = (event) => {
    if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
      setIsOpen(false);
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
      const data = response?.data?.filter((item) => {
        return !item?.is_read;
      });
      setNotifications(data);
    } catch (error) {
      console.error("Error fetching notifications", error);
    }
  };

  const read = async (notiId) => {
    const userId = localStorage.getItem("user_id");
    try {
      const response = await httpService({
        method: "POST",
        url: `http://127.0.0.1:8000/api/notifications/${notiId}/read`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        data: {
          user_id: userId,
        },
      });
      getAllNotifications();
      console.log(response);
    } catch (error) {
      console.error("Error fetching notifications", error);
    }
  };
  useEffect(() => {
    getAllNotifications();

    const echo = new Echo({
      broadcaster: "pusher",
      key: "743171d2766ff157a71a", // مفتاح Pusher
      cluster: "ap2", // كلاستر Pusher
      forceTLS: true,
      authEndpoint: "http://yourapp.test/broadcasting/auth", // اضبطه كما هو مطلوب
      auth: {
        headers: {
          Authorization: `Bearer ${getAuthToken()}`, // إذا كنت تستخدم JWT
        },
      },
    });

    // تسجيل أحداث الاتصال
    echo.connector.pusher.connection.bind("connected", () => {
      console.log("Successfully connected to Pusher!"); // طباعة رسالة نجاح الاتصال
    });

    echo.connector.pusher.connection.bind("failed", () => {
      console.error("Failed to connect to Pusher."); // طباعة رسالة فشل الاتصال
    });

    return () => {
      echo.disconnect(); // تنظيف الاتصال عند إزالة المكون
    };
  }, []); // تعمل فقط عند التركيب

  useEffect(() => {
    if (isOpen) {
      document.addEventListener("mousedown", handleClickOutside);
    } else {
      document.removeEventListener("mousedown", handleClickOutside);
    }

    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [isOpen]);

  // تصفية الإشعارات غير المقروءة
  const unreadNotifications = notifications.filter(
    (notification) => !notification.read
  );
  const reversedNotifications = unreadNotifications.slice().reverse();

  return (
    <div className="notification-container" ref={dropdownRef}>
      <div className="notification-icon" onClick={toggleDropdown}>
        <SVG src={notification} fill="#000" />
        {unreadNotifications.length > 0 && (
          <span className="notification-badge">
            {unreadNotifications.length}
          </span>
        )}
      </div>
      {isOpen && unreadNotifications.length > 0 && (
        <div className="notification-dropdown">
          {reversedNotifications.map((notification) => (
            <div
              key={notification.id}
              className={`notification-item unread`}
              onClick={() => {
                // read(notification.id);
                if (
                  notification?.message?.includes("New speaker registration")
                ) {
                  navigate(
                    `/edit/speaker/data/${notification?.conference_id}/${notification?.register_id}`
                  );
                } else if (
                  notification?.message?.includes("New visa request from user")
                ) {
                  navigate(
                    `/admin/visa2`
                  );
                }
              }}
            >
              {/* <span className="notification-dot"></span> */}
              <div className="notification-content">
                <div className="notification-title">{notification.message}</div>
                {/* <small>Unread</small> */}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default NotificationDropdown;
