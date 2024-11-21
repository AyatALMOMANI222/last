import React, { useState } from 'react';
import axios from 'axios';
import './style.scss';

const TravelForm2 = () => {
  const [formData, setFormData] = useState({
    title: '',
    firstName: '',
    lastName: '',
    nationality: '',
    email: '',
    cellular: '',
    whatsapp: '',
    departureDate: '',
    arrivalDate: '',
    arrivalTime: '',
    departureTime: '',
    preferredAirline: '',
    departureFrom: '', // حقل يمكن للمستخدم إدخال قيمة فيه
    passportCopy: null,
  });

  const handleChange = (e) => {
    const { name, value, type, files } = e.target;
    if (type === 'file') {
      setFormData({ ...formData, [name]: files[0] });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    const formDataToSend = new FormData();
    formDataToSend.append('title', formData.title);
    formDataToSend.append('first_name', formData.firstName);
    formDataToSend.append('last_name', formData.lastName);
    formDataToSend.append('nationality', formData.nationality);
    formDataToSend.append('email', formData.email);
    formDataToSend.append('cellular', formData.cellular);
    formDataToSend.append('whatsapp', formData.whatsapp);
    formDataToSend.append('departure_date', formData.departureDate);
    formDataToSend.append('arrival_date', formData.arrivalDate);
    formDataToSend.append('arrival_time', formData.arrivalTime);
    formDataToSend.append('departure_time', formData.departureTime);
    formDataToSend.append('preferred_airline', formData.preferredAirline);
    formDataToSend.append('departure_from', formData.departureFrom); // تم إضافة القيمة المدخلة
    if (formData.passportCopy) {
      formDataToSend.append('passport_copy', formData.passportCopy);
    }

    // إرسال البيانات إلى API باستخدام axios
    axios
      .post('http://127.0.0.1:8000/api/ticket/booking', formDataToSend, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      })
      .then((response) => {
        console.log('Success:', response.data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });
  };

  return (
    <div className="travel-form-container">
      <form className="travel-form" onSubmit={handleSubmit}>
        <h2>Travel Information Form</h2>

        <div className="form-group">
          <label htmlFor="title">Title</label>
          <select
            id="title"
            name="title"
            value={formData.title}
            onChange={handleChange}
            required
          >
            <option value="">Select Title</option>
            <option value="Mr">Mr</option>
            <option value="Mrs">Mrs</option>
            <option value="Miss">Miss</option>
            <option value="Dr">Dr</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="firstName">First Name</label>
          <input
            type="text"
            id="firstName"
            name="firstName"
            value={formData.firstName}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="lastName">Last Name</label>
          <input
            type="text"
            id="lastName"
            name="lastName"
            value={formData.lastName}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="nationality">Nationality</label>
          <input
            type="text"
            id="nationality"
            name="nationality"
            value={formData.nationality}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="email">Email Address</label>
          <input
            type="email"
            id="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="cellular">Cellular Number</label>
          <input
            type="text"
            id="cellular"
            name="cellular"
            value={formData.cellular}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="whatsapp">Valid WhatsApp Number</label>
          <input
            type="text"
            id="whatsapp"
            name="whatsapp"
            value={formData.whatsapp}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="departureDate">Departure Date</label>
          <input
            type="date"
            id="departureDate"
            name="departureDate"
            value={formData.departureDate}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="arrivalDate">Arrival Date</label>
          <input
            type="date"
            id="arrivalDate"
            name="arrivalDate"
            value={formData.arrivalDate}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="arrivalTime">Arrival Time</label>
          <input
            type="time"
            id="arrivalTime"
            name="arrivalTime"
            value={formData.arrivalTime}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="departureTime">Departure Time</label>
          <input
            type="time"
            id="departureTime"
            name="departureTime"
            value={formData.departureTime}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="preferredAirline">Preferred Airline</label>
          <input
            type="text"
            id="preferredAirline"
            name="preferredAirline"
            value={formData.preferredAirline}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="departureFrom">Departure From</label>
          <input
            type="text"
            id="departureFrom"
            name="departureFrom"
            value={formData.departureFrom}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="passportCopy">Please upload a copy of your passport</label>
          <input
            type="file"
            id="passportCopy"
            name="passportCopy"
            onChange={handleChange}
            required
          />
        </div>

        <button type="submit" className="submit-btn">Submit</button>
      </form>
    </div>
  );
};

export default TravelForm2;
