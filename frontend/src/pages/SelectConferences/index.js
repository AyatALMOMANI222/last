import React, { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate, useLocation } from "react-router-dom";
import "./style.scss";


const SelectConferences = () => {
  const [allConference, setAllConference] = useState([]);
  const [conferenceName, setConferenceName] = useState("");
  const navigate = useNavigate();
  const location = useLocation();
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const getConference = () => {
    const searchQuery = conferenceName
      ? `?search=${encodeURIComponent(conferenceName)}`
      : "";
    const url = `${BaseUrl}/conferences/all`;
    console.log(BaseUrl);
    axios
      .get(url)
      .then((response) => {
        setAllConference(response.data.data);
      })
      .catch((error) => {});
  };

  useEffect(() => {
    getConference();
  }, [conferenceName]);

  const handleTitleClick = (conferenceId) => {
    const currentPath = location.pathname;
    console.log({ currentPath });
    if (currentPath === "/registerPage/attendance") {
      console.log("hedaya");

      navigate(`/register/attendance/${conferenceId}`);
    } else if (currentPath === "/registerPage/speaker") {
      navigate(`/register/speaker/${conferenceId}`);
    } else if (currentPath === "/registerPage/group") {
      navigate(`/register/group/${conferenceId}`);
    }else if (currentPath === "/registerPage/sponsor") {
      navigate(`/register/sponsor/${conferenceId}`);
    }
    // navigate(`${currentPath}/${conferenceId}`);
  };

  return (
    <div className="conferences">
      <h1 className="titlee">Available Conferences</h1>
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
