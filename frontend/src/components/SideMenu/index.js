import React, { Fragment, useState } from "react";
import { NavLink } from "react-router-dom";
import "./style.scss";
import { useAuth } from "../../common/AuthContext";

function SideMenu() {
  const [activeMenu, setActiveMenu] = useState(null);
  const { isAdmin, registrationType, isLoggedIn } = useAuth();
  const isSpeaker = registrationType === "speaker";
  const isAttendance = registrationType === "attendance";
  const isSponsor = registrationType === "sponsor";

  const speakerMenuItems = isSpeaker && !isAdmin
    ? [
        { label: "Visa", icon: "🛂", path: "/visa" },
        { label: "Flight", icon: "✈️", path: "/flight/form" },
        { label: "Airport Transfer", icon: "🚐", path: "/airport/transfer" },
        { label: "Reservation", icon: "🏨", path: "/reservation/form" },
        { label: "All Trips", icon: "🗺️", path: "/view-user-trips" },
        { label: "Gala Dinner", icon: "🍽️", path: "/gala/dinner" },
        { label: "Profile", icon: "👤", path: "/speaker/profile" },
      ]
    : [];

  const adminMenuItems = isAdmin
    ? [
        { label: "Conferences", icon: "🎓", path: "/conferences/page" },
        { label: "Exhibitions", icon: "🏢", path: "/exhibitions" },
        { label: "Trips", icon: "🧳", path: "/create/trip" },
        { label: "Flight Admin", icon: "✈️", path: "/flights" },
        { label: "Gala Dinner", icon: "🍷", path: "/gala" },
        { label: "Create Job", icon: "🛠️", path: "/job" },
        { label: "Messages", icon: "💬", path: "/msgs" },
        { label: "Job Applicants", icon: "📋", path: "/applicants/job/admin" },
        { label: "Trips Users Discount", icon: "💸", path: "/user" },
        { label: "Users", icon: "👥", path: "/pending/users" },
        { label: "Reservation Room Prices", icon: "🏠", path: "/room/prices" },
        { label: "Enter new flights", icon: "🛩️", path: "/enter/new/flights" },
        { label: "Group Registration Table", icon: "📊", path: "/admin/excel/table" },
        { label: "Dinner Table Speaker static", icon: "🍽️", path: "/table/dinner/speaker/1" },
        { label: "Add Clients", icon: "➕", path: "/add/client" },
        { label: "Sponsorship Packages", icon: "📦", path: "/sponsor/admin/add/table" },
        { label: "Sponsorship Option", icon: "⚙️", path: "/sponsor/option/form" },
        { label: "Booth Cost", icon: "🏬", path: "/sponsor/admin/booth/cost" },
        { label: "Upload Floor Plan", icon: "📐", path: "/admin/upload/floor" },
      ]
    : [];

  const menuItems = [ ...speakerMenuItems, ...adminMenuItems];

  const toggleMenu = (index) => {
    setActiveMenu((prev) => (prev === index ? null : index));
  };

  return (
    <Fragment>
      {isLoggedIn && (
        <div className="side-menu2">
          <div className="menu-header">
            <img
              className="new-logo"
              src="/image/newLogo.png"
              alt="Logo"
              height={"50px"}
            />
          </div>
          <ul className="menu-list">
            {menuItems.map((item, index) => (
              <li key={index} className="menu-item">
                <NavLink to={item.path} className="menu-link">
                  <span className="icon">{item.icon}</span>
                  <span className="label">{item.label}</span>
                </NavLink>
              </li>
            ))}
          </ul>
        </div>
      )}
    </Fragment>
  );
}

export default SideMenu;
