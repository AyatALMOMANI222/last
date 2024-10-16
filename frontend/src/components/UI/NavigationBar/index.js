import React from 'react';
import { FaFacebookSquare, FaYoutube, FaLinkedin, FaWhatsapp } from "react-icons/fa";
import { IoLogoWhatsapp } from "react-icons/io";
import './style.scss';

const TopNavbar = () => {
  return (
    <div className="top-navbar">
      <div className="social-icons">
        <a href="https://api.whatsapp.com/send?phone=%2B962799602002&context=ARAo5sm4r6ZTo8lr-oRy6hlmCd9ITwHO7xN6Ud6GaV3SveqX57m776m658o7iMTGCb9uggMX9Zl5_YaykxTpkuoNVNbfLXYuEovu6C1Jzm_r4xpTQuxx5ivWkmJHGKQcVaHVa6EIkzQjfUd_PWcRRy1MoQ&source=FB_Page&app=facebook&entry_point=page_cta&fbclid=IwY2xjawF8MalleHRuA2FlbQIxMAABHdZQPIY8OrxxsO_xTcAFisdS8iTJyZTKz7d-Ch6Wo31GvEFBo7k8d2GLCw_aem_VeAG5zhzkh0YIC4mhjDa1Q" target="_blank" rel="noopener noreferrer" className="icon">
          <IoLogoWhatsapp size={30}  /> {/* تغيير حجم أيقونة WhatsApp */}
        </a>
        <a href="https://www.youtube.com/channel/UC6wJycA901VnU6chdmqP58Q" target="_blank" rel="noopener noreferrer" className="icon">
          <FaYoutube size={30} /> {/* تغيير حجم أيقونة YouTube */}
        </a>
        <a href="https://web.facebook.com/eventscons" target="_blank" rel="noopener noreferrer" className="icon">
          <FaFacebookSquare size={30} /> {/* تغيير حجم أيقونة Facebook */}
        </a>
        <a href="https://www.linkedin.com/company/events-consultant/" target="_blank" rel="noopener noreferrer" className="icon">
          <FaLinkedin size={30} /> {/* تغيير حجم أيقونة LinkedIn */}
        </a>
      </div>
    </div>
  );
}

export default TopNavbar;
