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
import { useNavigate } from "react-router-dom";
import DateInput from "../../CoreComponent/Date";
import "./style.scss";

const SpeakerProfileForm = () => {
  const { speakerData, attendancesData, registrationType } = useAuth();
  const [speakerInfo ,setSpeakerInfo]=useState()
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const navigate = useNavigate();
  const [formFiles, setFormFiles] = useState({
    image: null,
    abstract: null,
    presentationFile: null,
  });
  const [attendanceOptions, setAttendanceOptions] = useState({
    showOnlineOption: false,
    inPerson: false,
    onlineParticipation: false,
  });
  const [topics, setTopics] = useState([]);
  const [profileDetails, setProfileDetails] = useState({
    userName: "",
    userImage: "",
    userBio: "",
  });

  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");

  const initializeProfileDetails = useCallback(() => {
    if (registrationType === "speaker") {
      setProfileDetails({
        userName: speakerData.speaker.name,
        userImage: speakerData.speaker.image,
        userBio: speakerData.speaker.biography,
      });
    } else if (registrationType === "attendance") {
      setProfileDetails({
        userName: attendancesData?.attendance.name,
        userImage: attendancesData?.attendance.image,
        userBio: attendancesData?.attendance.biography,
      });
    }
  }, [registrationType, speakerData, attendancesData]);

  useEffect(() => {
    initializeProfileDetails();
  }, [initializeProfileDetails]);

  const handleUpdate = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    Object.entries(formFiles).forEach(([key, value]) => {
      if (value) formData.append(key, value);
    });
    formData.append("topics", JSON.stringify(topics));
    formData.append(
      "online_participation",
      attendanceOptions.onlineParticipation ? 1 : 0
    );

    try {
      const token = localStorage.getItem("token");
      await httpService({
        method: "POST",
        url: `${BaseUrl}/speakers/user/update`,
        headers: { Authorization: `Bearer ${token}` },
        data: formData,
        withToast: true,
        showLoader: true,
      });
      navigate("/visa");
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

  const handleTopicChange = (index, newValue) => {
    setTopics((prev) =>
      prev.map((topic, i) => (i === index ? newValue : topic))
    );
  };

  const handleRemoveTopic = (index) => {
    setTopics((prev) => prev.filter((_, i) => i !== index));
  };

  const handleAddTopic = () => {
    setTopics((prev) => [...prev, ""]);
  };

  const handleFileChange = (key) => (file) => {
    setFormFiles((prev) => ({ ...prev, [key]: file }));
  };
  const getSpeakerData =()=>{

// فرضًا أن الـ token موجود في `localStorage`
const token = localStorage.getItem("token");

axios.get("http://127.0.0.1:8000/api/speakers/info", {
  headers: {
    Authorization: `Bearer ${token}`, // إضافة الـ token في الـ headers
  }
})
  .then(response => {
    // التعامل مع البيانات بعد جلبها
    console.log('Speaker Info:', response.data.speaker);
    const sp =response.data.speaker
    setSpeakerInfo(sp)
    console.log(speakerInfo);
    
  })
  .catch(error => {
    // التعامل مع الأخطاء في حالة فشل الطلب
    console.error('Error fetching speaker info:', error);
  });

  }
  useEffect(()=>{
    getSpeakerData()
  },[])

  return (
    <div className="speaker-profile-section-container">
      <form onSubmit={handleUpdate} className="speaker-profile-form">
        <div className="profile-container-img">
          <div className="profile-section">
            <img
              src={`${backendUrlImages}${profileDetails.userImage}`}
              alt="User Profile"
              className="profile-image-speakerr"
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
          <ImageUpload
            errorMsg=""
            required
            label="Abstract"
            allowedExtensions={["txt", "pdf", "doc", "docx"]}
            inputValue={formFiles.abstract}
            setInputValue={handleFileChange("abstract")}
            className="image-upload"
            placeholder="Abstract"
          />
          <ImageUpload
            errorMsg=""
            required
            label="Presentation File"
            allowedExtensions={["ppt", "pptx"]}
            inputValue={formFiles.presentationFile}
            setInputValue={handleFileChange("presentationFile")}
            className="image-upload"
            placeholder="Presentation File"
          />
          <DateInput
            label="Arrival Date"
            inputValue={arrivalDate}
            setInputValue={setArrivalDate}
            // className="date-input"
            type="date"
          />
          <DateInput
            label="Departure Date"
            inputValue={departureDate}
            setInputValue={setDepartureDate}
            // className="date-input"
            type="date"
          />
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
                  You will be provided with the Zoom link one day before the
                  event.
                </div>
              )}
            </div>
          )}
          <div className="topic-section">
            <div className="topics-container">
              <div className="topic-title">Topics</div>
              <div className="topics-container-inputs">
                {topics.map((topic, index) => (
                  <div key={index} className="topic-input-container">
                    <Input
                      placeholder="Enter a topic"
                      inputValue={topic}
                      setInputValue={(newValue) =>
                        handleTopicChange(index, newValue)
                      }
                      className="topic-input"
                    />
                    <SVG
                      className="delete-icon"
                      src={deleteIcon}
                      onClick={() => handleRemoveTopic(index)}
                    />
                  </div>
                ))}
                <button
                  type="button"
                  onClick={handleAddTopic}
                  className="add-topic-btnn"
                >
                 +  Add Topic
                </button>
              </div>
            </div>
          </div>
        </div>

        <button className="update-btn" type="submit">
          Update
        </button>
      </form>
    </div>
  );
};

export default SpeakerProfileForm;
