import React, { useEffect, useState, useCallback } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox";
import ImageUpload from "../../CoreComponent/ImageUpload";
import deleteIcon from "../../icons/deleteIcon.svg";
import SVG from "react-inlinesvg";
import httpService from "../../common/httpService";
import "./style.scss";
import { backendUrlImages } from "../../constant/config";

const SpeakerProfileForm = () => {
  const [speakerInfo, setSpeakerInfo] = useState({});
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
  const [error, setError] = useState({});
  const [topics, setTopics] = useState([]);
  const [profileDetails, setProfileDetails] = useState({
    userName: "",
    userImage: "",
    userBio: "",
  });
  const [isAccepted, setIsAccepted] = useState(false);

  const fetchSpeakerInfo = useCallback(async () => {
    try {
      const token = localStorage.getItem("token");
      const { data } = await axios.get(
        "http://127.0.0.1:8000/api/speakers/info",
        {
          headers: { Authorization: `Bearer ${token}` },
        }
      );

      const { speaker } = data;
      setProfileDetails({
        userName: speaker.name,
        userImage: speaker.image,
        userBio: speaker.biography,
      });
      console.log(speaker.image
      );
      
      setSpeakerInfo(speaker);
      setAttendanceOptions((prev) => ({
        ...prev,
        showOnlineOption: speaker.is_online_approved,
      }));
      let topics;
      try {
        topics = JSON.parse(speaker.topics);
      } catch {
        topics = [];
      }
      setTopics(Array.isArray(topics) ? topics : [topics]);
    } catch (error) {
      toast.error(
        error?.response?.data?.error || "Failed to fetch speaker info"
      );
    }
  }, []);

  useEffect(() => {
    fetchSpeakerInfo();
  }, [fetchSpeakerInfo]);
  useEffect(() => {
console.log(profileDetails.userImage);
  }, [profileDetails]);
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
        url: "http://127.0.0.1:8000/api/speakers/user/update",
        headers: { Authorization: `Bearer ${token}` },
        data: formData,
        withToast: true,
        onSuccess: () => toast.success("Information updated successfully!"),
        onError: (message) =>
          toast.error(message || "Failed to update information"),
        showLoader: true,
      });
    } catch {
      // Error handling within httpService, no additional handling required here.
    }
  };

  useEffect(() => {
    setAttendanceOptions((prev) => ({
      ...prev,
      onlineParticipation: prev.inPerson ? false : prev.onlineParticipation,
      inPerson: prev.onlineParticipation ? false : prev.inPerson,
    }));
  }, [attendanceOptions.inPerson, attendanceOptions.onlineParticipation]);

  const handleTopicChange = (index, newValue) => {
    setTopics((prev) =>
      prev.map((topic, i) => (i === index ? newValue : topic))
    );
  };

  const handleRemoveTopic = (index) =>
    setTopics((prev) => prev.filter((_, i) => i !== index));
  const handleAddTopic = () => setTopics((prev) => [...prev, ""]);

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
                <div>{profileDetails.userBio}</div>
              </div>
            </div>
          </div>
        </div>

        {/* File and Topic Uploads */}
        <div className="profile-files">
          <ImageUpload
            errorMsg=""
            required
            label="Abstract"
            allowedExtensions={["txt", "pdf", "doc", "docx"]}
            inputValue={formFiles.abstract}
            setInputValue={(file) =>
              setFormFiles((prev) => ({ ...prev, abstract: file }))
            }
            className="image-upload"
            placeholder="Abstract"
          />

          <ImageUpload
            errorMsg=""
            required
            label="Presentation File"
            allowedExtensions={["ppt", "pptx"]}
            inputValue={formFiles.presentationFile}
            setInputValue={(file) =>
              setFormFiles((prev) => ({ ...prev, presentationFile: file }))
            }
            className="image-upload"
            placeholder="Presentation File"

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
                  Add Topic
                </button>
              </div>
            </div>
          </div>
        </div>

        <button className="register-btn" type="submit">
          Update
        </button>
      </form>
    </div>
  );
};

export default SpeakerProfileForm;
