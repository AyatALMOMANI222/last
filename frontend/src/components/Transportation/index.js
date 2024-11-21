import React, { useState } from 'react';
import './style.scss';
import axios from 'axios';

const Transportation3 = () => {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    whatsapp: '',
    passengers: '',
    pickupOption: '', // هنا سيخزن الخيار المختار
    flightCode: '',
    flightTime: '',
    additionalInfo: '',
    totalUSD: '',
  });

  const handleChange = (e) => {
    const { name, value, type } = e.target;
    if (type === 'radio') {
      setFormData({ ...formData, [name]: value });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // إرسال البيانات إلى الخادم باستخدام axios
    axios.post('http://127.0.0.1:8000/api/trans/req', {
      first_name: formData.firstName,
      last_name: formData.lastName,
      email: formData.email,
      whatsapp: formData.whatsapp,
      passengers: formData.passengers,
      pickup_option: formData.pickupOption, // إرسال الخيار المختار
      flight_code: formData.flightCode,
      flight_time: formData.flightTime,
      additional_info: formData.additionalInfo,
      total_usd: formData.totalUSD,
    })
    .then(response => {
      console.log('تم إرسال البيانات بنجاح:', response);
    })
    .catch(error => {
      console.error('حدث خطأ أثناء إرسال البيانات:', error);
    });
  };

  return (
    <div className="transportation-container">
      <form className="transportation-form" onSubmit={handleSubmit}>
        <h2>Transportation Request</h2>

        <div className="form-group">
          <div className="input-group">
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

          <div className="input-group">
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
        </div>

        <div className="form-group">
          <div className="input-group">
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

          <div className="input-group">
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
        </div>

        <div className="form-group">
          <label htmlFor="passengers">Number of Passengers</label>
          <input
            type="number"
            id="passengers"
            name="passengers"
            value={formData.passengers}
            onChange={handleChange}
            required
          />
        </div>

        <div className="form-group">
          <label>Pickup/Drop off</label>
          <div className="radio-group">
            <label>
              <input
                type="radio"
                name="pickupOption"
                value="pickup"
                checked={formData.pickupOption === 'pickup'}
                onChange={handleChange}
              />
              Pickup
            </label>
            <label>
              <input
                type="radio"
                name="pickupOption"
                value="dropOff"
                checked={formData.pickupOption === 'dropOff'}
                onChange={handleChange}
              />
              Drop off
            </label>
            <label>
              <input
                type="radio"
                name="pickupOption"
                value="both"
                checked={formData.pickupOption === 'both'}
                onChange={handleChange}
              />
              Both
            </label>
          </div>
        </div>

        <div className="form-group">
          <div className="input-group">
            <label htmlFor="flightCode">Flight Code</label>
            <input
              type="text"
              id="flightCode"
              name="flightCode"
              value={formData.flightCode}
              onChange={handleChange}
              required
            />
          </div>

          <div className="input-group">
            <label htmlFor="flightTime">Flight Time</label>
            <input
              type="text"
              id="flightTime"
              name="flightTime"
              value={formData.flightTime}
              onChange={handleChange}
              required
            />
          </div>
        </div>

        <div className="form-group">
          <label htmlFor="additionalInfo">Additional Information</label>
          <textarea
            id="additionalInfo"
            name="additionalInfo"
            value={formData.additionalInfo}
            onChange={handleChange}
          />
        </div>

        <div className="form-group">
          <label htmlFor="totalUSD">Total in USD</label>
          <input
            type="number"
            id="totalUSD"
            name="totalUSD"
            value={formData.totalUSD}
            onChange={handleChange}
            required
          />
        </div>

        <p className="note">
          Note: Please send your request for transportation at least 24 hours in advance!
        </p>

        <button type="submit" className="submit-btn">
          Submit Request
        </button>
      </form>
    </div>
  );
};

export default Transportation3;
