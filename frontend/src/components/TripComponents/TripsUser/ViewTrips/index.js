import React, { useEffect, useState } from "react";
import axios from "axios";
import httpService from "../../../../common/httpService";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import { backendUrlImages } from "../../../../constant/config";
import tripImage from "../../../../icons/tripImage.webp";
import { useAuth } from "../../../../common/AuthContext";
const ViewUserTrips = () => {
  const navigate = useNavigate();
  const [allTrips, setAllTrips] = useState([]);
  const [speakerTrip, setSpeakerData] = useState({});
  const [hasFreeTrip, setHasFreeTrip] = useState(false);
  const [selectedTripType, setSelectedTripType] = useState('private'); // حالة لتحديد نوع الرحلة
  const { myConferenceId } = useAuth();

  const token = localStorage.getItem("token");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getSpeakerInfo = () => {
    axios
      .get(`${BaseUrl}/speakers/${myConferenceId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        // Handle the success response
        console.log("Success:", response.data);
        setSpeakerData(response.data.speaker);
        // يمكنك التعامل مع البيانات هنا، مثل عرضها في واجهة المستخدم
        const speakerData = response.data.speaker;
        setHasFreeTrip(speakerData.free_trip);
        console.log("Speaker Details:", speakerData, hasFreeTrip);
      })
      .catch((error) => {
        // Handle the error response
        if (error.response) {
          // Response was received from the server but it returned an error status
          console.error("Error:", error.response.data);
          console.error("Status Code:", error.response.status);
        }
      });
  };

  const getAuthToken = () => localStorage.getItem("token");

  const getAllTrips = async () => {
    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/all-trip`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        withLoadder: true,
        withToast: false,
      });

      console.log(response?.trips);
      setAllTrips(response?.trips);
    } catch (error) {
      console.error("Error fetching conferences", error);
    }
  };

  function getGroupTrip(conferenceId) {
    axios
      .get(`${BaseUrl}/group/trip/${myConferenceId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        console.log(response.data); // طباعة البيانات
        setAllTrips(response.data.trips); // تحديث الـ state مع البيانات التي تم جلبها
      })
      .catch((error) => {
        console.error("There was an error!", error); // معالجة الخطأ
      });
  }

  useEffect(() => {
    getAllTrips(); // استدعاء الدالة الخاصة بجلب كل الرحلات عند تحميل الصفحة
    getSpeakerInfo();
  }, []);

  // دالة لتحديد نوع الرحلة بناءً على الضغط على الأزرار
  const handleTripTypeChange = (type) => {
    setSelectedTripType(type); // تعيين نوع الرحلة
    if (type === "group") {
      getGroupTrip(myConferenceId); // جلب بيانات رحلات المجموعة
    } else {
      getAllTrips(); // جلب بيانات جميع الرحلات
    }
  };

  return (
    <div className="trips-page">
      <div className="trips-users-container">
        <div className="trips-types-btn">
          {hasFreeTrip === 1 && (
            <button onClick={() => handleTripTypeChange("group")}>Group Trips</button>
          )}
          <button onClick={() => handleTripTypeChange("private")}>Private Trips</button>
        </div>
      </div>

      <div className="trip-cards">
        {allTrips?.map((trip) => (
          <div className="trip-card" key={trip.id}>
            <img
              src={`${backendUrlImages}${trip.image_1}`}
              onError={(e) => {
                e.currentTarget.src = tripImage;
              }}
              className="trip-image"
              alt="Trip Image"
            />

            <div className="trip-info">
              <div className="main-info">
                <div className="name">{trip.name}</div>
                <div className="desc">{trip.description}</div>
              </div>
              <div className="actions-btns">
                <button
                  className="view"
                  onClick={() => {
                    navigate(`/view/trip/${trip?.id}`);
                  }}
                >
                  Register for a Trip
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default ViewUserTrips;
