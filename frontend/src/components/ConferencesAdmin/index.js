import React, { useEffect, useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input";
import ImageUpload from "../../CoreComponent/ImageUpload";
import DateInput from "../../CoreComponent/Date";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import TextArea from "../../CoreComponent/TextArea";
import SVG from "react-inlinesvg";
import deleteIcon from "../../icons/deleteIcon.svg";
import { toast } from "react-toastify";

const CommitteeForm = ({ committeeMembers, setCommitteeMembers }) => {
  const addCommitteeMember = () => {
    setCommitteeMembers([
      ...committeeMembers,
      { id: Date.now(), name: "", image: null },
    ]);
  };

  const deleteCommitteeMember = (id) => {
    setCommitteeMembers(committeeMembers.filter((member) => member.id !== id));
  };

  const handleNameChange = (id, value) => {
    const updatedMembers = committeeMembers.map((member) =>
      member.id === id ? { ...member, name: value } : member
    );
    setCommitteeMembers(updatedMembers);
  };

  const handleImageChange = (id, file) => {
    const updatedMembers = committeeMembers.map((member) =>
      member.id === id ? { ...member, image: file } : member
    );
    setCommitteeMembers(updatedMembers);
  };

  return (
    <div className="committee-form-container">
      <div className="title-committee"> Committee Members</div>
      <div className="button-section-container">
        <button className="add-button-committee" onClick={addCommitteeMember}>
          Add Member
        </button>
      </div>

      {committeeMembers.map((member) => (
        <div key={member.id} className="committee-member">
          <div className="member-info">
            <Input
              type="text"
              label="Name"
              placeholder="Enter name"
              inputValue={member.name}
              setInputValue={(value) => handleNameChange(member.id, value)}
              className="name-input"
            />

            <ImageUpload
              label="Upload Image"
              inputValue={member.image}
              setInputValue={(file) => handleImageChange(member.id, file)}
              allowedExtensions={["jpg", "jpeg", "png"]}
            />
          </div>

          <button
            className="delete-button-committee"
            onClick={() => deleteCommitteeMember(member.id)}
          >
            Delete
          </button>
        </div>
      ))}
    </div>
  );
};

const PriceForm = ({ entries, setEntries }) => {
  const addEntry = () => {
    setEntries([
      ...entries,
      { id: Date.now(), price_type: "", price: "", description: "" },
    ]);
  };

  const deleteEntry = (id) => {
    setEntries(entries.filter((entry) => entry.id !== id));
  };

  const handleInputChange = (id, key, value) => {
    const updatedEntries = entries.map((entry) =>
      entry.id === id ? { ...entry, [key]: value } : entry
    );
    setEntries(updatedEntries);
  };
  return (
    <div className="price-form-container">
      <div className="price-header">Add Pricing Information</div>
      <div className="button-section-container">
        <button className="add-button-pricing" onClick={addEntry}>
          Add Entry
        </button>
      </div>
      {entries.map((entry) => (
        <div key={entry.id} className="entry-row">
          <Input
            label="Price Type"
            placeholder="Enter Price Type"
            inputValue={entry.price_type}
            setInputValue={(value) =>
              handleInputChange(entry.id, "price_type", value)
            }
            type="text"
          />

          <Input
            label="Price"
            placeholder="Enter Price"
            inputValue={entry.price}
            setInputValue={(value) =>
              handleInputChange(entry.id, "price", value)
            }
            type="number"
          />

          <Input
            label="Description"
            placeholder="Enter Description"
            inputValue={entry.description}
            setInputValue={(value) =>
              handleInputChange(entry.id, "description", value)
            }
            type="text"
          />

          <button
            className="delete-button-entry"
            onClick={() => deleteEntry(entry.id)}
          >
            Delete
          </button>
        </div>
      ))}{" "}
    </div>
  );
};

const ConferencesAdmin = ({ setIsOpen, getConference }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [committeeMembers, setCommitteeMembers] = useState([
    { id: Date.now(), name: "", image: null },
  ]);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [location, setLocation] = useState("");
  const [status, setStatus] = useState("upcoming");
  const [image, setImage] = useState(null);
  const [firstAnnouncement, setFirstAnnouncement] = useState(null);
  const [secondAnnouncement, setSecondAnnouncement] = useState(null);
  const [brochure, setBrochure] = useState(null);
  const [scientificProgram, setScientificProgram] = useState(null);
  const [visaCost, setVisaCost] = useState("");
  const [companionDinnerPrice, setCompanionDinnerPrice] = useState("");

  const [entries, setEntries] = useState([
    { id: Date.now(), price_type: "", price: "", description: "" },
  ]);
  const [topics, setTopics] = useState([""]);

  function convertPriceToObject(data) {
    let result = {};

    data.forEach((item, index) => {
      result[`prices[${index}][price_description]`] = item.description;
      result[`prices[${index}][price]`] = item.price;
      result[`prices[${index}][price_type]`] = item.price_type;
    });

    return result;
  }

  // Handler to update topics array
  const handleTopicChange = (index, newValue) => {
    const updatedTopics = [...topics];
    updatedTopics[index] = newValue;
    setTopics(updatedTopics);
  };

  // Add a new input for topic
  const handleAddTopic = () => {
    setTopics([...topics, ""]);
  };

  // Remove a topic input
  const handleRemoveTopic = (index) => {
    const updatedTopics = topics.filter((_, i) => i !== index);
    setTopics(updatedTopics);
  };

  async function addCommitteeMembers(mainId, members) {
    const BaseUrl = process.env.REACT_APP_BASE_URL;;

    const formData = new FormData();
    const token = localStorage.getItem("token");
    members.forEach((member, index) => {
      formData.append(`members[${index}][name]`, member.name);
      if (member.image) {
        formData.append(`members[${index}][committee_image]`, member.image);
      }
      formData.append(`members[${index}][conference_id]`, mainId);
    });

    try {
      const response = await axios.post(
        `${BaseUrl}/con/committee`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      setIsOpen(false);
      getConference();
    } catch (error) {
      console.error("Error:", error);
    }
  }

  const handleSubmit = (e) => {
    e.preventDefault();

    const prices = convertPriceToObject(entries);

    const formData = new FormData();

    for (const key in prices) {
      if (prices.hasOwnProperty(key)) {
        formData.append(key, prices[key]);
      }
    }

    formData.append("title", title);
    formData.append("description", description);
    formData.append("start_date", startDate);
    formData.append("end_date", endDate);
    formData.append("location", location);
    // formData.append("status", status.value);
    formData.append("image", image);
    formData.append("first_announcement_pdf", firstAnnouncement);
    formData.append("second_announcement_pdf", secondAnnouncement);
    formData.append("conference_brochure_pdf", brochure);
    formData.append("conference_scientific_program_pdf", scientificProgram);
    formData.append("visa_price", visaCost || 0);
    formData.append("companion_dinner_price", companionDinnerPrice || 0);

    formData.append("scientific_topics", topics);

    formData.append("timestamps", new Date().toISOString());
    const token = localStorage.getItem("token");
    axios
      .post(`${BaseUrl}/con`, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        const id = response.data.id;
        toast.success("Conference created successfully!");
        addCommitteeMembers(id, committeeMembers);
        setIsOpen(false);
        getConference();
      })
      .catch((error) => {
        console.error("Error submitting data: ", error);
      });
  };

  return (
    <div className="conference-form-admin">
      <div className="header-conference-form">Add New Conference</div>
      <div className="form-section">
        <Input
          label="Title"
          placeholder="Enter title"
          inputValue={title}
          setInputValue={setTitle}
          type="text"
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
        <DateInput
          label="Start Date"
          placeholder="YYYY-MM-DD"
          inputValue={startDate}
          setInputValue={setStartDate}
          required
        />
        <DateInput
          label="End Date"
          placeholder="YYYY-MM-DD"
          inputValue={endDate}
          setInputValue={setEndDate}
          required
        />
        <Input
          label="Location"
          placeholder="Enter location"
          inputValue={location}
          setInputValue={setLocation}
          type="text"
          required
        />
        {/* <Select
          options={[
            { value: "upcoming", label: "Upcoming" },
            { value: "past", label: "Past" },
          ]}
          value={status}
          setValue={setStatus}
          label="Status"
          errorMsg={""}
        /> */}

        <ImageUpload
          label="Upload Image"
          inputValue={image}
          setInputValue={setImage}
          allowedExtensions={["jpg", "jpeg", "png"]}
        />

        <ImageUpload
          label="First Announcement PDF"
          inputValue={firstAnnouncement}
          setInputValue={setFirstAnnouncement}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Second Announcement PDF"
          inputValue={secondAnnouncement}
          setInputValue={setSecondAnnouncement}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Conference Brochure PDF"
          inputValue={brochure}
          setInputValue={setBrochure}
          allowedExtensions={["pdf"]}
        />

        <ImageUpload
          label="Conference Scientific Program PDF"
          inputValue={scientificProgram}
          setInputValue={setScientificProgram}
          allowedExtensions={["pdf"]}
        />
        <Input
          label="Visa Cost (USD)"
          placeholder="Enter visa cost"
          inputValue={visaCost}
          setInputValue={setVisaCost}
          type="number" 
          required
        />
             <Input
          label="Companion Dinner Cost (USD)"
          placeholder="Enter companion Dinner Price Cost"
          inputValue={companionDinnerPrice}
          setInputValue={setCompanionDinnerPrice}
          type="number" 
          required
        />
        <div className="topics-container">
          <div className="topic-title">
            Topics
            <span className="star">*</span>
          </div>
          <div className="topics-container-inputs">
            {topics.map((topic, index) => (
              <div key={index} className="topic-input-container">
                <Input
                  placeholder="Enter a topic"
                  inputValue={topic}
                  setInputValue={(newValue) =>
                    handleTopicChange(index, newValue)
                  }
                />
                <SVG
                  className="delete-icon"
                  src={deleteIcon}
                  onClick={() => handleRemoveTopic(index)}
                />
              </div>
            ))}
            <div className="add-topic-btn-container">
              <button
                type="button"
                onClick={handleAddTopic}
                className="add-topic-btn"
              >
                Add Topic
              </button>
            </div>
          </div>
        </div>

        <PriceForm entries={entries} setEntries={setEntries} />
        <CommitteeForm
          committeeMembers={committeeMembers}
          setCommitteeMembers={setCommitteeMembers}
        />
      </div>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setIsOpen(false);
            getConference();
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </div>
  );
};

export default ConferencesAdmin;
