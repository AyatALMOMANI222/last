import React, { useState, useEffect } from "react";
import axios from "axios";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import { toast } from "react-toastify";
import Input from "../../CoreComponent/Input"; // Assuming you have this custom Input component

const BoothCostForm = () => {
  const [conferenceId, setConferenceId] = useState("");
  const [size, setSize] = useState("");
  const [cost, setCost] = useState("");
  const [lunchInvitations, setLunchInvitations] = useState("");
  const [nameTags, setNameTags] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState({
    size: "",
    cost: "",
    lunchInvitations: "",
    nameTags: "",
  });
  const [allConference, setAllConference] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const token = localStorage.getItem("token");

  // Get upcoming conferences
  const getConference = () => {
    const url = `${BaseUrl}/conferences/all`;
    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAllConference(
          response.data.data?.map((item) => ({
            label: item?.title,
            value: item?.id,
          }))
        );
      })
      .catch((error) => {
        toast.error("Error fetching conferences");
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
      const response = await axios.post(`${BaseUrl}/size/table/admin`, data, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      toast.success(response.data.message);

      // Reset form data after successful submission
      setConferenceId("");
      setSize("");
      setCost("");
      setLunchInvitations("");
      setNameTags("");
    } catch (error) {
      toast.error("An error occurred. Please try again.");
    }
  };

  return (
    <div className="booth-cost-form">
      <h2>Add Booth Cost</h2>

      <form onSubmit={handleSubmit} className="form-container">
        <Select
          options={allConference}
          value={conferenceId}
          setValue={setConferenceId}
          label="Conference"
          placeholder="Select..."
        />
        <Input
          className="input-field"
          label="Size"
          placeholder="Enter Booth Size"
          inputValue={size}
          setInputValue={setSize}
          required={true}
          errorMsg={error.size}
        />
        <Input
          className="input-field"
          label="Cost"
          type="number"
          step="0.01"
          placeholder="Enter Booth Cost"
          inputValue={cost}
          setInputValue={setCost}
          required={true}
          errorMsg={error.cost}
        />
        <Input
          className="input-field"
          label="Lunch Invitations"
          type="number"
          placeholder="Enter Number of Lunch Invitations"
          inputValue={lunchInvitations}
          setInputValue={setLunchInvitations}
          required={true}
          errorMsg={error.lunchInvitations}
        />
        <Input
          className="input-field"
          label="Name Tags"
          type="number"
          placeholder="Enter Number of Name Tags"
          inputValue={nameTags}
          setInputValue={setNameTags}
          required={true}
          errorMsg={error.nameTags}
        />
        <button type="submit" className="submit-button">
          Submit
        </button>
      </form>
    </div>
  );
};

export default BoothCostForm;
