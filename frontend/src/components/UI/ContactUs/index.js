import React, { useState } from 'react';
import './style.scss'; // تأكد من أن لديك ملف CSS مخصص

const ContactUs = () => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    subject: '',
    message: '',
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // يمكنك إضافة منطق لإرسال البيانات هنا
    console.log('Form submitted:', formData);
  };

  return (
    <div className="contact-us-container">
      <h2>Write a message</h2>
      <p>If you got any questions, please do not hesitate to send us a message. We reply within 24 hours!</p>
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
        <button type="submit" className="send-button">Send</button>
      </form>
      <div className="contact-info">
        <h3>Our Contact Information</h3>
        <p>+962 6 581 9003</p>
        <p>+962 79 60 2002</p>
        <p>info@eventscons.com</p>
        <p>www.eventscons.com</p>
      </div>
    </div>
  );
};

export default ContactUs;
