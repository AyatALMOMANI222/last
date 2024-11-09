import React, { useEffect, useState } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import "./style.scss";

const BookingsTable = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [bookings, setBookings] = useState([]);
  const [selectedSpeaker, setSelectedSpeaker] = useState(null);
  const [loading, setLoading] = useState(true);
  const { conferenceId } = useParams();
  useEffect(() => {
    const fetchBookings = async () => {
      try {
        const token = localStorage.getItem("token");
        const response = await axios.get(
          `${BaseUrl}/admin/airport/${conferenceId}`,
          {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
        );
        console.log(response.data);

        setBookings(response.data);
      } catch (error) {
        console.error("Error fetching bookings:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, []);

  const handleRowClick = (booking) => {
    setSelectedSpeaker(booking.speaker || null);
  };

  const handleCloseModal = () => {
    setSelectedSpeaker(null);
  };

  return (
    <div className="bookings-table-container mt-5">
      <h2 className="text-center mb-4">Bookings List</h2>
      {loading ? (
        <div className="text-center">
          <div className="spinner-border" role="status">
            <span className="visually-hidden">Loading...</span>
          </div>
        </div>
      ) : (
        <div className="row">
          {bookings.map((booking) => (
            <div className="col-md-6 mb-4" key={booking.id}>
              <div
                className="card booking-card"
                onClick={() => handleRowClick(booking)}
                style={{ cursor: "pointer" }}
              >
                <div className="card-body">
                  <h5 className="card-title">{`Booking Number: ${booking.id}`}</h5>
                  <p className="card-text">
                    <strong>Trip Type:</strong> {booking.trip_type}
                  </p>
                  <p className="card-text">
                    <strong>Arrival Date:</strong> {booking.arrival_date}
                  </p>
                  <p className="card-text">
                    <strong>Arrival Time:</strong> {booking.arrival_time}
                  </p>
                  <p className="card-text">
                    <strong>Flight Number:</strong> {booking.flight_number}
                  </p>
                  <p className="card-text">
                    <strong>Companion Name:</strong>{" "}
                    {booking.companion_name || "None"}
                  </p>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {selectedSpeaker && (
        <div className="modal show" style={{ display: "block" }}>
          <div className="modal-dialog">
            <div className="modal-content">
              <div className="modal-header">
                <h5 className="modal-title">Speaker Details</h5>
                <button
                  type="button"
                  className="close"
                  onClick={handleCloseModal}
                >
                  <span>&times;</span>
                </button>
              </div>
              <div className="modal-body">
                <p>
                  <strong>Speaker Name:</strong> {selectedSpeaker.user_id}
                </p>
                <p>
                  <strong>Conference Number:</strong>{" "}
                  {selectedSpeaker.conference_id}
                </p>
                <p>
                  <strong>Dinner Invitation:</strong>{" "}
                  {selectedSpeaker.dinner_invitation ? "Yes" : "No"}
                </p>
                <p>
                  <strong>Airport Pickup:</strong>{" "}
                  {selectedSpeaker.airport_pickup ? "Yes" : "No"}
                </p>
                {/* You can add more fields as needed */}
              </div>
              <div className="modal-footer">
                <button
                  type="button"
                  className="btn btn-secondary"
                  onClick={handleCloseModal}
                >
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default BookingsTable;
