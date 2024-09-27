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

const ConferencesPage = () => {
  const [selectedConferenceId, setSelectedConferenceId] = useState(null);
  const [isViewDrawerOpen, setIsViewDrawerOpen] = useState(false);
  const [isEditDrawerOpen, setIsEditDrawerOpen] = useState(false);
  const [conferenceData, setConferenceData] = useState();
  const [conferenceName, setConferenceName] = useState("");
  const [openAddConference, setOpenAddConference] = useState(false);
  const [allConference, setAllConference] = useState([]);
  const [selectedConference, setSelectedConference] = useState({});
  const handleViewClick = (conference) => {
    setSelectedConference(conference);
    setIsViewDrawerOpen(true);
  };

  const handleEditClick = (conferenceId) => {
    setSelectedConferenceId(conferenceId);
    setIsEditDrawerOpen(true);
    setConferenceData();
  };

  const getConference = () => {
    const searchQuery = conferenceName
      ? `?search=${encodeURIComponent(conferenceName)}`
      : "";
    const url = `http://127.0.0.1:8000/api/con${searchQuery}`;

    axios
      .get(url)
      .then((response) => {
        console.log("Conferences retrieved successfully:", response.data.data);
        setAllConference(response.data.data);
      })
      .catch((error) => {
        console.error("Error retrieving conferences:", error);
      });
  };

  useEffect(() => {
    getConference();
  }, [conferenceName]);
  useEffect(() => {
    console.log({ selectedConference });
  }, [selectedConference]);
  return (
    <div className="conferences-page">
      <div className="conferences-form-admin-header">
        <div className="header-input">
          <Input
            placeholder="Search"
            inputValue={conferenceName}
            setInputValue={setConferenceName}
            type="text"
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
                />

                <div className="conference-info">
                  <div className="title">{conference.title}</div>
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
                      onClick={() => handleEditClick(conference.id)}
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
      <MySideDrawer isOpen={openAddConference} setIsOpen={setOpenAddConference}>
        <ConferencesAdmin
          setIsOpen={setOpenAddConference}
          getConference={getConference}
        />
      </MySideDrawer>

      {/* <MySideDrawer isOpen={isViewDrawerOpen} setIsOpen={setIsViewDrawerOpen}>
        <div className="conference-details">
          <div className="details-header">{selectedConference?.title}</div>
          <div className="new-section">Main Info</div>
          <div className="info-details">
            <SimpleLabelValue label="Date" value={selectedConference?.date} />
            <SimpleLabelValue label="Place" value={selectedConference?.place} />
          </div>
          <div className="new-section">Committee</div>
          <div className="conference-details-container">
            {selectedConference?.committee?.map((member, index) => (
              <div key={index} className="committee-member">
                <img src={member.image} alt={member.name} />
                <div className="member-info">
                  {member.name} - {member.role}
                </div>
              </div>
            ))}
          </div>
          <div className="new-section">Topics</div>
          <div className="topics-container">
            {selectedConference?.topics?.map((topic, index) => (
              <div className="topic" key={index}>
                {topic}
              </div>
            ))}
          </div>
        </div>
      </MySideDrawer> */}
      <MySideDrawer isOpen={isViewDrawerOpen} setIsOpen={setIsViewDrawerOpen}>
        <div className="conference-details">
          {/* Conference Title */}
          <div className="details-header">{selectedConference?.title}</div>

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
              selectedConference?.committee_members?.map((member, index) => (
                <div key={index} className="committee-member">
                  <img src={member.image} alt={member.name} />
                  <div className="member-info">
                    {member.name} - {member.role}
                  </div>
                </div>
              ))
            ) : (
              <div>No committee members available</div>
            )}
          </div>

          <div className="new-section">Topics</div>
          <div className="topics-container">
            {selectedConference?.scientific_topics?.length > 0 ? (
              selectedConference?.scientific_topics?.map((topic, index) => (
                <div className="topic" key={index}>
                  {topic}
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
      </MySideDrawer>

      {selectedConference && (
        <MySideDrawer isOpen={isEditDrawerOpen} setIsOpen={setIsEditDrawerOpen}>
          <EditConferenceForm
            conferenceData={conferenceData}
            setConferenceData={setConferenceData}
          />
        </MySideDrawer>
      )}
    </div>
  );
};

export default ConferencesPage;
