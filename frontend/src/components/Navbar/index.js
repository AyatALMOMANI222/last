import React from "react";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import NotificationDropdown from "../Notification";
import ListOption from "../../CoreComponent/ListOptions";

const NavBar = () => {
  const navigate = useNavigate();
  const options = [
    {
      name: "Flights Section",
      icon: "",
      onClick: () => {
        navigate("/flights");
      },
    },
    {
      name: "Conferences",
      icon: "",
      onClick: () => {
        navigate("/conferences");
      },
    },
  ];
  return (
    <nav className="navbar-section">
      <div className="navbar-logo">
        <div className="logo">Events Consultant</div>
      </div>
      <ul className="navbar-links">
        <div
          className="option-btn"
          onClick={() => {
            navigate("/");
          }}
        >
          Home
        </div>
        <div
          className="option-btn"
          onClick={() => {
            navigate("/flight/form");
          }}
        >
          Flight Page
        </div>
        <div
          className="option-btn"
          onClick={() => {
            navigate("/reservation/form");
          }}
        >
          Reservation Page
        </div>
        <div
          className="option-btn"
          onClick={() => {
            navigate("/about");
          }}
        >
          About Us
        </div> 
        <div
          className="option-btn"
          onClick={() => {
            navigate('create/trip');
          }}
        >
          Admin Trip
        </div>   
        <div
          className="option-btn"
          onClick={() => {
            navigate('user');
          }}
        >
          users
        </div>
            <div
          className="option-btn"
          onClick={() => {
            navigate("/exhibitions");
          }}
        >
          Exhibitions
        </div>
     
        <ListOption title="Admin" options={options} />
        <a
          className="option-btn"
          href="mailto:ayatalmomani665@gmail.com?subject=Contact&body=Hello, I would like to get in touch regarding..."
        >
          Contact
        </a>
      </ul>
      <div className="navbar-auth">
        <NotificationDropdown />
        <div
          className="auth-btn"
          onClick={() => {
            navigate("/login");
          }}
        >
          Login
        </div>
        <div
          className="auth-btn register-btn"
          onClick={() => {
            navigate("/registertype");
          }}
        >
          Register
        </div>
      </div>
    </nav>
  );
};

export default NavBar;
