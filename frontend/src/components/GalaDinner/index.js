import React, { useEffect, useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input";
import Checkbox from "../../CoreComponent/Checkbox";
import "./style.scss"; // Import the Sass file
import { useAuth } from "../../common/AuthContext";
import { toast } from "react-toastify";
import httpService from "../../common/httpService";
import { useNavigate } from "react-router-dom";
import SimpleLabelValue from "../SimpleLabelValue";
const DinnerDetails = () => {
  const [dinnerDetail, setDinnerDetail] = useState(null);
  const [loading, setLoading] = useState(true);
  const [attending, setAttending] = useState(false); // State for attending
  const [hasGuest, setHasGuest] = useState(false); // State for having a guest
  const [guestName, setGuestName] = useState(""); // State for guest name
  const [companionDinnerPrice, setCompanionDinnerPrice] = useState(""); // State for guest price
  const [dinnerInvoice, setDinnerInvoice] = useState(null); // State for dinnerInvoice
  const [invoice, setInvoice] = useState(null); // State for invoice
  const navigate = useNavigate();
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getDinnerInvoice = () => {
    const token = localStorage.getItem("token");
    axios
      .get(`${BaseUrl}/dinner/invoice`, {
        headers: {
          Authorization: `Bearer ${token}`, // تمرير التوكن في الهيدر
        },
      })
      .then((response) => {
        // تخزين البيانات في state
        setDinnerInvoice(response.data.dinner_attendee);
        setInvoice(response.data.invoice);
      })
      .catch((error) => {
        console.error("Error fetching invoice data", error);
        // إذا لم يتم العثور على البيانات، لا نقوم بإظهار رسالة خطأ
      });
  };

  useEffect(() => {
    getDinnerInvoice();
  }, []);

  const { myConferenceId } = useAuth();

  const fetchDinnerDetails = async () => {
    if (!myConferenceId) {
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
      console.error("Error fetching dinner details", error);
    } finally {
      setLoading(false); // Set loading to false regardless of success or failure
    }
  };

  useEffect(() => {
    fetchDinnerDetails();
  }, [myConferenceId]);

  const fetchConferenceDetails = async () => {
    if (!myConferenceId) {
      return;
    }
    const token = localStorage.getItem("token");
    try {
      const response = await axios.get(`${BaseUrl}/con/id/${myConferenceId}`);
      setCompanionDinnerPrice(
        response?.data?.conference.companion_dinner_price
      );
    } catch (error) {
      console.error("Error fetching Conference details", error);
    }
  };

  useEffect(() => {
    fetchConferenceDetails();
  }, [myConferenceId]);

  const addDinnerAttendees = async () => {
    const token = localStorage.getItem("token");

    // إعداد البيانات التي سيتم إرسالها
    const data = {
      companion_name: guestName,
      companion_price: companionDinnerPrice,
      conference_id: myConferenceId,
    };

    try {
      const response = await axios.post(`${BaseUrl}/dinner/attendees`, data, {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });
      setTimeout(() => {
        getDinnerInvoice();
      }, [200]);

      toast.success("Attendance confirmed successfully!");
    } catch (error) {
      console.error(
        "Error:",
        error.response ? error.response.data : error.message
      );
      alert("An error occurred while confirming attendance. Please try again.");
    }
  };

  const handleGuestChange = (event) => {
    setHasGuest(event.target.checked); // Toggle guest state
  };

  if (loading) return <p>Loading...</p>;

  return (
    <div className="dinner-details3">
      <div className="dinner-details-container">
        <h2 className="dinner-title">Gala Dinner Details</h2>
        {dinnerDetail ? (
          <>
            <div className="dinner-detail-section">
              <SimpleLabelValue
                label="Date"
                value={new Date(dinnerDetail.dinner_date).toLocaleDateString()}
              />
              <SimpleLabelValue
                label="Restaurant"
                value={dinnerDetail.restaurant_name}
              />
              <SimpleLabelValue
                label="Location"
                value={dinnerDetail.location}
              />
              <SimpleLabelValue
                label="Gathering Place"
                value={dinnerDetail.gathering_place}
              />
              <SimpleLabelValue
                label="Transportation"
                value={dinnerDetail.transportation_method}
              />
              <SimpleLabelValue
                label="Gathering Time"
                value={dinnerDetail.gathering_time}
              />
              <SimpleLabelValue
                label="Dinner Time"
                value={dinnerDetail.dinner_time}
              />
              <SimpleLabelValue
                label="Duration"
                value={`${dinnerDetail.duration} minutes`}
              />
              <SimpleLabelValue
                label="Dress Code"
                value={dinnerDetail.dress_code}
              />
            </div>

            {!dinnerInvoice && !invoice ? (
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
                    <p>
                      All information related to the dinner will be confirmed
                      through a message sent by the organizing company to your
                      WhatsApp.
                    </p>
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
                        <SimpleLabelValue
                          label="Companion Dinner Price"
                          value={`${companionDinnerPrice} $`}
                        />
                      </div>
                    )}
                    <button className="submit-btn" onClick={addDinnerAttendees}>
                      Confirm Attendance
                    </button>
                  </div>
                )}
              </div>
            ) : (
              <div className="invoice-section">
                <h3>Invoice Details</h3>
                {dinnerInvoice && (
                  <SimpleLabelValue
                    label="Companion Name"
                    value={dinnerInvoice.companion_name || "-"}
                  />
                )}
                {dinnerInvoice && (
                  <SimpleLabelValue
                    label="Companion Price"
                    value={`${dinnerInvoice.companion_price  || 0} $`}
                  />
                )}
                {invoice && (
                  <SimpleLabelValue
                    label="Invoice Status"
                    value={invoice.status}
                  />
                )}
                <button className="pay-now-btn">Pay Now</button>
              </div>
            )}
          </>
        ) : (
          <p>No dinner details available.</p>
        )}
      </div>
      <button
        className="fixed-button"
        onClick={() => {
          navigate("/airport/transfer");
        }}
      >
        Next
      </button>
    </div>
  );
};

export default DinnerDetails;
