import React, { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import Input from "../../CoreComponent/Input";
import FileUpload from "../../CoreComponent/FileUpload";
import Checkbox from "../../CoreComponent/Checkbox";
import ImageUpload from "../../CoreComponent/ImageUpload";
import deleteIcon from "../../icons/deleteIcon.svg";
import SVG from "react-inlinesvg";
import httpService from "../../common/httpService";

import "./style.scss";
import { backendUrlImages } from "../../constant/config";

const SpeakerProfileForm = () => {
  const [speakerInfo, setSpeakerInfo] = useState({});
  const [image, setImage] = useState(null);
  const [abstract, setAbstract] = useState(null);
  const [presentationFile, setPresentationFile] = useState(null);
  const [showOnlineOption, setShowOnlineOption] = useState(false);
  const [inPerson, setInPerson] = useState(false);
  const [onlineParticipation, setOnlineParticipation] = useState(false);
  const [error, setError] = useState({});
  const [topics, setTopics] = useState([]);
  const [userName, setUserName] = useState("");
  const [userImage, setUserImage] = useState("");
  const [userBio, setUserBio] = useState("");
  const [isAccepted, setIsAccepted] = useState(false);

  useEffect(() => {
    const fetchSpeakerInfo = async () => {
      try {
        const token = getAuthToken();
        const response = await axios.get(
          "http://127.0.0.1:8000/api/speakers/info",
          {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
        );
        setUserBio(response.data.speaker.biography);
        setUserName(response.data.speaker.name);
        setUserImage(response.data.speaker.image);
        setSpeakerInfo(response.data.speaker);
        setShowOnlineOption(response.data.speaker.is_online_approved);
        setTopics(
          Array.isArray(response.data.speaker.topics)
            ? response.data.speaker.topics
            : [response.data.speaker.topics]
        );
      } catch (error) {
        toast.error(
          error?.response?.data?.error || "Failed to fetch speaker info"
        );
      }
    };

    fetchSpeakerInfo();
  }, []);

  const getAuthToken = () => localStorage.getItem("token");

  // const handleUpdate = async (e) => {
  //   e.preventDefault();

  //   const formData = new FormData();
  //   if (image) {
  //     formData.append("image", image);
  //   }
  //   if (abstract) {
  //     formData.append("abstract", abstract);
  //   }
  //   if (topics) {
  //     formData.append("topics", JSON.stringify(topics));
  //   }
  //   if (presentationFile) {
  //     formData.append("presentation_file", presentationFile);
  //   }
  //   formData.append("online_participation", onlineParticipation ? 1 : 0);

  //   try {
  //     const token = getAuthToken();
  //     await axios.post(
  //       "http://127.0.0.1:8000/api/speakers/user/update",
  //       formData,
  //       {
  //         headers: {
  //           Authorization: `Bearer ${token}`,
  //         },
  //       }
  //     );
  //     toast.success("Information updated successfully!");
  //   } catch (error) {
  //     toast.error(
  //       error?.response?.data?.error || "Failed to update information"
  //     );
  //   }
  // };

  const handleUpdate = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    if (image) {
      formData.append("image", image);
    }
    if (abstract) {
      formData.append("abstract", abstract);
    }
    if (topics) {
      formData.append("topics", JSON.stringify(topics));
    }
    if (presentationFile) {
      formData.append("presentation_file", presentationFile);
    }
    formData.append("online_participation", onlineParticipation ? 1 : 0);

    try {
      const token = getAuthToken();

      await httpService({
        method: "POST",
        url: "http://127.0.0.1:8000/api/speakers/user/update",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        data: formData,
        withToast: true, // لإظهار الـ Toast للإشعارات
        onSuccess: () => {
          toast.success("Information updated successfully!");
        },
        onError: (message) => {
          toast.error(message || "Failed to update information");
        },
        showLoader: true, // لإظهار اللودر أثناء تحميل البيانات
      });
    } catch (error) {
      // سيتم التعامل مع الخطأ داخل httpService، لذا يمكنك إزالة الكود هنا
    }
  };

  useEffect(() => {
    if (inPerson) {
      setOnlineParticipation(false);
    }
  }, [inPerson]);

  useEffect(() => {
    if (onlineParticipation) {
      setInPerson(false);
    }
  }, [onlineParticipation]);

  const handleTopicChange = (index, newValue) => {
    const updatedTopics = [...topics];
    updatedTopics[index] = newValue;
    setTopics(updatedTopics);
  };

  const handleRemoveTopic = (index) => {
    const updatedTopics = topics.filter((_, i) => i !== index);
    setTopics(updatedTopics);
  };

  const handleAddTopic = () => {
    setTopics([...topics, ""]);
  };

  return (
    <div className="speaker-profile-container">
      <form onSubmit={handleUpdate} className="speaker-profile-form">
        <div className="profile-container-img">
          <div className="profile-section">
            <img
              src={`${backendUrlImages}${userImage}`}
              alt="Image 1"
              className="profile-image"
            />

            <div className="profile-details">
              <div className="profile-name">{userName}</div>
              <div className="profile-bio">{userBio}</div>
            </div>
          </div>
        </div>

        {/* File and Topic Uploads */}
        <div className="profile-files">
          <ImageUpload
            errorMsg={""}
            required={true}
            label="Abstract"
            allowedExtensions={["txt", "pdf", "doc", "docx"]}
            inputValue={abstract}
            setInputValue={setAbstract}
            className="image-upload"
          />

          <ImageUpload
            errorMsg={""}
            required={true}
            label="Presentation File"
            allowedExtensions={["ppt", "pptx"]}
            inputValue={presentationFile}
            setInputValue={setPresentationFile}
            className="image-upload"
          />

          {showOnlineOption && (
            <div className="attendance-option">
              <h3 className="attendance-title">
                How would you like to attend the conference?
              </h3>
              <div className="attendance-checkboxes">
                <Checkbox
                  label="In-Person"
                  checkboxValue={inPerson}
                  setCheckboxValue={setInPerson}
                  className="attendance-checkbox"
                />
                <Checkbox
                  label="Online"
                  checkboxValue={onlineParticipation}
                  setCheckboxValue={setOnlineParticipation}
                  className="attendance-checkbox"
                />
              </div>
              {onlineParticipation && (
                <div className="notice">
                  You will be provided with the Zoom link for the conference or
                  your lecture one day before the event for participation.
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
                <div className="add-topic-btn-container">
                  <button
                    type="button"
                    onClick={handleAddTopic}
                    className="add-topic-btn"
                  >
                    Add Topic
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="register-btn-container">
          <button className="register-btn" type="submit">
            Update
          </button>
        </div>
      </form>
    </div>
  );
};

export default SpeakerProfileForm;
