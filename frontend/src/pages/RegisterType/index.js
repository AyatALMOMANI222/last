import React from "react";
import SVG from "react-inlinesvg";
import speaker from "../../icons/speaker.svg";
import attendance from "../../icons/attendance.svg";
import sponsor from "../../icons/sponsor.svg";
import group from "../../icons/group.svg";
import conferencesImg from "../../icons/conferencesImg.svg";
import { useNavigate } from "react-router-dom";
import "./style.scss";

const RegisterType = () => {
  const navigate = useNavigate();
  const handleNavigate = (type) => {
    navigate(`/registerPage/${type}`);
  };
  return (
    <div className="register-type-page">
      <div className="about-container">
        <SVG src={conferencesImg} />
        <div className="new-about-us-container">
          <div className="titlee">About Us</div>
          <div className="description">
            Our event brings together a diverse group of professionals,
            innovators, and thought leaders from various industries. Whether
            you're a speaker looking to share insights, an attendee eager to
            learn and network, a sponsor wanting to showcase your brand, or a
            group registering together, we provide tailored registration options
            to meet your needs. Choose the role that best fits your
            participation, and we look forward to having you with us.
          </div>
        </div>
      </div>
      <div className="register-type-section">
        <div className="welcome-titlee">Welcome to the Registration Page</div>

        <div className="register-note">
          Please select the appropriate option below to proceed with your
          registration. Whether you're a speaker, attendee, sponsor/exhibitor,
          or part of a group, we have tailored options to fit your needs.
        </div>
        <div className="register-types">
          <div className="type" onClick={() => handleNavigate("speaker")}>
            <SVG src={speaker} height={150} width={150} />
            <span className="titlee">Login As Speaker</span>
          </div>{" "}
          <div className="type" onClick={() => handleNavigate("attendance")}>
            <SVG src={attendance} height={150} width={150} />
            <span className="titlee">Login As Attendance</span>
          </div>{" "}
          <div
            className="type"
            onClick={() => handleNavigate("sponsor")}
          
          >
            <SVG src={sponsor} height={150} width={150} />
            <span className="titlee">Login As Sponsor/Exhibitor</span>
          </div>
          <div className="type" onClick={() => handleNavigate("group")}>
            <SVG src={group} height={150} width={150} />
            <span className="titlee">Login As Group Registration</span>
          </div>
          <div
            className="type"
            onClick={() => {
              navigate("/other");
            }}
          >
            <SVG src={group} height={150} width={150} />
            <span className="titlee">Other</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RegisterType;
