import React, { useEffect, useState } from "react";
import "./style.scss"; // تأكد من إضافة SCSS هنا
import axios from "axios";
import { toast } from "react-toastify";
import PropTypes from "prop-types";
import MySideDrawer from "../../../CoreComponent/SideDrawer";
import { useParams } from "react-router-dom";
const SpeakerTable = () => {
  const [speakers, setSpeakers] = useState([]);
  const [selectedSpeaker, setSelectedSpeaker] = useState({});
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [loading, setLoading] = useState(true);
  const token = localStorage.getItem("token");
const {conferenceId} =useParams()
  useEffect(() => {
    const fetchSpeakers = async () => {
      try {
        const response = await axios.get(`http://127.0.0.1:8000/api/dinner/attendees/${conferenceId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setSpeakers(response.data.data); // استخدام البيانات مباشرة
        console.log(response.data.data);
        
      } catch (error) {
        toast.error("Error fetching speakers data");
      } finally {
        setLoading(false);
      }
    };

    fetchSpeakers();
  }, [token]);

  const openModal = (speaker) => {
    setSelectedSpeaker(speaker);
    console.log(speaker); // تحقق من البيانات هنا

    setModalIsOpen(true);
  };

  const closeModal = () => {
    setSelectedSpeaker(null);
    setModalIsOpen(false);
  };

  return (
    <div className="speaker-table">
      <h2>Dinner Speakers List</h2>
      {loading ? (
        <div>Loading...</div>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Companion Name</th>
              {/* <th>Created At</th> */}
              <th>Companion Price</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {speakers.map((speakerData) => (
              <tr key={speakerData.id}>
                <td>{speakerData.companion_name || "N/A"}</td>
                {/* <td>{new Date(speakerData.created_at).toLocaleString()}</td> */}
                <td>{speakerData.companion_price || "N/A"}</td>
                <td>
                  <button onClick={() => openModal(speakerData.speaker)} className="view-button">
                    View
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      <MySideDrawer isOpen={modalIsOpen} setIsOpen={closeModal}>
        {selectedSpeaker && (
          <div className="modal-content">
            <h2>Speaker Details</h2>
            {/* <p><strong>ID:</strong> {selectedSpeaker.id}</p>
            <p><strong>User ID:</strong> {selectedSpeaker.user_id}</p>
            <p><strong>Conference ID:</strong> {selectedSpeaker.conference_id}</p> */}
            <p><strong>Abstract:</strong> {selectedSpeaker.abstract || "N/A"}</p>
            <p><strong>Topics:</strong> {selectedSpeaker.topics || "N/A"}</p>
            <p><strong>Online Participation:</strong> {selectedSpeaker.online_participation ? "Yes" : "No"}</p>
            <p><strong>Is Online Approved:</strong> {selectedSpeaker.is_online_approved ? "Yes" : "No"}</p>
            <p><strong>Accommodation Status:</strong> {selectedSpeaker.accommodation_status ? "Yes" : "No"}</p>
            <p><strong>Ticket Status:</strong> {selectedSpeaker.ticket_status ? "Active" : "Inactive"}</p>
            <p><strong>Dinner Invitation:</strong> {selectedSpeaker.dinner_invitation ? "Yes" : "No"}</p>
            <p><strong>Airport Pickup:</strong> {selectedSpeaker.airport_pickup ? "Yes" : "No"}</p>
            <p><strong>Free Trip:</strong> {selectedSpeaker.free_trip ? "Yes" : "No"}</p>
           
            <button onClick={closeModal}>Close</button>
          </div>
        )}
      </MySideDrawer>
    </div>
  );
};

SpeakerTable.propTypes = {
  speakers: PropTypes.array,
};

export default SpeakerTable;
