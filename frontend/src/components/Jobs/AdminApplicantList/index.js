// JobList.js
import React, { useState, useEffect } from "react";
import axios from "axios";
import ApplicantsList from "./applicants/applicants";
import { useNavigate } from "react-router-dom";
import "./style.scss";

const JobApplicants= () => {
  const [jobs, setJobs] = useState([]);
  const [error, setError] = useState(null);
  const [activeJobId, setActiveJobId] = useState(null);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

const navigate =useNavigate()
  // Fetch jobs on component mount
  useEffect(() => {
    const fetchJobs = async () => {
      try {
        const response = await axios.get(`${BaseUrl}/all/job`);
        setJobs(response.data.jobs);
      } catch (error) {
        setError("Error fetching jobs: " + (error.response?.data?.message || error.message));
      }
    };

    fetchJobs();
  }, []);
  const viewApplicants = (jobId) => {
    navigate(`/job/admin/applicants/${jobId}`);
  };
  return (
    <div className="job-list">
      <h2>Available Jobs</h2>
      {error && <p className="error-message">{error}</p>}
      
      {jobs.map((job) => (
        <div key={job.id} className="job-card">
          <h3>{job.events_coordinator}</h3>
          <p><strong>Responsibilities:</strong> {job.responsibilities}</p>
          <p><strong>Description:</strong> {job.description}</p>
          <button onClick={() => viewApplicants(job.id)} className="view-applicants-button">
            View Applicants
          </button>
        </div>
      ))}

      {activeJobId && <ApplicantsList jobId={activeJobId} />}
    </div>
  );
};

export default JobApplicants;
