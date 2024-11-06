// ApplicantsList.js
import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import "./style.scss";
import { backendUrlImages } from "../../../../constant/config";

const ApplicantsList = () => {
  const { jobId } = useParams(); // الحصول على jobId من الرابط
  const [applicants, setApplicants] = useState([]);
  const [applicantError, setApplicantError] = useState(null);

  // Fetch applicants for the selected job
  useEffect(() => {
    const fetchApplicants = async () => {
      const token = localStorage.getItem("token");
      setApplicantError(null); // Reset any previous error

      try {
        const response = await axios.get(`http://127.0.0.1:8000/api/applicants/${jobId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setApplicants(response.data);
      } catch (error) {
        setApplicantError("Error fetching applicants: " + (error.response?.data?.message || error.message));
      }
    };

    fetchApplicants();
  }, [jobId]);

  return (
    <div className="applicant-list">
      <h2>Candidates for the Position</h2>
      {applicantError && <p className="error-message">{applicantError}</p>}
      
      {applicants.length > 0 ? (
        applicants.map((applicant) => (
          <div key={applicant.id} className="applicant-card">
            <h3>{applicant.first_name} {applicant.last_name}</h3>
            <p><strong>Phone:</strong> {applicant.phone}</p>
            <p><strong>WhatsApp:</strong> {applicant.whatsapp_number}</p>
            <p><strong>Email:</strong> {applicant.email}</p>
            <p><strong>Nationality:</strong> {applicant.nationality}</p>
            <p><strong>Address:</strong> {applicant.home_address}</p>
            <p><strong>Position:</strong> {applicant.position_applied_for}</p>
            <p><strong>Education:</strong> {applicant.educational_qualification}</p>
            <a 
              href={`http://127.0.0.1:8000/storage/${applicant.resume}`} 
              target="_blank" 
              rel="noopener noreferrer" 
              download 
              className="resume-link">
              Download Resume
            </a>
          </div>
        ))
      ) : (
        <p>No applicants found for this job.</p>
      )}
    </div>
  );
};

export default ApplicantsList;
