import React, { useState } from "react";
import { NavLink } from "react-router-dom";
import "./style.scss";

function SideMenu() {
  const [activeMenu, setActiveMenu] = useState(null); // To track the expanded menu
  const isAdmin = true;
  const menuItems = [
    {
      label: "Home",
      icon: "🏠",
      children: [
        { label: "Home", path: "/home" },

        { label: "Conferences", path: "/conferences" },
        { label: "Exhibitions", path: "/page/exhibitions" },
        { label: "Our Story", path: "/about_us" },
        { label: "Team", path: "/our_team" },
        { label: "Clients", path: "/our_clients" },
        { label: "Gallery", path: "/gallery" },
        { label: "Careers", path: "/job/list" },
        { label: "FAQs", path: "/faq" },
      ],
    },
    {
      label: "Services",
      icon: "🛠️",
      children: [
        { label: "Conferences", path: "/conf" },
        { label: "Exposition", path: "/expositions" },
        { label: "Workshops", path: "/workshops" },
        { label: "Seminars", path: "/seminars" },
        { label: "Corporate Meetings", path: "/corporate_meetings" },
        { label: "Event Planning", path: "/planning" },
        { label: "Media Campaigns", path: "/media_campaign" },
        { label: "Logistics", path: "/logistic_secretarial" },
        { label: "Social Events", path: "/social_events" },
        { label: "Concept Creation", path: "/concept_creation" },
        { label: "Management Consulting", path: "/management_consulting" },
      ],
    },
    {
      label: "Events",
      icon: "🎉",
      children: [
        {
          label: "Upcoming Events",
          path: "#",
          subMenu: "upcoming",
          subLinks: [{ label: "Event", path: "up/event" }],
        },
        {
          label: "Previous Events",
          path: "#",
          subMenu: "previous",
          subLinks: [{ label: "Gallery", path: "/past/event" }],
        },
      ],
    },
    {
      label: "Travel & Tourism",
      icon: "✈️",
      children: [
        { label: "Sights", path: "/tour_slider" },
        // { label: "Packages", path: "/packages" },
        // {
        //   label: "Tailor Made",
        //   path: "#",
        //   subMenu: "tailorMade",
        //   subLinks: [
        //     { label: "Individuals (Form)", path: "#" },
        //     { label: "Groups (Form)", path: "#" },
        //   ],
        // },
        // { label: "Ticket Booking", path: "/ticket/booking" },
        // { label: "Hotel Booking", path: "/hotel/booking" },
        // { label: "Transportation", path: "/transportation" },
      ],
    },
    {
      label: "Page",
      icon: "📄",
      children: [
        { label: "Visa", path: "/visa" },
        { label: "Flight", path: "/flight/form" },
        { label: "Airport Transfer", path: "/airport/transfer" },
        { label: "Reservation", path: "/reservation/form" },
        { label: "All Trips", path: "/view-user-trips" },
        { label: "Airport Transfer Price", path: "/airport/transfer/price" },
        { label: "Gala Dinner", path: "/gala/dinner" },
      ],
    },
    ...(isAdmin
      ? [
          {
            label: "Admin",
            icon: "👨‍💻",
            children: [
              { label: "Conferences", path: "/conferences/page" },
              { label: "Exhibitions", path: "/exhibitions" },
              { label: "Trips", path: "/create/trip" },
              { label: "Flight Admin", path: "/flights" },
              {
                label: "Airport Transfer Price",
                path: "/airport/transfer/price",
              },
              { label: "Gala Dinner", path: "/gala/dinner" },

              { label: "Create Job", path: "/job" },
              { label: "Messages", path: "/msgs" },
              { label: "Job Applicants", path: "/job/admin" },
              { label: "Pending Users", path: "/user" },
              { label: "Users", path: "/pending/users" },
              { label: "Enter new flights", path: "/enter/new/flights" },
            ],
          },
        ]
      : []),
    ...(isAdmin
      ? [
          {
            label: "Admin Sponsor",
            icon: "👨‍💻",
            children: [
              {
                label: "Sponsorship Packages",
                path: "/sponsor/admin/add/table",
              },
              {
                label: "Sponsorship Option",
                path: "/sponsor/option/form",
              },
              {
                label: "Booth Cost",
                path: "/sponsor/admin/booth/cost",
              },
            ],
          },
        ]
      : []),
    {
      label: "Contact Us",
      icon: "📞",
      children: [{ label: "Contact Us", path: "/contact_us" }],
    },
    {
      label: "Profile",
      icon: "👤",
      children: [{ label: "Profile", path: "/speaker/profile" }],
    },
  ];

  const toggleMenu = (index) => {
    setActiveMenu((prev) => (prev === index ? null : index)); // Toggle or collapse
  };

  return (
    <div className="side-menu">
      <div className="menu-header">
        <img
          className="new-logo"
          src="/image/newLogo.png"
          alt="Logo"
          height={"50px"}
          // width={"50px"}
        />
      </div>
      <ul className="menu-list">
        {menuItems.map((item, index) => (
          <li
            key={index}
            className={`menu-item ${activeMenu === index ? "expanded" : ""}`}
          >
            <div className="menu-title" onClick={() => toggleMenu(index)}>
              <div>
                <span className="icon">{item.icon}</span>
                <span className="label">{item.label}</span>
              </div>

              {item.children.length > 0 && (
                <span className="arrow">
                  {activeMenu === index ? "▲" : "▼"}
                </span>
              )}
            </div>
            {item.children.length > 0 && (
              <ul className={`submenu ${activeMenu === index ? "open" : ""}`}>
                {item.children.map((child, childIndex) => (
                  <li key={childIndex} className="submenu-item">
                    <NavLink to={child.path}>{child.label}</NavLink>
                  </li>
                ))}
              </ul>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default SideMenu;
