import React, { Fragment, useEffect, useState } from "react";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import EditConferenceForm from "../../components/EditConferenceForm";
import "./style.scss";
import Input from "../../CoreComponent/Input";
import ConferencesAdmin from "../../components/ConferencesAdmin";
import axios from "axios";
import { backendUrlImages } from "../../constant/config";
import SVG from "react-inlinesvg";
import downloadIcon from "../../icons/downloadIcon.svg";
import Select from "../../CoreComponent/Select";
import Pagination from "../../CoreComponent/Pagination";
import EditConferencesAdmin from "../../components/ConferencesAdmin/editForm";
import httpService from "../../common/httpService";
import AirportTransferPrice from "../../components/last_pages/AirportTransfer/AirpotPrice";
import { useNavigate } from "react-router-dom";
const ConferencesPage = () => {
  const navigate = useNavigate();
  const [selectedConferenceId, setSelectedConferenceId] = useState(null);
  let conferenceId = 0;
  const [isViewDrawerOpen, setIsViewDrawerOpen] = useState(false);
  const [conferenceData, setConferenceData] = useState({});
  const [conferenceName, setConferenceName] = useState("");
  const [openAddConference, setOpenAddConference] = useState(false);
  const [openEditConference, setOpenEditConference] = useState(false);
  const [allConference, setAllConference] = useState([]);
  const [selectedConference, setSelectedConference] = useState({});
  const [status, setStatus] = useState("upcoming");
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [isOpenPrice, setIsOpenPrice] = useState(false);
  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };
  const handleViewClick = (conference) => {
    setSelectedConference(conference);
    setIsViewDrawerOpen(true);
  };
  const handlePriceClick = (conference) => {
    setSelectedConference(conference);
    setTimeout(() => {
      setIsOpenPrice(true);
    }, [10]);
  };
  const handleEditClick = (conferenceId, conference) => {
    setSelectedConferenceId(conferenceId);
    setConferenceData(conference);

    setTimeout(() => {
      setOpenEditConference(true);
    }, [300]);
  };

  const getConference = () => {
    const searchQuery = conferenceName
      ? `?search=${encodeURIComponent(conferenceName)}`
      : "";
    const url = `${BaseUrl}/con${searchQuery}`;

    httpService({
      method: "GET",
      url,
      params: {
        page: currentPage,
        per_page: 12,
        status: status?.value,
      },
      onSuccess: (data) => {
        console.log(data);
        setTotalPages(data.total_pages);
        setAllConference(data.data);
      },
      onError: (error) => {
        console.error(error);
      },
      showLoader: true,
      withToast: true,
    });
  };

  useEffect(() => {
    getConference();
  }, [conferenceName, currentPage, status]);

  return (
    <div className="conferences-page">
      <div className="conferences-form-admin-header">
        <div className="inputs-container">
          <Input
            placeholder="Search"
            inputValue={conferenceName}
            setInputValue={setConferenceName}
            type="text"
            label={"conference Name"}
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
          className="add-conferences-btn"
          onClick={() => setOpenAddConference(true)}
        >
          Add new Conferences
        </button>
      </div>
      <div className="conference-list">
        {allConference?.map((conference) => {
          return (
            <Fragment key={conference.id}>
              <div className="conference-item">
                <img
                  className="conference-image"
                  src={`${backendUrlImages}${conference.image}`}
                  alt={conference.title}
                  onError={(e) => {
                    e.target.src = require("./image.jpg");
                  }}
                />

                <div className="conference-info">
                  <div className="titlee">{conference.title}</div>
                  <div className="date">{conference.date}</div>
                  <div className="place">{conference.place}</div>
                  <div className="actions-btns">
                    <button
                      className="view"
                      onClick={() => {
                        handleViewClick(conference);
                      }}
                    >
                      View
                    </button>

                    <button
                      className="edit"
                      onClick={() => handleEditClick(conference.id, conference)}
                    >
                      Edit
                    </button>
                  </div>
                </div>
                <div className="actions-btns2">
                  <button
                    className="view"
                    onClick={() => {
                      handlePriceClick(conference);
                    }}
                  >
                    Airport Transfer Price
                  </button>
                  <button
                    className="view"
                    onClick={() => {
                      navigate(`/table/dinner/speaker/${conference.id}`);
                    }}
                  >
                    Dinner details
                  </button>
                </div>
              </div>
            </Fragment>
          );
        })}
      </div>

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />
      <MySideDrawer isOpen={openAddConference} setIsOpen={setOpenAddConference}>
        <ConferencesAdmin
          setIsOpen={setOpenAddConference}
          getConference={getConference}
        />
      </MySideDrawer>
      <MySideDrawer
        isOpen={openEditConference}
        setIsOpen={setOpenEditConference}
      >
        <EditConferencesAdmin
          setIsOpen={setOpenEditConference}
          getConference={getConference}
          conferenceId={selectedConferenceId}
          setConference={setSelectedConferenceId}
          conferenceData={conferenceData}
        />
      </MySideDrawer>
      <MySideDrawer isOpen={isViewDrawerOpen} setIsOpen={setIsViewDrawerOpen}>
        <div className="conference-details">
          {/* Conference Title */}
          <div className="details-header">{selectedConference?.title}</div>
          <div className="view-con-container">
            {/* Main Info Section */}
            <div className="new-section">Main Info</div>
            <div className="info-details">
              <SimpleLabelValue
                label="Start Date"
                value={selectedConference?.start_date}
              />
              <SimpleLabelValue
                label="End Date"
                value={selectedConference?.end_date}
              />
              <SimpleLabelValue
                label="Location"
                value={selectedConference?.location}
              />
            </div>

            <div className="new-section">Committee</div>
            <div className="conference-details-container">
              {selectedConference?.committee_members?.length > 0 ? (
                selectedConference?.committee_members?.map((member, index) => {
                  return (
                    <div key={index} className="committee-member">
                      <img
                        src={`${backendUrlImages}${member.committee_image}`}
                        alt={member.name}
                      />
                      <div className="member-info">
                        {member.name} - {member.role}
                      </div>
                    </div>
                  );
                })
              ) : (
                <div>No committee members available</div>
              )}
            </div>

            <div className="new-section">Topics</div>
            <div className="topics-container">
              {selectedConference?.scientific_topics ? (
                selectedConference?.scientific_topics?.map((topic, index) => (
                  <div className="topic" key={index}>
                    {topic?.title || ""}
                  </div>
                ))
              ) : (
                <div>No topics available</div>
              )}
            </div>

            <div className="new-section">Downloads</div>
            <div className="downloads-container">
              <SimpleLabelValue
                label="Download First Announcement PDF"
                value={
                  <div>
                    <a
                      href={`${backendUrlImages}${selectedConference?.first_announcement_pdf}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <SVG
                        className="delete-icon"
                        src={downloadIcon}
                        height={25}
                        width={25}
                      />
                    </a>
                  </div>
                }
              />
              <SimpleLabelValue
                label=" Download Second Announcement PDF"
                value={
                  <div>
                    <a
                      href={`${backendUrlImages}${selectedConference?.second_announcement_pdf}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <SVG
                        className="delete-icon"
                        src={downloadIcon}
                        height={25}
                        width={25}
                      />
                    </a>
                  </div>
                }
              />
              <SimpleLabelValue
                label="Download Conference Brochure PDF"
                value={
                  <div>
                    <a
                      href={`${backendUrlImages}${selectedConference?.conference_brochure_pdf}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <SVG
                        className="delete-icon"
                        src={downloadIcon}
                        height={25}
                        width={25}
                      />
                    </a>
                  </div>
                }
              />

              <SimpleLabelValue
                label=" Download Scientific Program PDF"
                value={
                  <div>
                    <a
                      href={`${backendUrlImages}${selectedConference?.conference_scientific_program_pdf}`}
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <SVG
                        className="delete-icon"
                        src={downloadIcon}
                        height={25}
                        width={25}
                      />
                    </a>
                  </div>
                }
              />
            </div>
          </div>
        </div>
      </MySideDrawer>
      <AirportTransferPrice
        isOpen={isOpenPrice}
        setIsOpen={setIsOpenPrice}
        selectedConference={selectedConference}
      />
    </div>
  );
};

export default ConferencesPage;
