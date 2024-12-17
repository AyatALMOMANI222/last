import React, { useEffect, useState, useCallback } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import Checkbox from "../../CoreComponent/Checkbox";
import ImageUpload from "../../CoreComponent/ImageUpload";
import httpService from "../../common/httpService";
import { backendUrlImages } from "../../constant/config";
import { useAuth } from "../../common/AuthContext";
import { useNavigate } from "react-router-dom";
import DateInput from "../../CoreComponent/Date";
import Topics from "./topic.js";
import "./style.scss";

const SpeakerProfileForm = () => {
  const { speakerData, attendancesData, registrationType } = useAuth();
  const [speakerInfo, setSpeakerInfo] = useState(null);
  const [video, setVideo] = useState(null);

  const [formFiles, setFormFiles] = useState({
    image: null,
    abstract: null,
    presentationFile: null,
  });
  const [formFiles2, setFormFiles2] = useState({
    image: null,
    abstract: null,
    presentationFile: null,
    video:null
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
  const navigate = useNavigate();
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const initializeProfileDetails = useCallback(() => {
    if (registrationType === "speaker") {
      setProfileDetails({
        userName: speakerData.speaker.name,
        userImage: speakerData.speaker.image,
        userBio: speakerData.speaker.biography,
      });
    }
  }, [registrationType, speakerData]);

  useEffect(() => {
    initializeProfileDetails();
  }, [initializeProfileDetails]);

  const handleUpdate = async (e) => {
    e.preventDefault();
    const formData = new FormData();

    formData.append("abstract", formFiles.abstract);
    formData.append("presentation_file", formFiles.presentationFile);
    formData.append("topics", JSON.stringify(topics));
    formData.append(
      "online_participation",
      attendanceOptions.onlineParticipation ? 1 : 0

    );

    formData.append("departure_date", departureDate);
    formData.append("arrival_date", arrivalDate);
    formData.append("video", video);

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
      // toast.error("An error occurred while updating.");
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

  const getSpeakerData = async () => {
    const token = localStorage.getItem("token");

    try {
      const response = await axios.get(
        "http://127.0.0.1:8000/api/speakers/info",
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      const topics = JSON.parse(response.data.speaker.topics || "[]");
      setTopics(topics)
      setFormFiles2({
        abstract: response?.data?.speaker?.abstract,
        image: response?.data?.speaker?.image,
        presentationFile: response?.data?.speaker?.presentation_file,
      });
      setArrivalDate(response?.data?.speaker?.arrival_date)
      setDepartureDate(response?.data?.speaker?.departure_date)
      setSpeakerInfo(response.data.speaker);
      setVideo(response?.data?.speaker?.video)
    } catch (error) {
      // console.error("Error fetching speaker info:", error);
    }
  };

  useEffect(() => {
    getSpeakerData();
  }, []);

  // Disable button logic
  const isButtonDisabled =
    !(formFiles.abstract || formFiles2.abstract) ||
    !(formFiles.presentationFile || formFiles2.presentationFile) ||
    !arrivalDate ||
    !departureDate ||
    !video ||
    topics.length === 0 ||
    topics.some((topic) => !topic.trim());

  return (
    <div className="speaker-section-container">
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
              required
              label="Abstract"
              allowedExtensions={["txt", "pdf", "doc", "docx"]}
              inputValue={formFiles.abstract}
              existingFile={formFiles2.abstract}
              setInputValue={handleFileChange("abstract")}
              className="image-upload"
              placeholder="Abstract"
            />
            <ImageUpload
              required
              label="Presentation File"
              allowedExtensions={["ppt", "pptx"]}
              inputValue={formFiles.presentationFile}
              existingFile={formFiles2.presentationFile}
              setInputValue={handleFileChange("presentationFile")}
              className="image-upload"
              placeholder="Presentation File"
            />
            <ImageUpload
              required
              label="Video"
              allowedExtensions={["ppt", "pptx", "mp4"]}
              inputValue={video}
              existingFile={formFiles2.video}
              setInputValue={setVideo}
              className="image-upload"
              placeholder="Video"
            />
            <DateInput
              label="Arrival Date"
              inputValue={arrivalDate}
              setInputValue={setArrivalDate}
              type="date"
            />
            <DateInput
              label="Departure Date"
              inputValue={departureDate}
              setInputValue={setDepartureDate}
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
            <Topics
              topics={topics}
              handleTopicChange={handleTopicChange}
              handleRemoveTopic={handleRemoveTopic}
              handleAddTopic={handleAddTopic}
            />
          </div>

          <button
            className={`update-btn ${isButtonDisabled ? "disabled" : ""}`}
            disabled={isButtonDisabled}
          >
            Update Profile
          </button>
        </form>
      </div>
    </div>
  );
};

export default SpeakerProfileForm;
