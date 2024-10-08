import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate, useLocation } from 'react-router-dom';
import './style.scss';

const SelectConferences = () => {
  const [allConference, setAllConference] = useState([]);
  const [conferenceName, setConferenceName] = useState('');
  const navigate = useNavigate();
  const location = useLocation();

  const getConference = () => {
    const searchQuery = conferenceName ? `?search=${encodeURIComponent(conferenceName)}` : '';
    const url = `http://127.0.0.1:8000/api/con${searchQuery}`;

    axios
      .get(url)
      .then((response) => {
        console.log("Conferences retrieved successfully:", response.data.data);
        setAllConference(response.data.data);
      })
      .catch((error) => {
        console.error("Error retrieving conferences:", error);
      });
  };

  useEffect(() => {
    getConference();
  }, [conferenceName]);

  const handleTitleClick = (conferenceId) => {
    const currentPath = location.pathname;
    navigate(`${currentPath}/${conferenceId}`);
  };

  return (
    <div className="conferences">
      <h1 className="title">Available Conferences</h1>
      <ul className="conference-list">
        {allConference.map((conference) => (
          <li
            key={conference.id}
            className="conference-item"
            onClick={() => handleTitleClick(conference.id)}
          >
            {conference.title}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default SelectConferences;