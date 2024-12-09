import React, { useState, useEffect } from "react";
import axios from "axios";
import "./style.scss"; // Assuming your styles are in 'style.scss'

const SpeakerUpdateForm = () => {
  const [speakerData, setSpeakerData] = useState(null);
  const [abstract, setAbstract] = useState(null);
  const [presentationFile, setPresentationFile] = useState(null);
  const [topics, setTopics] = useState("");
  const [onlineParticipation, setOnlineParticipation] = useState(false);
  const [responseMessage, setResponseMessage] = useState("");
  const [isEditing, setIsEditing] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const getAuthToken = () => localStorage.getItem("token");

  // Fetch speaker data if exists
  useEffect(() => {
    const fetchSpeakerData = async () => {
      try {
        const response = await axios.get(`${BaseUrl}/speakers/info`, {
          headers: { Authorization: `Bearer ${getAuthToken()}` },
        });
        if (response.data.speaker) {
          setSpeakerData(response.data.speaker);
          setIsEditing(true); // Show edit form if data exists
        }
      } catch (error) {
        setSpeakerData(null); // No data found, show new form
      }
    };

    fetchSpeakerData();
  }, []);

  const handleFileChange = (event, setFile) => {
    setFile(event.target.files[0]);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    const formData = new FormData();
    if (abstract) formData.append("abstract", abstract);
    if (presentationFile)
      formData.append("presentation_file", presentationFile);
    if (topics) formData.append("topics", topics);
    formData.append("online_participation", onlineParticipation);

    try {
      const response = isEditing
        ? await axios.put("/api/speaker/update", formData) // Update API
        : await axios.post("/api/speaker/create", formData); // Create API
      setResponseMessage(response.data.message);
    } catch (error) {
      const errorMessage =
        error.response?.data?.error || "An unexpected error occurred.";
      setResponseMessage(errorMessage);
    }
  };

  return (
    <div className="form-container99">
      <h2>{isEditing ? "Edit Speaker Details" : "Add Speaker Details"}</h2>
      {speakerData ? (
        <div className="existing-data">
          <p>
            <strong>Topics:</strong> {speakerData.topics}
          </p>
          <p>
            <strong>Online Participation:</strong>{" "}
            {speakerData.online_participation ? "Yes" : "No"}
          </p>
          {/* Display existing data and allow for editing */}
          <button className="edit-button" onClick={() => setIsEditing(true)}>
            Edit
          </button>
        </div>
      ) : (
        <form onSubmit={handleSubmit} className="speaker-form">
          <div className="form-group">
            <label htmlFor="abstract">Abstract (TXT, PDF, DOC, DOCX):</label>
            <input
              type="file"
              id="abstract"
              accept=".txt,.pdf,.doc,.docx"
              onChange={(e) => handleFileChange(e, setAbstract)}
            />
          </div>

          <div className="form-group">
            <label htmlFor="presentationFile">
              Presentation File (PPT, PPTX):
            </label>
            <input
              type="file"
              id="presentationFile"
              accept=".ppt,.pptx"
              onChange={(e) => handleFileChange(e, setPresentationFile)}
            />
          </div>

          <div className="form-group">
            <label htmlFor="topics">Topics:</label>
            <input
              type="text"
              id="topics"
              value={topics}
              onChange={(e) => setTopics(e.target.value)}
              placeholder="Enter topics"
            />
          </div>

          <div className="form-group">
            <label htmlFor="onlineParticipation">Online Participation:</label>
            <input
              type="checkbox"
              id="onlineParticipation"
              checked={onlineParticipation}
              onChange={(e) => setOnlineParticipation(e.target.checked)}
            />
          </div>

          <button type="submit">{isEditing ? "Update" : "Create"}</button>
        </form>
      )}
      {responseMessage && <p className="response-message">{responseMessage}</p>}
    </div>
  );
};

export default SpeakerUpdateForm;
