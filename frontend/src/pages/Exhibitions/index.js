import React, { Fragment, useEffect, useState } from "react";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import Input from "../../CoreComponent/Input";
import { backendUrlImages } from "../../constant/config";
import ImageUpload from "../../CoreComponent/ImageUpload";
import DateInput from "../../CoreComponent/Date";
import axios from "axios";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import Pagination from "../../CoreComponent/Pagination";
import ViewFormExhibitions from "./ViewForm";
import EditExhibitionForm from "./EditForm";
import httpService from "../../common/httpService";
// this form for create ExhibitionForm
const ExhibitionForm = ({ setIsOpen, getExhibitions }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [location, setLocation] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [status, setStatus] = useState([]);
  const [exhibitionImages, setExhibitionImages] = useState(null);
  const [errorMsg, setErrorMsg] = useState(""); // Manage error messages
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getConference = () => {
    const url = `${BaseUrl}/con`;

    axios
      .get(url)
      .then((response) => {
        setAllConference(
          response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          })
        );
        console.log(
          response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          })
        );
      })
      .catch((error) => {});
  };
  useEffect(() => {
    getConference();
  }, []);
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
    formData.append("status", status);
    formData.append("image", exhibitionImages);

    try {
      const response = await axios.post(`${BaseUrl}/exhibitions`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${token}`,
        },
      });
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
      <div className="header-exhibition-form">Add New Exhibition</div>
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
          placeholder="Enter Exhibition Title"
        />

        <Input
          label="Description"
          inputValue={description}
          setInputValue={setDescription}
          required={false}
          errorMsg={errorMsg}
          placeholder="Enter a brief description"
        />

        <Input
          label="Exhibition Location"
          inputValue={location}
          setInputValue={setLocation}
          required={true}
          errorMsg={errorMsg}
          placeholder="Enter Exhibition Location"
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
          label="Status"
          value={status}
          setValue={setStatus}
          required={true}
          placeholder="Select"
          errorMsg={errorMsg}
          options={[
            { label: "upcoming", value: "upcoming" },
            { label: "past", value: "past" },
          ]}
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
        <button className="submit-btn" type="submit">
          Submit
        </button>
      </div>
    </form>
  );
};

const Exhibitions = () => {
  const [isEditDrawerOpen, setIsEditDrawerOpen] = useState(false);
  const [exhibitionData, setExhibitionData] = useState({});
  const [exhibitionName, setExhibitionName] = useState("");
  const [openAddExhibition, setOpenAddExhibition] = useState(false);
  const [allExhibitions, setAllExhibitions] = useState([]);
  const [status, setStatus] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const [openViewForm, setOpenViewForm] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  const handleEditClick = (exhibition) => {
    setIsEditDrawerOpen(true);
    setExhibitionData(exhibition);
  };

  const getExhibitions2 = async () => {
    try {
      const response = await axios.get(`${BaseUrl}/exhibitions`, {
        params: {
          search: exhibitionName,
          status: status?.value,
          page: currentPage,
        },
      });
      setTotalPages(response.data.total_pages);
      setAllExhibitions(response.data.data); // Adjust according to your API response structure
    } catch (err) {
      console.error("Error fetching exhibitions:", err);
    }
  };
  const getExhibitions = async () => {
    try {
      await httpService({
        method: "GET",
        url: `${BaseUrl}/exhibitions`,
        params: {
          search: exhibitionName,
          status: status?.value,
          page: currentPage,
        },
        onSuccess: (data) => {
          setTotalPages(data.total_pages);
          setAllExhibitions(data.data); // Adjust according to your API response structure
        },
        onError: (error) => {
          console.error("Error fetching exhibitions:", error);
        },
        showLoader: true,
        withToast: true,
      });
    } catch (err) {
      console.error("Error in getExhibitions:", err);
    }
  };

  useEffect(() => {
    getExhibitions();
  }, [exhibitionName, status, currentPage]);

  return (
    <div className="exhibitions-page">
      <div className="exhibitions-form-admin-header">
        <div className="section-input">
          <Input
            placeholder="Search"
            inputValue={exhibitionName}
            setInputValue={setExhibitionName}
            type="text"
            label={"Exhibition Name"}
          />
          <Select
            options={[
              { value: "upcoming", label: "Upcoming" },
              { value: "past", label: "Past" },
            ]}
            value={status}
            setValue={setStatus}
            label="Status"
            errorMsg={""}
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
        {allExhibitions?.map((exhibition) => (
          <Fragment key={exhibition.id}>
            <div className="exhibition-item">
              <img
                className="exhibition-image"
                src={`${backendUrlImages}${exhibition.image}`}
                alt={exhibition.title}
              />
              <div className="exhibition-info">
                <div className="titlee">{exhibition.title}</div>
                <div className="date">{exhibition.date}</div>
                <div className="place">{exhibition.place}</div>
                <div className="actions-btns">
                  <button
                    className="view"
                    onClick={() => {
                      console.log("yes");

                      setOpenViewForm(true);
                      setExhibitionData(exhibition);
                    }}
                  >
                    View
                  </button>
                  <button
                    className="edit"
                    onClick={() => {
                      handleEditClick(exhibition);
                    }}
                  >
                    Edit
                  </button>
                </div>
              </div>
            </div>
          </Fragment>
        ))}
      </div>
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />

      <ViewFormExhibitions
        isOpen={openViewForm}
        setIsOpen={setOpenViewForm}
        exhibitionData={exhibitionData}
      />

      <MySideDrawer isOpen={openAddExhibition} setIsOpen={setOpenAddExhibition}>
        <ExhibitionForm
          setIsOpen={setOpenAddExhibition}
          getExhibitions={getExhibitions}
        />
      </MySideDrawer>
      <MySideDrawer isOpen={isEditDrawerOpen} setIsOpen={setIsEditDrawerOpen}>
        <EditExhibitionForm
          setIsOpen={setIsEditDrawerOpen}
          getExhibitions={getExhibitions}
          exhibitionData={exhibitionData}
        />
      </MySideDrawer>
    </div>
  );
};

export default Exhibitions;
