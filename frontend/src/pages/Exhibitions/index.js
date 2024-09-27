import React, { Fragment, useEffect, useState } from "react";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import Input from "../../CoreComponent/Input";
import { backendUrlImages } from "../../constant/config";
import ImageUpload from "../../CoreComponent/ImageUpload";
import DateInput from "../../CoreComponent/Date";
import axios from "axios";
import "./style.scss";

const ExhibitionForm = ({ setIsOpen, getExhibitions }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [location, setLocation] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [status, setStatus] = useState("upcoming");
  const [exhibitionImages, setExhibitionImages] = useState(null);
  const [errorMsg, setErrorMsg] = useState(""); // Manage error messages

  const handleSubmit = async (e) => {
    e.preventDefault(); // Prevent the default form submission
    const token = localStorage.getItem("token");

    const formData = new FormData();
    formData.append("title", title);
    formData.append("description", description);
    formData.append("location", location);
    formData.append("start_date", startDate);
    formData.append("end_date", endDate);
    formData.append("status", status);
    formData.append("image", exhibitionImages);

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/exhibitions",
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
      <div className="header-exhibition-form">Add New Conference</div>
      <div className="form-section">
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
        <Input
          label="Status"
          inputValue={status}
          setInputValue={setStatus}
          required={true}
          errorMsg={errorMsg}
          options={["upcoming", "past"]} // Assuming you want a dropdown or similar
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
        <button className="cancel-btn" onClick={() => {}}>
          Cancel
        </button>
        <button className="submit-btn" type="submit">
          Submit
        </button>
      </div>
    </form>
  );
};

const Exhibitions = () => {
  const [selectedExhibitionId, setSelectedExhibitionId] = useState(null);
  const [isViewDrawerOpen, setIsViewDrawerOpen] = useState(false);
  const [isEditDrawerOpen, setIsEditDrawerOpen] = useState(false);
  const [exhibitionData, setExhibitionData] = useState();
  const [exhibitionName, setExhibitionName] = useState("");
  const [openAddExhibition, setOpenAddExhibition] = useState(false);
  const [allExhibitions, setAllExhibitions] = useState([]);
  const [selectedExhibition, setSelectedExhibition] = useState({});

  const handleViewClick = (exhibition) => {
    setSelectedExhibition(exhibition);
    setIsViewDrawerOpen(true);
  };

  const handleEditClick = (exhibitionId) => {
    setSelectedExhibitionId(exhibitionId);
    setIsEditDrawerOpen(true);
    setExhibitionData();
  };

  const getExhibitions = () => {
    const searchQuery = exhibitionName
      ? `?search=${encodeURIComponent(exhibitionName)}`
      : "";
    const url = `http://127.0.0.1:8000/api/exhibitions/all`;

    axios
      .get(url)
      .then((response) => {
        console.log({ response });

        console.log("Exhibitions retrieved successfully:", response.data);
        setAllExhibitions(response.data);
      })
      .catch((error) => {
        console.error("Error retrieving exhibitions:", error);
      });
  };

  useEffect(() => {
    getExhibitions();
  }, [exhibitionName]);

  useEffect(() => {
    console.log({ selectedExhibition });
  }, [selectedExhibition]);

  return (
    <div className="exhibitions-page">
      <div className="exhibitions-form-admin-header">
        <div className="header-input">
          <Input
            placeholder="Search"
            inputValue={exhibitionName}
            setInputValue={setExhibitionName}
            type="text"
          />
        </div>
        <button
          className="add-exhibitions-btn"
          onClick={() => setOpenAddExhibition(true)}
        >
          Add new Exhibitions
        </button>
      </div>
      <div className="exhibition-list">
        {allExhibitions?.map((exhibition) => {
          return (
            <Fragment key={exhibition.id}>
              <div className="exhibition-item">
                <img
                  className="exhibition-image"
                  src={`${backendUrlImages}${exhibition.image}`}
                  alt={exhibition.title}
                />

                <div className="exhibition-info">
                  <div className="title">{exhibition.title}</div>
                  <div className="date">{exhibition.date}</div>
                  <div className="place">{exhibition.place}</div>
                  <div className="actions-btns">
                    <button
                      className="view"
                      onClick={() => {
                        handleViewClick(exhibition);
                      }}
                    >
                      View
                    </button>
                    <button
                      className="edit"
                      onClick={() => handleEditClick(exhibition.id)}
                    >
                      Edit
                    </button>
                  </div>
                </div>
              </div>
            </Fragment>
          );
        })}
      </div>
      <MySideDrawer isOpen={openAddExhibition} setIsOpen={setOpenAddExhibition}>
        <ExhibitionForm
          setIsOpen={setOpenAddExhibition}
          getExhibitions={getExhibitions}
        />
      </MySideDrawer>
    </div>
  );
};

export default Exhibitions;
