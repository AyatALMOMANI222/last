import React, { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "./style.scss"; // استيراد ملف Sass

const UpcomingConferences = () => {
  const [conferences, setConferences] = useState([]);
  const [loading, setLoading] = useState(true);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const navigate = useNavigate();
  const handleViewUserDinner = (conferenceId) => {
    console.log(`User Dinner for Conference ID: ${conferenceId}`);
    navigate(`/table/dinner/speaker/${conferenceId}`);
  };
  const handleViewAirportBooking = (conferenceId) => {
    console.log(`Airport Booking for Conference ID: ${conferenceId}`);
    navigate(`/table/booking/airport/${conferenceId}`);

    // Navigate or fetch airport booking information
  };
  useEffect(() => {
    const fetchConferences = async () => {
      const token = localStorage.getItem("token");
      try {
        const response = await axios.get(`${BaseUrl}/con/upcoming`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setConferences(response.data.upcoming_conferences);
        console.log(response.data.upcoming_conferences);
      } catch (error) {
        console.error("Error fetching conferences:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchConferences();
  }, []);

  return (
    <div className="upcoming-conferences-container mt-5">
      <h2 className="text-center mb-4">Upcoming Conferences</h2>
      {loading ? (
        <div className="text-center">
          <div className="spinner-border" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
        </div>
      ) : (
        <div className="table-responsive">
          <table className="table table-striped">
            <thead>
              <tr>
                <th scope="col">Conference Name</th>
                <th scope="col">Description</th>
                <th scope="col">Start Date</th>
                <th scope="col">End Date</th>
                <th scope="col">Location</th>
                <th scope="col">Actions</th>
              </tr>
            </thead>
            <tbody>
              {conferences?.map((conference) => (
                <tr key={conference.id}>
                  <td>{conference.title}</td>
                  <td>{conference.description}</td>
                  <td>
                    {new Date(conference.start_date).toLocaleDateString(
                      "en-GB"
                    )}
                  </td>
                  <td>
                    {new Date(conference.end_date).toLocaleDateString("en-GB")}
                  </td>
                  <td>{conference.location}</td>
                  <td>
                    <button
                      className="submit-btn"
                      onClick={() => handleViewUserDinner(conference.id)}
                    >
                      View User Dinner
                    </button>
                    <button
                      className="submit-btn"
                      onClick={() => handleViewAirportBooking(conference.id)}
                    >
                      View Airport Booking
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

// Function to handle "View User Dinner" button click

// Function to handle "View Airport Booking" button click

export default UpcomingConferences;
