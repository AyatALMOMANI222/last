import React, { useState } from 'react';
import axios from 'axios';
import './style.scss';

const TravelFormHotel = () => {
  const [responseMessage, setResponseMessage] = useState('');

  const [formData, setFormData] = useState({
    title: '',
    firstName: '',
    lastName: '',
    email: '',
    nationality: '',
    cellular: '',
    whatsapp: '',
    arrivalDate: '',
    departureDate: '',
    hotelCategory: '',
    hotelName: '',
    accompanyingPersons: 0,
    totalUSD: 0,
    roomType: '',
  });

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    if (type === 'checkbox') {
      setFormData({ ...formData, [name]: checked });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    try {
      const response = await axios.post('http://127.0.0.1:8000/api/travel/booking', formData);
      setResponseMessage(response.data.message || 'Form submitted successfully!');
      console.log('Response:', response.data);
    } catch (error) {
      setResponseMessage('An error occurred while submitting the form.');
      console.error('Error:', error.response || error.message);
    }
  };
  

  return (
    <div className="travel-form-container">
      <form onSubmit={handleSubmit} className="travel-form">
        <h2>Travel Booking Form</h2>

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
          <label htmlFor="whatsapp">WhatsApp Number</label>
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
          <label htmlFor="hotelCategory">Hotel Category</label>
          <select
            id="hotelCategory"
            name="hotelCategory"
            value={formData.hotelCategory}
            onChange={handleChange}
            required
          >
            <option value="">Select Category</option>
            <option value="Luxury">Luxury</option>
            <option value="Standard">Standard</option>
            <option value="Budget">Budget</option>
          </select>
        </div>

        <div className="form-group">
          <label htmlFor="hotelName">Hotel Name</label>
          <input
            type="text"
            id="hotelName"
            name="hotelName"
            value={formData.hotelName}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="accompanyingPersons">Number of Accompanying Persons</label>
          <input
            type="number"
            id="accompanyingPersons"
            name="accompanyingPersons"
            value={formData.accompanyingPersons}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="totalUSD">Total Amount (USD)</label>
          <input
            type="number"
            id="totalUSD"
            name="totalUSD"
            value={formData.totalUSD}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Room Type</label>
          <div className="room-options">
            <label>
              <input
                type="radio"
                name="roomType"
                value="Single"
                onChange={handleChange}
                required
              />
              Single Room
            </label>
            <label>
              <input
                type="radio"
                name="roomType"
                value="Double"
                onChange={handleChange}
                required
              />
              Double Room
            </label>
            <label>
              <input
                type="radio"
                name="roomType"
                value="King"
                onChange={handleChange}
                required
              />
              King Size Bedroom
            </label>
          </div>
        </div>

        <div className="form-group">
          <label>
            <input
              type="checkbox"
              name="acceptTerms"
              checked={formData.acceptTerms}
              onChange={handleChange}
            />
            I accept the terms and conditions
          </label>
        </div>

        <button type="submit" className="submit-btn">Submit</button>
      </form>
      {responseMessage && <p className="response-message">{responseMessage}</p>}

    </div>
  );
};

export default TravelFormHotel;
