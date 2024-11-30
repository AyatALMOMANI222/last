import React, { useEffect, useState } from "react";
import axios from "axios";
import "./style.scss";
import { backendUrlImages } from "../../constant/config";
import { useParams } from "react-router-dom";
const Speakers4 = ({ conferenceId }) => {
  const [speakers, setSpeakers] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  useEffect(() => {
    axios
      .get(`${BaseUrl}/speakers/all/${conferenceId}`)
      .then((response) => {
        setSpeakers(response.data);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  }, []);

  return (
    <div className="speakers-container">
      {speakers.map((speaker) => (
        <div className="speaker" key={speaker.id}>
          <div className="speaker-image">
            {speaker.image ? (
              <img
                src={`${backendUrlImages}/${speaker.image}`}
                alt={speaker.name}
                className="image"
              />
            ) : (
              <div className="image-placeholder">No Image</div>
            )}
          </div>
          <div className="speaker-details">
            <h3>{speaker.name}</h3>
          </div>
        </div>
      ))}
    </div>
  );
};

export default Speakers4;
