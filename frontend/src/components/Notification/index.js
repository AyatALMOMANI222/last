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
import { useAuth } from "../../common/AuthContext";

const NotificationDropdown = () => {
  const { userId } = useAuth();
  const [isOpen, setIsOpen] = useState(false);
  const [notifications, setNotifications] = useState([]);
  const navigate = useNavigate();
  const dropdownRef = useRef(null);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

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
        url: `${BaseUrl}/not`,
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
    try {
      const response = await httpService({
        method: "POST",
        url: `${BaseUrl}/notifications/${notiId}/read`,
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

  // useEffect(() => {
  //   getAllNotifications();
  //   const getAuthToken = () => localStorage.getItem("token");

  //   // إنشاء اتصال مع Pusher
  //   const echo = new Echo({
  //     broadcaster: "pusher",
  //     key: "f758542a1e5207c1b145", // مفتاح Pusher
  //     cluster: "ap2", // كلاستر Pusher
  //     forceTLS: true, // استخدام SSL
  //     authEndpoint: "http://127.0.0.1:8000/api/broadcasting/auth", // استخدام https
  //     auth: {
  //       headers: {
  //         Authorization: `Bearer ${getAuthToken()}`, // توكن المصادقة
  //       },
  //     },
  //   });

  //   // الاشتراك في القناة و الاستماع للأحداث
  //   const channel = echo.channel(`notifications.${userId}`); // اسم القناة
  //   console.log('Subscribed to channel:', channel.name);

  //   // الاستماع للأحداث التي تأتي من Pusher
  //   channel.listen("NotificationSent", (event) => {
  //     console.log("Event received:", event); // طباعة الحدث بالكامل

  //     console.log("New notification received:", event);
  //     if ( event.notification.message) {
  //       console.log("gggggggggggggg" ,event);
        
  //       // إضافة الإشعار إلى الحالة الخاصة بالإشعارات
  //       setNotifications((prevNotifications) => [
  //         ...prevNotifications,
  //         event.notification, // يجب أن يحتوي event.notification على بيانات الإشعار
  //       ]);
  //       toast.info("hhhhhhhhhhhhhhhhhhhhhhhhh");

  //       // عرض إشعار عبر Toast
  //       // toast.success(event.notification.message);
  //     }
  //   });
    
  //   // تسجيل أحداث الاتصال
  //   echo.connector.pusher.connection.bind("connected", () => {
  //     console.log("Successfully connected to Pusher!");
  //   });

  //   echo.connector.pusher.connection.bind("failed", () => {
  //     console.error("Failed to connect to Pusher.");
  //   });

  //   // التنظيف عند إلغاء الاشتراك
  //   // return () => {
  //   //   echo.disconnect();
  //   // };
  // }, [userId]); // التأكد من إعادة التفعيل عند تغيير userId
  useEffect(() => {
    getAllNotifications();
  
    const echo = new Echo({
      broadcaster: "pusher",
      key: "f758542a1e5207c1b145",
      cluster: "ap2",
      forceTLS: true,
      authEndpoint: "http://127.0.0.1:8000/api/broadcasting/auth",
      auth: {
        headers: {
          Authorization: `Bearer ${getAuthToken()}`, // إذا كنت تستخدم JWT
        },
      },
    });
  
    // الاشتراك في قناة Pusher
    const channel = echo.channel(`notifications.${userId}`); // تأكد من استخدام `userId` بشكل صحيح
  
    // الاستماع للحدث المرسل
    channel.listen("notification.sent", (event) => {
      console.log("Received notification:", event);
      setNotifications((prevNotifications) => [
        ...prevNotifications,
        event.notification, // إضافة الإشعار إلى الحالة الخاصة بالإشعارات
      ]);
      toast.info("New notification received!"); // يمكن عرض Toast لإعلام المستخدم
    });
  
    // تسجيل أحداث الاتصال
    echo.connector.pusher.connection.bind("connected", () => {
      console.log("Successfully connected to Pusher!");
    });
  
    echo.connector.pusher.connection.bind("failed", () => {
      console.error("Failed to connect to Pusher.");
    });
  
    return () => {
      // تنظيف الاتصال عند إزالة المكون
      echo.disconnect();
    };
  }, [userId]); // تأكد من أنه عند تغيير `userId` يتم تحديث الاشتراك
  
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
    (notification) => notification.is_read === 0
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
                read(notification.id);
                // أضف التوجيه إلى الرابط عند النقر على الإشعار
                if (
                  notification?.message?.includes("New speaker registration")
                ) {
                  navigate(
                    `/edit/speaker/data/${notification?.conference_id}/${notification?.register_id}`
                  );
                }
                if (
                  notification?.message?.includes("New Attendance registration")
                ) {
                  navigate(
                    `/edit/attendance/data/${notification?.conference_id}/${notification?.register_id}`
                  );
                } else if (
                  notification?.message?.includes("New visa request from user")
                ) {
                  navigate(`/admin/visa2/${notification?.register_id}`);
                } else if (
                  notification?.message?.includes("New group registration:")
                ) {
                  navigate(`/pending/users`);
                } else if (
                  notification?.message?.includes(
                    "Now you can access the activated file and download the registered names"
                  )
                ) {
                  navigate(`/add/excel`);
                } else if (
                  notification?.message?.includes(
                    "Check available flights on the website and select your option to proceed."
                  )
                ) {
                  navigate(`/flight/form`);
                } else if (
                  notification?.message?.includes(
                    "We are pleased to inform you that your profile is now active"
                  )
                ) {
                  navigate(`/speaker/profile`);
                } else if (
                  notification?.message?.includes(
                    "A new Abstract has been added "
                  )
                ) {
                  navigate(
                    `/abs/${notification?.register_id}/${notification?.conference_id}`
                  );
                } else if (
                  notification?.message?.includes("New sponsor registration")
                ) {
                  navigate(`/pending/users`);
                }
              }}
            >
              <div className="notification-content">
                <div className="notification-title">{notification.message}</div>
              </div>
            </div>
          ))}
        </div>
      )}
      <ToastContainer position="top-right" autoClose={5000} hideProgressBar={false} newestOnTop={true} closeOnClick />
    </div>
  );
};

export default NotificationDropdown;



// import React, { useState, useRef, useEffect } from "react";
// import SVG from "react-inlinesvg";
// import notification from "../../icons/notification.svg";
// import "./style.scss";
// import axios from "axios";
// import httpService from "../../common/httpService";
// import { useNavigate } from "react-router-dom";
// import { ToastContainer, toast } from "react-toastify"; // Import ToastContainer and toast
// import Echo from "laravel-echo"; // Import Echo
// import Pusher from "pusher-js"; // Import Pusher
// import "react-toastify/dist/ReactToastify.css"; // Import Toast styles
// import { useAuth } from "../../common/AuthContext";

// const NotificationDropdown = () => {
//   const { userId } = useAuth();
//   const [isOpen, setIsOpen] = useState(false);
//   const [notifications, setNotifications] = useState([]);
//   const navigate = useNavigate();
//   const dropdownRef = useRef(null);
//   const BaseUrl = process.env.REACT_APP_BASE_URL;

//   const toggleDropdown = () => {
//     setIsOpen(!isOpen);
//   };

//   const handleClickOutside = (event) => {
//     if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
//       setIsOpen(false);
//     }
//   };

//   const getAuthToken = () => localStorage.getItem("token");

//   const getAllNotifications = async () => {
//     try {
//       const response = await httpService({
//         method: "GET",
//         url: `${BaseUrl}/not`,
//         headers: { Authorization: `Bearer ${getAuthToken()}` },
//       });
//       const data = response?.data?.filter((item) => {
//         return !item?.is_read;
//       });
//       setNotifications(data);
//     } catch (error) {
//       console.error("Error fetching notifications", error);
//     }
//   };

//   const read = async (notiId) => {
//     try {
//       const response = await httpService({
//         method: "POST",
//         url: `${BaseUrl}/notifications/${notiId}/read`,
//         headers: { Authorization: `Bearer ${getAuthToken()}` },
//         data: {
//           user_id: userId,
//         },
//       });
//       getAllNotifications();
//       console.log(response);
//     } catch (error) {
//       console.error("Error fetching notifications", error);
//     }
//   };

//   // Set up Pusher Echo connection and listen for events
//   useEffect(() => {
//     getAllNotifications();

//     const echo = new Echo({
//       broadcaster: "pusher",
//       key: "f758542a1e5207c1b145", // Pusher Key
//       cluster: "ap2", // Pusher Cluster
//       forceTLS: true,
//       authEndpoint: "http://127.0.0.1:8000/api/broadcasting/auth", // Your auth endpoint
//       auth: {
//         headers: {
//           Authorization: `Bearer ${getAuthToken()}`, // If using JWT
//         },
//       },
//     });

//     const channel = echo.channel(`notifications.${userId}`);
//     channel.listen("NotificationSent", (event) => {
//       console.log("New notification received:", event);
//       if (event.notification.message) {
//         setNotifications((prevNotifications) => [
//           ...prevNotifications,
//           event.notification, // Add the new notification to the state
//         ]);

//         // Display the toast notification
//         toast.info(event.notification.message); // Show the notification message as a toast
//       }
//     });

//     // Connection events
//     echo.connector.pusher.connection.bind("connected", () => {
//       console.log("Successfully connected to Pusher!");
//     });

//     echo.connector.pusher.connection.bind("failed", () => {
//       console.error("Failed to connect to Pusher.");
//     });

//     return () => {
//       // Clean up and disconnect
//       echo.disconnect();
//     };
//   }, [userId]);

//   useEffect(() => {
//     if (isOpen) {
//       document.addEventListener("mousedown", handleClickOutside);
//     } else {
//       document.removeEventListener("mousedown", handleClickOutside);
//     }

//     return () => {
//       document.removeEventListener("mousedown", handleClickOutside);
//     };
//   }, [isOpen]);

//   // Filter unread notifications
//   const unreadNotifications = notifications.filter(
//     (notification) => notification.is_read === 0
//   );
//   const reversedNotifications = unreadNotifications.slice().reverse();

//   return (
//     <div className="notification-container" ref={dropdownRef}>
//       <div className="notification-icon" onClick={toggleDropdown}>
//         <SVG src={notification} fill="#000" />
//         {unreadNotifications.length > 0 && (
//           <span className="notification-badge">
//             {unreadNotifications.length}
//           </span>
//         )}
//       </div>
//       {isOpen && unreadNotifications.length > 0 && (
//         <div className="notification-dropdown">
//           {reversedNotifications.map((notification) => (
//             <div
//               key={notification.id}
//               className={`notification-item unread`}
//               onClick={() => {
//                 read(notification.id);
//                 if (notification?.message?.includes("New speaker registration")) {
//                   navigate(`/edit/speaker/data/${notification?.conference_id}/${notification?.register_id}`);
//                 } else if (notification?.message?.includes("New Attendance registration")) {
//                   navigate(`/edit/attendance/data/${notification?.conference_id}/${notification?.register_id}`);
//                 } else if (notification?.message?.includes("New visa request from user")) {
//                   navigate(`/admin/visa2/${notification?.register_id}`);
//                 } else if (notification?.message?.includes("New group registration:")) {
//                   navigate(`/pending/users`);
//                 } else if (notification?.message?.includes("Now you can access the activated file and download the registered names")) {
//                   navigate(`/add/excel`);
//                 } else if (notification?.message?.includes("Check available flights on the website and select your option to proceed.")) {
//                   navigate(`/flight/form`);
//                 } else if (notification?.message?.includes("We are pleased to inform you that your profile is now active")) {
//                   navigate(`/speaker/profile`);
//                 } else if (notification?.message?.includes("A new Abstract has been added")) {
//                   navigate(`/abs/${notification?.register_id}/${notification?.conference_id}`);
//                 } else if (notification?.message?.includes("New sponsor registration")) {
//                   navigate(`/pending/users`);
//                 }
//               }}
//             >
//               <div className="notification-content">
//                 <div className="notification-title">{notification.message}</div>
//               </div>
//             </div>
//           ))}
//         </div>
//       )}
//       <ToastContainer position="top-right" autoClose={5000} hideProgressBar={false} newestOnTop={true} closeOnClick />
//     </div>
//   );
// };

// export default NotificationDropdown;
