import React, { useState } from "react";
import axios from "axios"; // استيراد axios
import Input from "../../CoreComponent/Input";
import ImageUpload from "../../CoreComponent/ImageUpload";
import DateInput from "../../CoreComponent/Date";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import TextArea from "../../CoreComponent/TextArea";
import SVG from "react-inlinesvg";
import deleteIcon from "../../icons/deleteIcon.svg";

const ConferencesAdmin = ({ setIsOpen }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [location, setLocation] = useState("");
  const [status, setStatus] = useState("upcoming");
  const [image, setImage] = useState(null);
  const [firstAnnouncement, setFirstAnnouncement] = useState(null);
  const [secondAnnouncement, setSecondAnnouncement] = useState(null);
  const [brochure, setBrochure] = useState(null);
  const [scientificProgram, setScientificProgram] = useState(null);

  const [topics, setTopics] = useState([""]);

  // Handler to update topics array
  const handleTopicChange = (index, newValue) => {
    const updatedTopics = [...topics];
    updatedTopics[index] = newValue;
    setTopics(updatedTopics);
  };

  // Add a new input for topic
  const handleAddTopic = () => {
    setTopics([...topics, ""]);
  };

  // Remove a topic input
  const handleRemoveTopic = (index) => {
    const updatedTopics = topics.filter((_, i) => i !== index);
    setTopics(updatedTopics);
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    // إعداد البيانات للإرسال
    const formData = {
      title,
      description,
      start_date: startDate,
      end_date: endDate,
      location,
      status,
      image,
      first_announcement_pdf: firstAnnouncement,
      second_announcement_pdf: secondAnnouncement,
      conference_brochure_pdf: brochure,
      conference_scientific_program_pdf: scientificProgram,
      topics,
      timestamps: new Date().toISOString(),
    };

    const token = localStorage.getItem('token')

    axios
      .post("http://127.0.0.1:8000/api/con", formData, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      })
      .then((response) => {
        console.log("Data submitted successfully: ", response.data);
        console.log(token);
        
      })
      .catch((error) => {
        console.error("Error submitting data: ", error);
      });
  };

  return (
    <div className="conference-form-admin">
      <div className="header-conference-form">Add New Conference</div>
      <div className="form-section">
        <Input
          label="Title"
          placeholder="Enter title"
          inputValue={title}
          setInputValue={setTitle}
          type="text"
          required
        />
        <TextArea
          label="Description"
          placeholder="Enter description"
          value={description}
          setValue={setDescription}
          type="text"
          required
        />
        <DateInput
          label="Start Date"
          placeholder="YYYY-MM-DD"
          inputValue={startDate}
          setInputValue={setStartDate}
          required
        />
        <DateInput
          label="End Date"
          placeholder="YYYY-MM-DD"
          inputValue={endDate}
          setInputValue={setEndDate}
          required
        />
        <Input
          label="Location"
          placeholder="Enter location"
          inputValue={location}
          setInputValue={setLocation}
          type="text"
          required
        />
        <Select
          options={[
            { value: "Upcoming", label: "Upcoming" },
            { value: "Past", label: "Past" },
          ]}
          value={status}
          setValue={setStatus}
          label="Status"
          errorMsg={""}
        />

        <ImageUpload
          label="Upload Image"
          inputValue={image}
          setInputValue={setImage}
          allowedExtensions={["jpg", "jpeg", "png"]}
        />

        <ImageUpload
          label="First Announcement PDF"
          inputValue={firstAnnouncement}
          setInputValue={setFirstAnnouncement}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Second Announcement PDF"
          inputValue={secondAnnouncement}
          setInputValue={setSecondAnnouncement}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Conference Brochure PDF"
          inputValue={brochure}
          setInputValue={setBrochure}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Conference Scientific Program PDF"
          inputValue={scientificProgram}
          setInputValue={setScientificProgram}
          allowedExtensions={["pdf"]}
        />
        <div className="topics-container">
          <div className="topic-title">
            Topics
            <span className="star">*</span>
          </div>
          <div className="topics-container-inputs">
            {topics.map((topic, index) => (
              <div key={index} className="topic-input-container">
                <Input
                  placeholder="Enter a topic"
                  inputValue={topic}
                  setInputValue={(newValue) =>
                    handleTopicChange(index, newValue)
                  }
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
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setIsOpen(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </div>
  );
};

export default ConferencesAdmin;
