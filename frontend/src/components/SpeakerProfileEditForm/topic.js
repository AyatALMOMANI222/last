// Topics.js
import React, { useEffect } from "react";
import Input from "../../CoreComponent/Input";
import SVG from "react-inlinesvg";
import deleteIcon from "../../icons/deleteIcon.svg";
import "./style.scss";

const Topics = ({ topics, handleTopicChange, handleRemoveTopic, handleAddTopic }) => {
  useEffect(()=>{
    console.log({topics});
    
  }, [topics])
  return (
    <div className="topic-section">
      <div className="topics-container">
        <div className="topic-title">Topics</div>
        <div className="topics-container-inputs">
          {topics.map((topic, index) => (
            <div key={index} className="topic-input-container">
              <Input
                placeholder="Enter a topic"
                inputValue={topic}
                setInputValue={(newValue) => handleTopicChange(index, newValue)}
                className="topic-input"
              />
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={() => handleRemoveTopic(index)}
              />
            </div>
          ))}
          <button type="button" onClick={handleAddTopic} className="add-topic-btnn">
            + Add Topic
          </button>
        </div>
      </div>
    </div>
  );
};

export default Topics;
