import React, { useState } from "react";
import axios from "axios";
import Input from "../../../CoreComponent/Input";
import "./style.scss"; // تأكد من استيراد ملف SCSS

const CreateJob = () => {
  const [eventsCoordinator, setEventsCoordinator] = useState("");
  const [responsibilities, setResponsibilities] = useState("");
  const [description, setDescription] = useState("");
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const token = localStorage.getItem("token");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const jobData = {
        events_coordinator: eventsCoordinator,
      responsibilities: responsibilities,
      description: description,
    };

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/job2",
        jobData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setSuccess("Job created successfully: " + response.data.job.events_coordinator);
      setError(null);
    } catch (error) {
      setError("Error creating job: " + (error.response?.data.message || error.message));
      setSuccess(null);
    }
  };

  return (
    <div className="container-create-job">
      <h2>Create Job</h2>
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <Input
            label="Job Title"
            type="text"
            placeholder="Enter job title"
            inputValue={eventsCoordinator}
            setInputValue={setEventsCoordinator}
          />
        </div>
        <div className="form-group">
          <Input
            label="Responsibilities"
            type="text"
            placeholder="Enter responsibilities"
            inputValue={responsibilities}
            setInputValue={setResponsibilities}
          />
        </div>
        <div className="form-group">
          <Input
            label="Description"
            className ="desc"
            type="text"
            placeholder="Enter job description"
            inputValue={description}
            setInputValue={setDescription}
          />
        </div>
        <button type="submit">Create Job</button>
      </form>
      {error && <p className="error">{error}</p>}
      {success && <p className="success">{success}</p>}
    </div>
  );
};

export default CreateJob;
