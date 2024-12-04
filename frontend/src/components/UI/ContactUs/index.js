import React, { useState } from 'react';
import axios from 'axios'; // استيراد مكتبة axios
import './style.scss';

const ContactUs = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [loading, setLoading] = useState(false);
  const [responseMessage, setResponseMessage] = useState('');
  const [isFormSent, setIsFormSent] = useState(false); // لتمييز حالة إرسال النموذج

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      // إرسال البيانات إلى API باستخدام axios
      const response = await axios.post(`${BaseUrl}/messages`, formData);
      
      setResponseMessage('Message sent successfully!');
      setIsFormSent(true); // تم إرسال النموذج بنجاح

    } catch (error) {
      setResponseMessage('Failed to send message. Please try again.');
    }

    setLoading(false);
  };

  return (
    <div className="contact-us-section">
    <div className="contact-us-container">
    <h2>Write a message</h2>
      <p>If you got any questions, please do not hesitate to send us a message. We reply within 24 hours!</p>

      {!isFormSent ? (
        <form onSubmit={handleSubmit} className="contact-form">
          <div className="form-group">
            <label>Name</label>
            <input
              type="text"
              name="name"
              value={formData.name}
              onChange={handleChange}
              required
              className="form-input"
            />
          </div>
          <div className="form-group">
            <label>Email</label>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              required
              className="form-input"
            />
          </div>
          <div className="form-group">
            <label>Subject</label>
            <input
              type="text"
              name="subject"
              value={formData.subject}
              onChange={handleChange}
              required
              className="form-input"
            />
          </div>
          <div className="form-group">
            <label>Message</label>
            <textarea
              name="message"
              value={formData.message}
              onChange={handleChange}
              required
              className="form-textarea"
            />
          </div>
          <button type="submit" className="send-button" disabled={loading}>
            {loading ? 'Sending...' : 'Send'}
          </button>
        </form>
      ) : (
        <div className="confirmation-message">
          <h3>Thank you for contacting us!</h3>
          <p>Your message has been sent successfully. We will get back to you within 24 hours.</p>
        </div>
      )}

      <div className="contact-info">
        <h3>Our Contact Information</h3>
        <p>+962 6 581 9003</p>
        <p>+962 79 60 2002</p>
        <p>info@eventscons.com</p>
        <p>www.eventscons.com</p>
      </div>
      </div>
      </div>
    );
};

export default ContactUs;
