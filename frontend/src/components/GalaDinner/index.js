import React, { useEffect, useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox";
import "./style.scss"; // Import the Sass file
import { useAuth } from "../../common/AuthContext";
import { toast } from "react-toastify";

const DinnerDetails = () => {
  const [dinnerDetail, setDinnerDetail] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [attending, setAttending] = useState(false); // State for attending
  const [hasGuest, setHasGuest] = useState(false); // State for having a guest
  const [guestName, setGuestName] = useState(""); // State for guest name
  const [companionDinnerPrice, setCompanionDinnerPrice] = useState(""); // State for guest price
  const BaseUrl = process.env.REACT_APP_BASE_URL;;


  const {myConferenceId} = useAuth();


    const fetchDinnerDetails = async () => {
      if(!myConferenceId){
        return;
      }
      const token = localStorage.getItem("token");
      try {
        const response = await axios.get(
          `${BaseUrl}/dinners/conference/${myConferenceId}`,
          {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
        );
        setDinnerDetail(response?.data?.dinner_detail);
      } catch (error) {
        setError("Error fetching dinner details");
      } finally {
        setLoading(false); // Set loading to false regardless of success or failure
      }
    };
    useEffect(() => {
    fetchDinnerDetails();
  }, [myConferenceId]);

  const fetchConferenceDetails = async () => {
    const token = localStorage.getItem("token");
    try {
      const response = await axios.get(
        `${BaseUrl}/con/id/${myConferenceId}`
      );
      setCompanionDinnerPrice(response?.data?.conference.companion_dinner_price);
    } catch (error) {
      setError("Error fetching Conference details");
    }
  };


  const addDinnerAttendees = async () => {
    const token = localStorage.getItem("token");
  
    // إعداد البيانات التي سيتم إرسالها
    const data = {
      companion_name: guestName,
      companion_price: companionDinnerPrice,
      conference_id:myConferenceId
    };
  
    try {
      const response = await axios.post(
        `${BaseUrl}/dinner/attendees`,
        data,
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        }
      );
  
      console.log("Response:", response.data);
      // alert("Attendance confirmed successfully!");
      toast.success("Attendance confirmed successfully!");
  
    } catch (error) {
      console.error("Error:", error.response ? error.response.data : error.message);
      alert("An error occurred while confirming attendance. Please try again.");
    }
  };
  
  
  useEffect(() => {
    fetchConferenceDetails();
  }, [myConferenceId]);

  const handleGuestChange = (event) => {
    setHasGuest(event.target.checked); // Toggle guest state
  };

  const handleSubmit = () => {
    // Handle form submission logic here
    alert(
      `Attendance confirmed for ${attending ? "yourself" : "no one"}${
        hasGuest ? ` with guest: ${guestName}` : ""
      }`
    );
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div className="dinner-details-container">
      <h2 className="dinner-title">Gala Dinner Details</h2>
      {dinnerDetail ? ( // Check if dinnerDetail is not null
        <>
          <div className="dinner-detail-item">
            <strong>Date:</strong>{" "}
            <span>{new Date(dinnerDetail.dinner_date).toLocaleDateString()}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Restaurant:</strong> <span>{dinnerDetail.restaurant_name}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Location:</strong> <span>{dinnerDetail.location}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Gathering Place:</strong>{" "}
            <span>{dinnerDetail.gathering_place}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Transportation:</strong>{" "}
            <span>{dinnerDetail.transportation_method}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Gathering Time:</strong>{" "}
            <span>{dinnerDetail.gathering_time}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Dinner Time:</strong> <span>{dinnerDetail.dinner_time}</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Duration:</strong> <span>{dinnerDetail.duration} minutes</span>
          </div>
          <div className="dinner-detail-item">
            <strong>Dress Code:</strong> <span>{dinnerDetail.dress_code}</span>
          </div>

          {/* Attendance Confirmation Section */}
          <div className="attendance-section">
            <h3>Attendance Confirmation</h3>

            <Checkbox
              label="Will you be attending?"
              checkboxValue={attending}
              setCheckboxValue={setAttending}
              className="form-checkbox"
            />
            {attending && (
              <div>
                <p>All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.</p>
                <Checkbox
                  label="Do you have a guest?"
                  checkboxValue={hasGuest}
                  setCheckboxValue={setHasGuest}
                  className="form-checkbox"
                />
                {hasGuest && (
                  <div>
                    <Input
                      type="text"
                      placeholder="Enter guest name"
                      inputValue={guestName}
                      setInputValue={setGuestName}
                    />
                    <div className="price">Companion Dinner Price: {companionDinnerPrice} $</div>
                  </div>
                )}
                <button className="submit-btn" onClick={addDinnerAttendees}>Confirm Attendance</button>
              </div>
            )}
          </div>
        </>
      ) : (
        <p>No dinner details available.</p>
      )}
    </div>
  );
};

export default DinnerDetails;
