import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import DateInput from "../../CoreComponent/Date";
import SVG from "react-inlinesvg";
import deleteIcon from "../../icons/deleteIcon.svg";
import "./style.scss";

const EditConferenceForm = ({ conferenceData, setConferenceData }) => {
  const [title, setTitle] = useState(conferenceData.title);
  const [date, setDate] = useState(conferenceData.date);
  const [place, setPlace] = useState(conferenceData.place);
  const [topics, setTopics] = useState(conferenceData.topics || [""]);

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
    const updatedData = {
      ...conferenceData,
      title,
      date,
      place,
      topics,
    };
    setConferenceData(updatedData);
  };

  return (
    <form onSubmit={handleSubmit} className="conference-edit-form">
      <div className="edit-form-header">{title}</div>
      <div className="conference-edit-container">
        <div className="first-form">
          <Input
            label="Title"
            placeholder="Enter conference title"
            inputValue={title}
            setInputValue={setTitle}
            required
          />

          <DateInput
            label="Date"
            inputValue={date}
            setInputValue={setDate}
            required
          />

          <Input
            label="Place"
            placeholder="Enter conference location"
            inputValue={place}
            setInputValue={setPlace}
            required
          />
        </div>

        <div className="topics-container">
          <div className="new-section">Topics</div>
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
    </form>
  );
};

export default EditConferenceForm;
