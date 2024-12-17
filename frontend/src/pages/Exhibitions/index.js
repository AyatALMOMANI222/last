import React, { Fragment, useEffect, useState } from "react";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import Input from "../../CoreComponent/Input";
import { backendUrlImages } from "../../constant/config";
import ImageUpload from "../../CoreComponent/ImageUpload";
import DateInput from "../../CoreComponent/Date";
import axios from "axios";
import { toast } from "react-toastify";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import Pagination from "../../CoreComponent/Pagination";
import ViewFormExhibitions from "./ViewForm";
import EditExhibitionForm from "./EditForm";
import httpService from "../../common/httpService";

const ExhibitionForm = ({ setIsOpen, getExhibitions }) => {
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [location, setLocation] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const [exhibitionImages, setExhibitionImages] = useState([]); // إدارة الصور كصفيف
  const [errorMsg, setErrorMsg] = useState("");
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState([]);
  const [exhibitionImage, setExhibitionImage] = useState("");
  //
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getConference = () => {
    const url = `${BaseUrl}/conferences/all`;

    axios
      .get(url)
      .then((response) => {
        setAllConference([
          { label: "None", value: null },
          ...response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          }),
        ]);
      })
      .catch((error) => {});
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleImageChange = (index, file) => {
    const updatedImages = [...exhibitionImages];
    updatedImages[index] = file;
    setExhibitionImages(updatedImages);
  };

  const addImageField = () => {
    setExhibitionImages([...exhibitionImages, null]);
  };

  const removeImageField = (index) => {
    const updatedImages = exhibitionImages.filter((_, i) => i !== index);
    setExhibitionImages(updatedImages);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    const formData = new FormData();
    if (conferenceId?.value) {
      formData.append("conference_id", conferenceId?.value);
    } else {
      formData.append("conference_id", "");
    }
    formData.append("title", title);
    formData.append("description", description);
    formData.append("location", location);
    formData.append("start_date", startDate);
    formData.append("end_date", endDate);
    formData.append("image", exhibitionImage);
    exhibitionImages.forEach((image, index) => {
      if (image) {
        formData.append(`images[${index}]`, image);
      }
    });

    try {
      const response = await axios.post(`${BaseUrl}/exhibitions`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${token}`,
        },
      });

      toast.success("The Data updated Successfully");
      setIsOpen(false);
      setTitle("");
      setDescription("");
      setLocation("");
      setStartDate("");
      setEndDate("");
      setExhibitionImages([]);
      getExhibitions();
    } catch (error) {
      setErrorMsg("An error occurred. Please try again.");
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
        <ImageUpload
          label="Exhibition Images"
          inputValue={exhibitionImage}
          setInputValue={setExhibitionImage}
          allowedExtensions={["jpg", "jpeg", "png"]}
          errorMsg={errorMsg}
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

        {exhibitionImages.map((_, index) => (
          <div key={index} className="image-upload-container">
            <ImageUpload
              label={`Exhibition Image ${index + 1}`}
              inputValue={exhibitionImages[index]}
              setInputValue={(file) => handleImageChange(index, file)}
              allowedExtensions={["jpg", "jpeg", "png"]}
              errorMsg={errorMsg}
            />
            <button
              type="button"
              className="remove-image-btn"
              onClick={() => removeImageField(index)}
            >
              Remove
            </button>
          </div>
        ))}
        <button className="submit-btn" type="button" onClick={addImageField}>
          Add Image
        </button>
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
