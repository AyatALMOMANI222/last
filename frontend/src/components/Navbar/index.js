import React, { Fragment } from "react";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import NotificationDropdown from "../Notification";
import { useAuth } from "../../common/AuthContext";

const NavBar = () => {
  const navigate = useNavigate();
  const { logout, isLoggedIn } = useAuth();

  const menuItems = [
    {
      title: "Home",
      links: [
        { label: "Home", url: "/home" },
        { label: "Conferences", url: "/conferences" },
        { label: "Exhibitions", url: "/page/exhibitions" },
        { label: "Our Story", url: "/about_us" },
        { label: "Team", url: "/our_team" },
        { label: "Clients", url: "/our_clients" },
        { label: "Gallery", url: "/gallery" },
        { label: "Careers", url: "/job/list" },
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
              url: "up/event",
            },
          ],
        },
        {
          label: "Previous Events",
          url: "#",
          subMenu: "previous",
          subLinks: [{ label: "Gallery", url: "/gallery" }],
        },
      ],
    },
    {
      title: "Travel & Tourism",
      links: [{ label: "Sights", url: "/tour_slider" }],
    },
    // {
    //   title: "Contact Us",
    //   links: [{ label: "Contact Us", url: "/contact_us" }],
    // },
    // {
    //   title: "About",
    //   links: [{ label: "About", url: "//about" }],
    // },
  ];

  const renderMenu = () => {
    return menuItems.map((menuItem, index) => {
      if (menuItem) {
        return (
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
                    <div
                      className="option-btn"
                      onClick={() => navigate(link.url)}
                    >
                      {link.label}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        );
      }
      return null;
    });
  };

  return (
    <nav className="new-navbar">
      <div className="navbar-logo">
        {!isLoggedIn && (
          <img className="new-logo" src={require("./logo.png")} alt="Logo" />
        )}
      </div>
      <div className="navbar-links">
        {renderMenu()}
        <div className="menuu">
          <div
            className="menu-title"
            onClick={() => navigate("/contact_us")}
            style={{ cursor: "pointer" }}
          >
            {"Contact Us"}
          </div>
          <div
            className="menu-title"
            onClick={() => navigate("/about")}
            style={{ cursor: "pointer" }}
          >
            {"About"}
          </div>
        </div>
      </div>
      <div className="navbar-auth">
        {isLoggedIn && <NotificationDropdown />}{" "}
        {!isLoggedIn ? (
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
              logout();
              navigate("/login");
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
