import React, { Fragment } from "react";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import NotificationDropdown from "../Notification";
import { useAuth } from "../../common/AuthContext";

const NavBar = () => {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();
  const { registrationType } = useAuth();

  const menuItems = [
    {
      title: "Home",
      links: [
        { label: "Our Story", url: "/about_us" },
        { label: "Team", url: "/our_team" },
        { label: "Clients", url: "/our_clients" },
        { label: "Gallery", url: "#" },
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
          subLinks: [{ label: "Gallery", url: "/past/event" }],
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
      title: "page",
      links: [
        { label: "Visa", url: "/visa" },
        { label: "Flight", url: "/flight/form" },
        { label: "Airport Transfer", url: "/airport/transfer" },
        { label: "Gala Dinner", url: "/gala/dinner" },
        { label: "Reservation", url: "/reservation/form" },
        { label: "All Trips", url: "/view-user-trips" },
        {
          label: "Airport Transfer Price",
          url: "/airport/transfer/price",
        },
        { label: "Gala Dinner", url: "/gala" },
      ],
    },
    ...(isAdmin
      ? [
          {
            title: "Admin",
            links: [
              { label: "Conferences", url: "/conferences/page" },
              { label: "Exhibitions", url: "/exhibitions" },
              { label: "Trips", url: "/create/trip" },
              { label: "Flight Admin", url: "/flights" },
              {
                label: "Airport Transfer Price",
                url: "/airport/transfer/price",
              },
              { label: "Gala Dinner", url: "/gala" },
              { label: "Create Job", url: "/job" },
              { label: "Messages", url: "/msgs" },
              { label: "Job Applicants", url: "/job/admin" },
              { label: "Sponsor Option Form", url: "/sponsor/option/form" },
              { label: "Users", url: "/pending/users" },
              { label: "Enter new flights", url: "/enter/new/flights" },
              { label: "Admin Sponsorship Packages", url: "/sponsor/admin/add/table" },
              { label: "Admin Sponsorship Option", url: "/sponsor/option/form" },
              { label: "Admin Booth Cost ", url: "/sponsor/admin/booth/cost" },


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
      links: [
        { label: "Profile", url: "/speaker/profile" }
      ]
    }
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
                    <div className="option-btn" onClick={() => navigate(link.url)}>
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
