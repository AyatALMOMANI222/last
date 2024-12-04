import React, { useState, useEffect } from "react";
import axios from "axios";
import Select from "../../../CoreComponent/Select";

import "./style.scss";
import { toast } from "react-toastify";
import Input from "../../../CoreComponent/Input";
import TextArea from "../../../CoreComponent/TextArea";

const SponsorshipForm = () => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [price, setPrice] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState("");
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
        setError("An error occurred while fetching conferences");
      });
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!conferenceId) {
      toast.error("Please select a conference");
      return;
    }
    setLoading(true);
    setError(null);
  
    try {
      const response = await axios.post(
        `${BaseUrl}/sponsorship-options/${conferenceId.value}`,
        {
          title,
          description,
          price,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
  
      toast.success("Sponsorship option created successfully");
  
      // Reset fields after successful submission
      setTitle("");
      setDescription("");
      setPrice("");
      setConferenceId(""); // Reset selected conference
  
      setLoading(false);
    } catch (error) {
      setLoading(false);
      setError("An error occurred while submitting the data");
      toast.error("Error submitting data");
    }
  };
  

  return (
    <div className="sponsorship-form-container">
      <h2 className="add-new-Sponsorship">Add a New Sponsorship Option</h2>

      <form onSubmit={handleSubmit} className="sponsorship-form">
        <div className="sponsorship-sec">
          <Select
            options={allConference}
            value={conferenceId}
            setValue={setConferenceId}
            label="Conference "
            placeholder="Select..."
          />
          <Input
            label="Title"
            placeholder="Enter title"
            inputValue={title}
            setInputValue={setTitle}
            required
          />

          <TextArea
            label="Description"
            placeholder="Enter description"
            value={description}
            setValue={setDescription}
            type="text"
            required
          />
          <Input
            label="Price"
            inputValue={price}
            setInputValue={setPrice}
            placeholder="Enter price"
            required
          />
        </div>
        <button type="submit" disabled={loading} className="submit-btn">
          {loading ? "Submitting..." : "Submit"}
        </button>
      </form>
    </div>
  );
};

export default SponsorshipForm;
