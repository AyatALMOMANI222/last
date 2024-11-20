import React, { useState,useEffect } from "react";
import axios from "axios";
import "./style.scss"
import Select from "../../CoreComponent/Select";
import { toast } from "react-toastify";

const BoothCostForm = () => {
  const [conferenceId, setConferenceId] = useState("");
  const [size, setSize] = useState("");
  const [cost, setCost] = useState("");
  const [lunchInvitations, setLunchInvitations] = useState("");
  const [nameTags, setNameTags] = useState("");
  const [message, setMessage] = useState("");
  const [allConference, setAllConference] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const token =localStorage.getItem("token")

  // Get upcoming conferences
  const getConference = () => {
    const url = `${BaseUrl}/con/upcoming`;
const token =localStorage.getItem("token")
    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAllConference(
          response.data.upcoming_conferences?.map((item) => ({
            label: item?.title,
            value: item?.id,
          }))
        );
      })
      .catch((error) => {
        toast.error("Error fetching conferences");
        // setError("An error occurred while fetching conferences");
      });
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setMessage("");

    const data = {
      conference_id: conferenceId.value,
      size,
      cost,
      lunch_invitations: lunchInvitations,
      name_tags: nameTags,
    };

    try {
      const response = await axios.post(
        `${BaseUrl}/size/table/admin`,
        data,{
            headers: {
              Authorization: `Bearer ${token}`,
            },
          }
      );
      setMessage(response.data.message);
    } catch (error) {
      if (error.response) {
        setMessage(
          error.response.data.error || "An error occurred. Please try again."
        );
      } else {
        setMessage("Unable to connect to the server.");
      }
    }
  };

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h2>Add Booth Cost</h2>
      {message && (
        <p style={{ color: message.includes("successfully") ? "green" : "red" }}>
          {message}
        </p>
      )}
      <form onSubmit={handleSubmit} style={{ maxWidth: "400px" }}>
      <Select
        options={allConference}
        value={conferenceId}
        setValue={setConferenceId}
        label="Conference "
        placeholder="Select..."
        
      />
        <div style={{ marginBottom: "10px" }}>
          <label>Size:</label>
          <input
            type="text"
            value={size}
            onChange={(e) => setSize(e.target.value)}
            required
            style={inputStyle}
          />
        </div>
        <div style={{ marginBottom: "10px" }}>
          <label>Cost:</label>
          <input
            type="number"
            step="0.01"
            value={cost}
            onChange={(e) => setCost(e.target.value)}
            required
            style={inputStyle}
          />
        </div>
        <div style={{ marginBottom: "10px" }}>
          <label>Lunch Invitations:</label>
          <input
            type="number"
            value={lunchInvitations}
            onChange={(e) => setLunchInvitations(e.target.value)}
            required
            style={inputStyle}
          />
        </div>
        <div style={{ marginBottom: "10px" }}>
          <label>Name Tags:</label>
          <input
            type="number"
            value={nameTags}
            onChange={(e) => setNameTags(e.target.value)}
            required
            style={inputStyle}
          />
        </div>
        <button
          type="submit"
          style={{
            padding: "10px 20px",
            backgroundColor: "#B22222",
            color: "white",
            border: "none",
            borderRadius: "5px",
            cursor: "pointer",
          }}
        >
          Submit
        </button>
      </form>
    </div>
  );
};

const inputStyle = {
  width: "100%",
  padding: "8px",
  margin: "5px 0",
  border: "1px solid #ccc",
  borderRadius: "4px",
};

export default BoothCostForm;
