import React, { Fragment } from "react";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import NotificationDropdown from "../Notification";
import ListOption from "../../CoreComponent/ListOptions";
import { getFromLocalStorage } from "../../common/localStorage";

const NavBar = () => {
  const navigate = useNavigate();
  const isAdmin = getFromLocalStorage(`isAdmin`);

  const menuItems = [
    {
      title: "Home",
      links: [
        { label: "Our Story", url: "/about_us" },
        { label: "Team", url: "/our_team" },
        { label: "Clients", url: "/our_clients" },
        { label: "Gallery", url: "#" },
        { label: "Careers", url: "#" },
        { label: "FAQs", url: "/faq" },
      ],
    },
    {
      title: "Services",
      links: [
        { label: "Conferences", url: "/conf" },
        { label: "Exposition", url: "/expositions" },
        { label: "Workshops", url: "/workshops" },
        { label: "Seminars", url: "/seminars" },
        { label: "Corporate Meetings", url: "/corporate_meetings" },
        { label: "Event Planning", url: "/planning" },
        { label: "Media Campaigns", url: "/media_campaign" },
        { label: "Logistics", url: "/logistic_secretarial" },
        { label: "Social Events", url: "/social_events" },
        { label: "Concept Creation", url: "/concept_creation" },
        { label: "Management Consulting", url: "/management_consulting" },
      ],
    },
    {
      title: "Events",
      links: [
        {
          label: "Upcoming Events",
          url: "#",
          subMenu: "upcoming",
          subLinks: [
            {
              label: "Event",
              url: "#",
            },
          ],
        },
        {
          label: "Previous Events",
          url: "#",
          subMenu: "previous",
          subLinks: [{ label: "Gallery", url: "#" }],
        },
      ],
    },
    {
      title: "Travel & Tourism",
      links: [
        { label: "Sights", url: "/tour_slider" },
        { label: "Packages", url: "/packages" },
        {
          label: "Tailor Made",
          url: "#",
          subMenu: "tailorMade",
          subLinks: [
            { label: "Individuals (Form)", url: "#" },
            { label: "Groups (Form)", url: "#" },
          ],
        },
        { label: "Ticket Booking", url: "/ticket/booking" },
        { label: "Hotel Booking", url: "/hotel/booking" },
        { label: "Transportation", url: "/transportation" },
      ],
    },
    {
      title: "Flight",
      links: [
        { label: "Flight", url: "/flight/form" },

        // { label: "Flight Admin", url: "/flights" },
        // { label: "Users Admin", url: "/user" },
      ],
    },
    {
      title:"page",
      links: [{ label: "Visa", url: "/visa" },{ label: "Airport Transfer", url: "/airport/transfer" }],
      

    },
    ...(isAdmin
      ? [
          {
            title: "Admin",
            links: [
              { label: "Conferences", url: "/conferences/page" },
              { label: "Exhibitions", url: "/exhibitions" },
              { label: "Reservation", url: "/reservation/form" },
              { label: "Trips", url: "/create/trip" },
              { label: "Trips User", url: "/trip/user" },
              { label: "All Trips", url: "/view-user-trips" },
              { label: "Flight Admin", url: "/flights" },
            ],
          },
        ]
      : []),
    {
      title: "Contact Us",
      links: [{ label: "Contact Us", url: "/contact_us" }],
    },
    {
      title: "Profile",
      links: [{ label: "Profile", url: "/speaker/profile" }],
    },
  ];

  const renderMenu = () => {
    return menuItems.map((menuItem, index) => (
      <div key={index} className="menu-section">
        <div className="menu-title">{menuItem.title}</div>
        <div className="menu-links">
          {menuItem.links.map((link, linkIndex) => (
            <div key={linkIndex} className="menu-item">
              {link.subLinks ? (
                <div className="has-submenu">
                  {link.label}
                  <div className="submenu">
                    {link.subLinks.map((subLink, subIndex) => (
                      <div
                        key={subIndex}
                        className="submenu-item"
                        onClick={() => navigate(subLink.url)}
                      >
                        {subLink.label}
                      </div>
                    ))}
                  </div>
                </div>
              ) : (
                <div className="option-btn" onClick={() => navigate(link.url)}>
                  {link.label}
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    ));
  };

  return (
    <nav className="new-navbar">
      <div className="navbar-logo">
        <img className="new-logo" src="/image/newLogo.png" alt="Logo" />
      </div>
      <ul className="navbar-links">{renderMenu()}</ul>
      <div className="navbar-auth">
        <NotificationDropdown />
        {!localStorage.getItem("token") ? (
          <Fragment>
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
          </Fragment>
        ) : (
          <div
            className="auth-btn register-btn"
            onClick={() => {
              localStorage.removeItem("token");
              navigate("login");
            }}
          >
            Logout
          </div>
        )}
      </div>
    </nav>
  );
};

export default NavBar;
