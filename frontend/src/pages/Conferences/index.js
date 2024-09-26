import React, { Fragment, useEffect, useState } from "react";
import thumbnailImag from "../../icons/test2.jpg";
import manImag from "../../icons/man.jpg";
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
const previousConferences = [
  {
    id: 1,
    title: "International Conference 2021",
    date: "2024-09-28",
    place: "Dubai, UAE",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement.pdf",
    secondAnnouncement: "/path/to/second-announcement.pdf",
    committee: [
      { name: "Dr. John Doe", image: manImag, role: "Chair" },
      { name: "Dr. Jane Smith", image: manImag, role: "Co-Chair" },
      { name: "Dr. John Doe", image: manImag, role: "Chair" },
      { name: "Dr. Jane Smith", image: manImag, role: "Co-Chair" },
    ],
    topics: ["AI", "Machine Learning", "Blockchain"],
    scientificPapers: "/path/to/scientific-papers.pdf",
    scientificProgram: "/path/to/scientific-program.pdf",
  },
  {
    id: 2,
    title: "Global Tech Summit 2020",
    date: "March 10, 2020",
    place: "San Francisco, USA",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2020.pdf",
    secondAnnouncement: "/path/to/second-announcement-2020.pdf",
    committee: [
      { name: "Dr. Emily Clark", image: manImag, role: "Chair" },
      { name: "Dr. David Lee", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Cloud Computing", "Cybersecurity", "Quantum Computing"],
    scientificPapers: "/path/to/scientific-papers-2020.pdf",
    scientificProgram: "/path/to/scientific-program-2020.pdf",
  },
  {
    id: 3,
    title: "AI & Robotics Expo 2019",
    date: "July 5, 2019",
    place: "Tokyo, Japan",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2019.pdf",
    secondAnnouncement: "/path/to/second-announcement-2019.pdf",
    committee: [
      { name: "Dr. Michael Brown", image: manImag, role: "Chair" },
      { name: "Dr. Susan Wilson", image: manImag, role: "Co-Chair" },
    ],
    topics: ["AI", "Robotics", "Automation"],
    scientificPapers: "/path/to/scientific-papers-2019.pdf",
    scientificProgram: "/path/to/scientific-program-2019.pdf",
  },
  {
    id: 4,
    title: "Future of Data Science 2022",
    date: "November 15, 2022",
    place: "Berlin, Germany",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2022.pdf",
    secondAnnouncement: "/path/to/second-announcement-2022.pdf",
    committee: [
      { name: "Dr. Albert Kim", image: manImag, role: "Chair" },
      { name: "Dr. Rachel Adams", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Big Data", "Data Analytics", "AI Ethics"],
    scientificPapers: "/path/to/scientific-papers-2022.pdf",
    scientificProgram: "/path/to/scientific-program-2022.pdf",
  },
  {
    id: 5,
    title: "International Blockchain Conference 2023",
    date: "June 12, 2023",
    place: "Singapore",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2023.pdf",
    secondAnnouncement: "/path/to/second-announcement-2023.pdf",
    committee: [
      { name: "Dr. Karen Wang", image: manImag, role: "Chair" },
      { name: "Dr. Robert Harris", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Blockchain", "Decentralized Finance", "Smart Contracts"],
    scientificPapers: "/path/to/scientific-papers-2023.pdf",
    scientificProgram: "/path/to/scientific-program-2023.pdf",
  },
  {
    id: 6,
    title: "Healthcare Innovations Summit 2021",
    date: "December 2, 2021",
    place: "London, UK",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-health.pdf",
    secondAnnouncement: "/path/to/second-announcement-health.pdf",
    committee: [
      { name: "Dr. Olivia Martinez", image: manImag, role: "Chair" },
      { name: "Dr. Benjamin Lewis", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Telemedicine", "Health Data Privacy", "AI in Healthcare"],
    scientificPapers: "/path/to/scientific-papers-health.pdf",
    scientificProgram: "/path/to/scientific-program-health.pdf",
  },
  {
    id: 7,
    title: "International Conference 2021",
    date: "August 21, 2021",
    place: "Dubai, UAE",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement.pdf",
    secondAnnouncement: "/path/to/second-announcement.pdf",
    committee: [
      { name: "Dr. John Doe", image: manImag, role: "Chair" },
      { name: "Dr. Jane Smith", image: manImag, role: "Co-Chair" },
      { name: "Dr. John Doe", image: manImag, role: "Chair" },
      { name: "Dr. Jane Smith", image: manImag, role: "Co-Chair" },
    ],
    topics: ["AI", "Machine Learning", "Blockchain"],
    scientificPapers: "/path/to/scientific-papers.pdf",
    scientificProgram: "/path/to/scientific-program.pdf",
  },
  {
    id: 8,
    title: "Global Tech Summit 2020",
    date: "March 10, 2020",
    place: "San Francisco, USA",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2020.pdf",
    secondAnnouncement: "/path/to/second-announcement-2020.pdf",
    committee: [
      { name: "Dr. Emily Clark", image: manImag, role: "Chair" },
      { name: "Dr. David Lee", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Cloud Computing", "Cybersecurity", "Quantum Computing"],
    scientificPapers: "/path/to/scientific-papers-2020.pdf",
    scientificProgram: "/path/to/scientific-program-2020.pdf",
  },
  {
    id: 9,
    title: "AI & Robotics Expo 2019",
    date: "July 5, 2019",
    place: "Tokyo, Japan",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2019.pdf",
    secondAnnouncement: "/path/to/second-announcement-2019.pdf",
    committee: [
      { name: "Dr. Michael Brown", image: manImag, role: "Chair" },
      { name: "Dr. Susan Wilson", image: manImag, role: "Co-Chair" },
    ],
    topics: ["AI", "Robotics", "Automation"],
    scientificPapers: "/path/to/scientific-papers-2019.pdf",
    scientificProgram: "/path/to/scientific-program-2019.pdf",
  },
  {
    id: 10,
    title: "Future of Data Science 2022",
    date: "November 15, 2022",
    place: "Berlin, Germany",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2022.pdf",
    secondAnnouncement: "/path/to/second-announcement-2022.pdf",
    committee: [
      { name: "Dr. Albert Kim", image: manImag, role: "Chair" },
      { name: "Dr. Rachel Adams", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Big Data", "Data Analytics", "AI Ethics"],
    scientificPapers: "/path/to/scientific-papers-2022.pdf",
    scientificProgram: "/path/to/scientific-program-2022.pdf",
  },
  {
    id: 11,
    title: "International Blockchain Conference 2023",
    date: "June 12, 2023",
    place: "Singapore",
    thumbnail: thumbnailImag,
    firstAnnouncement: "/path/to/first-announcement-2023.pdf",
    secondAnnouncement: "/path/to/second-announcement-2023.pdf",
    committee: [
      { name: "Dr. Karen Wang", image: manImag, role: "Chair" },
      { name: "Dr. Robert Harris", image: manImag, role: "Co-Chair" },
    ],
    topics: ["Blockchain", "Decentralized Finance", "Smart Contracts"],
    scientificPapers: "/path/to/scientific-papers-2023.pdf",
    scientificProgram: "/path/to/scientific-program-2023.pdf",
  },
];

const ConferencesPage = () => {
  const [selectedConferenceId, setSelectedConferenceId] = useState(null);
  const [isViewDrawerOpen, setIsViewDrawerOpen] = useState(false);
  const [isEditDrawerOpen, setIsEditDrawerOpen] = useState(false);
  const [conferenceData, setConferenceData] = useState(previousConferences[0]);
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
    setConferenceData(
      previousConferences.find((conference) => conference.id === conferenceId)
    );
  };

  const getConference = () => {
    axios
      .get("http://127.0.0.1:8000/api/con")
      .then((response) => {
        console.log("Conferences retrieved successfully:", response.data.data);
        setAllConference(response.data.data);
      })
      .catch((error) => {
        // معالجة الأخطاء
        console.error("Error retrieving conferences:", error);
        // يمكنك أيضًا عرض رسالة للمستخدم أو اتخاذ إجراءات أخرى
      });
  };
  useEffect(() => {
    getConference();
  }, []);
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
                {/* <iframe
                      src={`${backendUrlImages}${conference.second_announcement_pdf}`}
                  style={{ width: "100%", height: "600px" }}
                  title="PDF Preview"
                /> */}
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
        <ConferencesAdmin setIsOpen={setOpenAddConference} />
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
