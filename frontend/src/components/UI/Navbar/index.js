import React, { useState } from 'react';
import "./style.scss";

const Navbar = () => {
  const [activeMenu, setActiveMenu] = useState(null);

  const handleMouseEnter = (menu) => {
    setActiveMenu(menu);
  };

  const handleMouseLeave = () => {
    setActiveMenu(null);
  };

  return (
    <header className="navbar">
      <div className="logo">
        <img className='logo-img' src="/image/logo3.jpg" alt="Logo" />
      </div>
      <nav>
        <ul>
          <li onMouseEnter={() => handleMouseEnter('home')} onMouseLeave={handleMouseLeave}>
            <a href="/home">Home</a>
            {activeMenu === 'home' && (
              <ul className="dropdown">
                <li><a href="/about_us">Our Story</a></li>
                <li><a href="/our_team">Team</a></li>
                <li><a href="/our_clients">Clients</a></li>
                <li><a href="/gallery">Gallery</a></li>
                <li><a href="#">Careers</a></li>
                <li><a href="/faq">FAQs</a></li>
              </ul>
            )}
          </li>
          <li onMouseEnter={() => handleMouseEnter('services')} onMouseLeave={handleMouseLeave}>
            <a href="/ser">Services</a>
            {activeMenu === 'services' && (
              <ul className="dropdown">
                <li><a href="/conf">Conferences</a></li>
                <li><a href="/expositions">Exposition</a></li>
                <li><a href="/workshops">Workshops</a></li>
                <li><a href="/seminars">Seminars</a></li>
                <li><a href="/corporate_meetings">Corporate Meetings</a></li>
                <li><a href="/planning">Event Planning</a></li>
                <li><a href="/media_campaign">Media Campaigns</a></li>
                <li><a href="/logistic_secretarial">Logistics</a></li>
                <li><a href="/social_events">Social Events</a></li>
                <li><a href="/concept_creation">Concept Creation</a></li>
                <li><a href="/management_consulting">Management Consulting</a></li>
              </ul>
            )}
          </li>
          <li onMouseEnter={() => handleMouseEnter('events')} onMouseLeave={handleMouseLeave}>
            <a href="#">Events</a>
            {activeMenu === 'events' && (
              <ul className="dropdown">
                <li><a href="#">Upcoming Events</a></li>
                <li><a href="#">Previous Events</a></li>
              </ul>
            )}
          </li>
          <li onMouseEnter={() => handleMouseEnter('tnt')} onMouseLeave={handleMouseLeave}>
            <a href="#">Travel & Tourism</a>
            {activeMenu === 'tnt' && (
              <ul className="dropdown">
                <li><a href="/tour_slider">Sights</a></li>
                <li><a href="#">Packages</a></li>
                <li><a href="#">Tailor Made</a></li>
                <li><a href="#">Ticket Booking</a></li>
                <li><a href="#">Hotel Booking</a></li>
                <li><a href="#">Transportation</a></li>
              </ul>
            )}
          </li>
          <li><a href="/contact_us">Contact Us</a></li>
        </ul>
      </nav>
      <div className="login">
        <a href="#">Login</a>
      </div>
    </header>
  );
};

export default Navbar;
