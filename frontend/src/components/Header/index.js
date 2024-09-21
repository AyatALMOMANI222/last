import React, { useState } from "react";
import SVG from "react-inlinesvg";
import { expandIcon, notification } from "../../icons/";
import ListOptions from "../../CoreComponent/ListOptions";
import "./style.scss";

const Header = ({ isExpand, setIsExpand }) => {
  return (
    <div className="header-container">
      <div className="expand-icon-container">
        <SVG src={expandIcon} onClick={() => setIsExpand(!isExpand)}></SVG>
      </div>
      <div className="taps-container">
        <ListOptions
          title="Hedaya Almomani"
          options={[
            { name: "Notification", icon: notification },
            { name: "Notification", icon: notification },
          ]}
        />
        <ListOptions
          title="Home"
          options={[
            { name: "Notification", icon: notification },
            { name: "Notification", icon: notification },
          ]}
        />
      </div>
    </div>
  );
};

export default Header;
