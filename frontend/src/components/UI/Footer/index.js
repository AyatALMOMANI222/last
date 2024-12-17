import React from 'react';
import { FaFacebookSquare, FaYoutube, FaLinkedin, FaWhatsapp } from "react-icons/fa";
import { IoLogoWhatsapp } from "react-icons/io";
import './style.scss'; // تأكد من إنشاء ملف CSS للمكون

const Footer = () => {
    return (
        <footer className="footer">
            <div className="footer-content">
                <div className="logo-container2">
                    <img src="/image/logo3.jpg" alt="Company Logo" className="logo2" />
                </div>

                <div className="social-icons">
                    <a href="https://api.whatsapp.com/send?phone=%2B962799602002&context=ARAo5sm4r6ZTo8lr-oRy6hlmCd9ITwHO7xN6Ud6GaV3SveqX57m776m658o7iMTGCb9uggMX9Zl5_YaykxTpkuoNVNbfLXYuEovu6C1Jzm_r4xpTQuxx5ivWkmJHGKQcVaHVa6EIkzQjfUd_PWcRRy1MoQ&source=FB_Page&app=facebook&entry_point=page_cta&fbclid=IwY2xjawF8MalleHRuA2FlbQIxMAABHdZQPIY8OrxxsO_xTcAFisdS8iTJyZTKz7d-Ch6Wo31GvEFBo7k8d2GLCw_aem_VeAG5zhzkh0YIC4mhjDa1Q" target="_blank" rel="noopener noreferrer" className="icon">
                        <IoLogoWhatsapp size={30} /> {/* تغيير حجم أيقونة WhatsApp */}
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
                <div className="map-container">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d54162.63123254484!2d35.86073700000001!3d31.956435!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x151ca10ff839a7bf%3A0xa854064ff6e1a48b!2zRXZlbnRzIENvbnN1bHRhbnQgY29tcGFueSAtINi02LHZg9ipINin2YTZhdiz2KrYtNin2LEg2YTZhNmF2KTYqtmF2LHYp9iq!5e0!3m2!1sen!2sus!4v1728902606826!5m2!1sen!2sus"
                        width="100%"
                        height="200"
                        allowFullScreen
                        loading="lazy"
                        referrerPolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
        </footer>
    );
};

export default Footer;
