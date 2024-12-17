import React, { useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import DateInput from "../../../CoreComponent/Date";
import axios from "axios";
import Select from "../../../CoreComponent/Select";
import "./style.scss";

// this form for create ExhibitionForm
const EditExhibitionForm = ({ setIsOpen, getExhibitions, exhibitionData }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [location, setLocation] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [status, setStatus] = useState("upcoming");
  const [exhibitionImages, setExhibitionImages] = useState(null);
  const [errorMsg, setErrorMsg] = useState(""); // Manage error messages
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const statusOptions = [
    {
      label: "upcoming",
      value: "upcoming",
    },
    {
      label: "past",
      value: "past",
    },
  ];
  const getConference = () => {
    const url = `${BaseUrl}/conferences/all`;
    axios
      .get(url)
      .then((response) => {
        setAllConference(
          response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          })
        );
      })
      .catch((error) => {});
  };

  const setExhibitionsData = () => {
    setConferenceId(
      allConference?.find((item) => {
        return item?.value == exhibitionData?.conference_id;
      }) || null
    );
    setTitle(exhibitionData.title || "");
    setDescription(exhibitionData.description || "");
    setLocation(exhibitionData.location || "");
    setStartDate(
      exhibitionData?.start_date
        ? exhibitionData?.start_date?.split("T")[0]
        : ""
    );
    setEndDate(
      exhibitionData.end_date ? exhibitionData?.end_date?.split("T")[0] : ""
    );
    console.log(exhibitionData.status);

    setStatus(
      statusOptions?.find((item) => {
        return item?.value == exhibitionData?.status;
      }) || null
    );
    setExhibitionImages(exhibitionData.image || null);
  };

  useEffect(() => {
    setExhibitionsData();
  }, [exhibitionData, allConference]);

  useEffect(() => {
    getConference();
  }, []);
  // console.log();

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent the default form submission
    const token = localStorage.getItem("token");

    const formData = new FormData();
    formData.append("conference_id", conferenceId?.value);
    formData.append("title", title);
    formData.append("description", description);
    formData.append("location", location);
    formData.append("start_date", startDate);
    formData.append("end_date", endDate);
    formData.append("status", status.value);
    formData.append("image", exhibitionImages);

    try {
      //ayat edit this for edit exhibitions not create
      const response = await axios.post(
        `${BaseUrl}/exhibitions/update/${exhibitionData.id}`,
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setIsOpen(false);
      setTitle("");
      setDescription("");
      setLocation("");
      setStartDate("");
      setEndDate("");
      setStatus("upcoming");
      setExhibitionImages(null);
    } catch (error) {
      if (error.response) {
      } else {
        setErrorMsg("An error occurred. Please try again.");
      }
    }
  };

  return (
    <form className="exhibition-form-container" onSubmit={handleSubmit}>
      <div className="header-exhibition-form">Edit Exhibition</div>
      <div className="form-section">
        <Select
          options={allConference}
          value={conferenceId}
          setValue={setConferenceId}
          label="Conference Id"
          errorMsg={""}
        />

        <Input
          label="Exhibition Title"
          inputValue={title}
          setInputValue={setTitle}
          required={true}
          errorMsg={errorMsg}
        />
        <Input
          label="Description"
          inputValue={description}
          setInputValue={setDescription}
          required={false}
          errorMsg={errorMsg}
        />
        <Input
          label="Exhibition Location"
          inputValue={location}
          setInputValue={setLocation}
          required={true}
          errorMsg={errorMsg}
        />
        <DateInput
          label="Start Date"
          inputValue={startDate}
          setInputValue={setStartDate}
          type="date"
          required={true}
          errorMsg={errorMsg}
        />
        <DateInput
          label="End Date"
          inputValue={endDate}
          setInputValue={setEndDate}
          type="date"
          required={false}
          errorMsg={errorMsg}
        />

        <Select
          options={statusOptions}
          value={status}
          setValue={setStatus}
          label="Status"
          errorMsg={""}
        />
        <ImageUpload
          label="Exhibition Images"
          inputValue={exhibitionImages}
          setInputValue={setExhibitionImages}
          allowedExtensions={["jpg", "jpeg", "png"]}
          errorMsg={errorMsg}
        />
      </div>

      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setIsOpen(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" type="submit" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </form>
  );
};

export default EditExhibitionForm;
