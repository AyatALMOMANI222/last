import React, { useState } from 'react';
import axios from 'axios';
import './style.scss'; // ملف CSS للتصميم

const TripForm = () => {
  const [formData, setFormData] = useState({
    title: '', 
    firstname: '',
    lastname: '',
    emailaddress: '',
    phonenumber: '',
    nationality: '',
    country: '',
    arrivalPoint: '',
    departurePoint: '',
    arrivalDate: '',
    departureDate: '',
    arrivalTime: '',
    departureTime: '',
    preferredHotel: '',
    duration: '',
    adults: '',
    children: '',
    preferredDestination: [],
    activities: [],
  });

  const destinations = ['Jerash', 'Petra', 'Wadi Rum', 'Dead Sea', 'Main Hot Spring', 'Mount Nebo', 'Other'];
  const activities = ['Adventure', 'Educational', 'Religious', 'Historical', 'Culinary', 'Medical', 'Other'];

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleCheckboxChange = (group, value) => {
    setFormData((prevData) => ({
      ...prevData,
      [group]: prevData[group].includes(value)
        ? prevData[group].filter((item) => item !== value)
        : [...prevData[group], value],
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    // إرسال البيانات إلى واجهة API الخاصة بك
    try {
      const response = await axios.post('http://127.0.0.1:8000/api/submit-tourism-trip', formData);
      alert('Data submitted successfully!');
    } catch (error) {
      alert('Error submitting data: ' + error.message);
    }
  };

  return (
    <div className="form-container889">
      <h2>Trip Booking Form</h2>
      <form onSubmit={handleSubmit}>
        <div className='inp'>
        <div className="form-group">
          <label>Title:</label>
          <select name="title" value={formData.title} onChange={handleChange} required>
            <option value="">Select Title</option>
            <option value="Mr">Mr</option>
            <option value="Mrs">Mrs</option>
            <option value="Miss">Miss</option>
          </select>
        </div>

        <div className="form-group">
          <label>First Name:</label>
          <input type="text" name="firstname" value={formData.firstname} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Last Name:</label>
          <input type="text" name="lastname" value={formData.lastname} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Email Address:</label>
          <input type="email" name="emailaddress" value={formData.emailaddress} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Phone Number:</label>
          <input type="text" name="phonenumber" value={formData.phonenumber} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Nationality:</label>
          <input type="text" name="nationality" value={formData.nationality} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Country of Residence:</label>
          <input type="text" name="country" value={formData.country} onChange={handleChange} required />
        </div>

 

        <div className="form-group">
          <label>Arrival Point:</label>
          <input type="text" name="arrivalPoint" value={formData.arrivalPoint} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Departure Point:</label>
          <input type="text" name="departurePoint" value={formData.departurePoint} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Arrival Date:</label>
          <input type="date" name="arrivalDate" value={formData.arrivalDate} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Departure Date:</label>
          <input type="date" name="departureDate" value={formData.departureDate} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Arrival Time:</label>
          <input type="time" name="arrivalTime" value={formData.arrivalTime} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Departure Time:</label>
          <input type="time" name="departureTime" value={formData.departureTime} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Preferred Hotel:</label>
          <input type="text" name="preferredHotel" value={formData.preferredHotel} onChange={handleChange} />
        </div>

        <div className="form-group">
          <label>Duration:</label>
          <input type="number" name="duration" value={formData.duration} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Adults:</label>
          <input type="number" name="adults" value={formData.adults} onChange={handleChange} required />
        </div>

        <div className="form-group">
          <label>Children:</label>
          <input type="number" name="children" value={formData.children} onChange={handleChange} required />
        </div>
        
        </div>
        <div className='sel'> 
        <div className="form-group">
          <label>Preferred Destinations:</label>
          {destinations.map((destination) => (
            <div key={destination} className="checkbox-group">
              <input
                type="checkbox"
                value={destination}
                onChange={() => handleCheckboxChange('preferredDestination', destination)}
              />
              <span>{destination}</span>
            </div>
          ))}
        </div>

        <div className="form-group">
          <label>Type of Activities:</label>
          {activities.map((activity) => (
            <div key={activity} className="checkbox-group">
              <input
                type="checkbox"
                value={activity}
                onChange={() => handleCheckboxChange('activities', activity)}
              />
              <span>{activity}</span>
            </div>
          ))}
        </div>
        </div>
        <button type="submit" className="submit-button">Submit</button>
      </form>
    </div>
  );
};

export default TripForm;
