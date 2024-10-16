import React from 'react';
import './style.scss'; // تأكد من إنشاء ملف CSS للمكون

const Footer = () => {
    return (
        <footer className="footer">
            <div className="footer-content">
                <div className="logo-container2">
                    <img src="/image/logo3.jpg" alt="Company Logo" className="logo2" />
                </div>
                <div className="footer-links-icon">
                    <div className='footer-links'>
                    <a href="#">Home</a>
                    <a href="#">Services</a>
                    <a href="#">Events</a>
                    <a href="#">Travel & Tourism</a>
                    <a href="#">Contact Us</a>
                    </div>
                    <div>
                    {/* <div className="social-icons">
                    <a href="https://www.facebook.com" target="_blank" rel="noopener noreferrer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="white" viewBox="0 0 24 24" width="24" height="24">
                            <path d="M22.675 0h-21.35C.601 0 0 .601 0 1.325v21.351C0 23.399.601 24 1.325 24h21.351C23.399 24 24 23.399 24 22.675V1.325C24 .601 23.399 0 22.675 0zM12 24H8v-9H5V12h3V9.5c0-3.12 1.79-4.75 4.5-4.75 1.313 0 2.5.098 2.5.098v2.75h-1.406c-1.096 0-1.406.685-1.406 1.38V12h2.75l-.438 3h-2.312v9h-4z" />
                        </svg>
                    </a>
                    <a href="https://www.linkedin.com" target="_blank" rel="noopener noreferrer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="white" viewBox="0 0 24 24" width="24" height="24">
                            <path d="M19 0h-14C2.256 0 0 2.256 0 5v14c0 2.744 2.256 5 5 5h14c2.744 0 5-2.256 5-5V5c0-2.744-2.256-5-5-5zm-11 20H7v-9h2v9zm-1-10.414C7.64 9.586 7 8.946 7 8.214c0-1.117.917-2 2-2s2 .883 2 2c0 .732-.639 1.372-1.999 1.586zm13 10.414h-2v-5c0-1.144-.028-2.613-1.596-2.613-1.596 0-1.838 1.186-1.838 2.416v5h-2v-9h2v1.5c.267-.501 1.185-1.5 2.576-1.5 2.845 0 3.384 1.646 3.384 3.795v6z" />
                        </svg>
                    </a>
                    <a href="https://www.youtube.com" target="_blank" rel="noopener noreferrer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="white" viewBox="0 0 24 24" width="24" height="24">
                            <path d="M23.498 6.186c-.237-1.081-.93-1.947-1.934-2.36C20.256 3.5 12 3.5 12 3.5s-8.256 0-9.564.326C.432 4.238-.134 5.592.005 6.696 0 7.125 0 12 0 12s0 4.875.326 5.304c.237 1.082.93 1.947 1.934 2.36C3.744 20.5 12 20.5 12 20.5s8.256 0 9.564-.326c1.004-.413 1.697-1.278 1.934-2.36C24 16.875 24 12 24 12s0-4.875-.502-5.814zM9.545 15.903V8.097l6.577 3.903-6.577 3.903z" />
                        </svg>
                    </a>
                    <a href="https://www.whatsapp.com" target="_blank" rel="noopener noreferrer">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="white" viewBox="0 0 24 24" width="24" height="24">
                            <path d="M12 2C6.5 2 2 6.5 2 12c0 2.2.8 4.3 2.2 5.9L2 22l4.1-1.2C7.7 21.2 9.7 22 12 22c5.5 0 10-4.5 10-10S17.5 2 12 2zm3.6 15.5l-1.1.3c-.4.1-.7.2-1.1.2-1 0-1.8-.3-2.5-.8-.6-.5-1.1-1.3-1.4-2.1l-.3-1.1c-.1-.4 0-.9.3-1.1l1.5-1.2c.4-.3.9-.2 1.3 0 .4.2.7.4 1.1.5.4.1.8.1 1.2.1.2 0 .5 0 .7-.1.4-.1.7-.4.9-.8l.3-1.1c.1-.4 0-.8-.2-1.1-.2-.2-.6-.5-1-.7-.4-.2-.9-.5-1.4-.7-1-.5-1.5-.9-2-1.7-.5-.7-.8-1.5-1-2.5-.1-.3 0-.6.2-.8.2-.2.5-.3.8-.3.2 0 .5.1.7.2.5.3 1.1.5 1.7.7.6.2 1.2.5 1.7.9.5.4.8.9 1 1.5.2.6.3 1.2.1 1.8-.2.6-.5 1.1-.9 1.6-.4.4-.9.8-1.5 1.1-.6.2-1.3.3-2 .3-.4 0-.9-.1-1.3-.2-.4-.1-.8-.3-1.2-.6-.4-.3-.7-.7-.8-1.1l-.1-.2c-.1-.5.1-1 .5-1.3.4-.3 1-.4 1.4-.2.5.2.9.5 1.4.7.5.2.9.4 1.5.5.3.1.5 0 .8-.1.2-.1.5-.3.6-.6s.1-.5-.1-.7c-.3-.2-.6-.5-.9-.7-.4-.2-.8-.4-1.2-.6-.3-.1-.7-.3-1-.4-.2-.1-.4-.3-.4-.5s.1-.5.3-.7c.2-.2.5-.3.8-.3.4 0 .8.2 1.1.5.5.3 1 .6 1.4.8.5.3.8.7 1.1 1.1.3.4.6.8.8 1.3s.3 1 .1 1.5c-.2.5-.5 1-1 1.3-.4.3-.9.5-1.5.7-.5.2-1.2.3-1.9.3z" />
                        </svg>
                    </a>
                </div> */}
                    </div>
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
