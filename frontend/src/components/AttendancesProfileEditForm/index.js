import React, { useEffect, useState, useCallback } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox";
import ImageUpload from "../../CoreComponent/ImageUpload";
import deleteIcon from "../../icons/deleteIcon.svg";
import SVG from "react-inlinesvg";
import httpService from "../../common/httpService";
import { backendUrlImages } from "../../constant/config";
import { useAuth } from "../../common/AuthContext";
import "./style.scss";

const AttendanceProfileForm = () => {
  const { attendancesData, registrationType } = useAuth();
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [formFiles, setFormFiles] = useState({
    image: null,
  });
  const [attendanceOptions, setAttendanceOptions] = useState({
    showOnlineOption: false,
    inPerson: false,
    onlineParticipation: false,
  });
  const [profileDetails, setProfileDetails] = useState({
    userName: "",
    userImage: "",
    userBio: "",
  });

  const initializeProfileDetails = useCallback(() => {
    if (registrationType === "attendance") {
      setProfileDetails({
        userName: attendancesData?.attendance.name,
        userImage: attendancesData?.attendance.image,
        userBio: attendancesData?.attendance.biography,
      });
    }
  }, [registrationType, attendancesData]);

  useEffect(() => {
    initializeProfileDetails();
  }, [initializeProfileDetails]);

  const handleUpdate = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    Object.entries(formFiles).forEach(([key, value]) => {
      if (value) formData.append(key, value);
    });
    formData.append("online_participation", attendanceOptions.onlineParticipation ? 1 : 0);

    try {
      const token = localStorage.getItem("token");
      await httpService({
        method: "POST",
        url: `${BaseUrl}/attendances/user/update`,
        headers: { Authorization: `Bearer ${token}` },
        data: formData,
        withToast: true,
        showLoader: true,
      });
    } catch (error) {
      toast.error("An error occurred while updating.");
    }
  };

  const toggleAttendanceOptions = useCallback(() => {
    setAttendanceOptions((prev) => ({
      ...prev,
      onlineParticipation: prev.inPerson ? false : prev.onlineParticipation,
      inPerson: prev.onlineParticipation ? false : prev.inPerson,
    }));
  }, []);

  useEffect(() => {
    toggleAttendanceOptions();
  }, [attendanceOptions.inPerson, attendanceOptions.onlineParticipation]);

  return (
    <div className="attendance-profile-section-container">
      <form onSubmit={handleUpdate} className="attendance-profile-form">
        <div className="profile-container-img">
          <div className="profile-section">
            <img
              src={`${backendUrlImages}${profileDetails.userImage}`}
              alt="User Profile"
              className="profile-image-attendance"
            />
            <div className="profile-details">
              <div className="profile-name">{profileDetails.userName}</div>
              <div className="profile-bio">
                <div className="bio">{profileDetails.userBio}</div>
              </div>
            </div>
          </div>
        </div>

        <div className="profile-files">
          {attendanceOptions.showOnlineOption && (
            <div className="attendance-option">
              <h3 className="attendance-title">
                How would you like to attend the conference?
              </h3>
              <div className="attendance-checkboxes">
                <Checkbox
                  label="In-Person"
                  checkboxValue={attendanceOptions.inPerson}
                  setCheckboxValue={(value) =>
                    setAttendanceOptions((prev) => ({
                      ...prev,
                      inPerson: value,
                    }))
                  }
                  className="attendance-checkbox"
                />
                <Checkbox
                  label="Online"
                  checkboxValue={attendanceOptions.onlineParticipation}
                  setCheckboxValue={(value) =>
                    setAttendanceOptions((prev) => ({
                      ...prev,
                      onlineParticipation: value,
                    }))
                  }
                  className="attendance-checkbox"
                />
              </div>
              {attendanceOptions.onlineParticipation && (
                <div className="notice">
                  You will be provided with the Zoom link one day before the event.
                </div>
              )}
            </div>
          )}
        </div>

        <button className="update-btn" type="submit">
          Update
        </button>
      </form>
    </div>
  );
};

export default AttendanceProfileForm;
