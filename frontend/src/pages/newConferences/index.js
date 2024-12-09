import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import httpService from "../../common/httpService";
import { backendUrlImages } from "../../constant/config";
import image from "./file.png";
import PaperSubmissionForm from "../../components/abstract/abstractUser";
import Speakers4 from "../../components/SpeakerProduct";
import "./style.scss";
import Home from "../HomeR";
import Welcome from "../../components/UI/Welcome";

const ConferenceDetails = () => {
  const { conferenceId } = useParams();
  const navigate = useNavigate(); // Hook for navigation
  const [selectedSection, setSelectedSection] = useState("overview");
  const [data, setData] = useState({});
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const getConferenceData = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    const response = await httpService({
      method: "GET",
      url: `${BaseUrl}/con/id/${conferenceId}`,
      headers: { Authorization: `Bearer ${getAuthToken()}` },
    });

    setData(response);
  };

  useEffect(() => {
    getConferenceData();
  }, []);

  const sections = {
    overview: "Conference Overview",
    home: "Home",
    Welcome: "Welcome",
    Abstract: "Abstract",
    Speakers: "Speakers",
    topics: "Scientific Topics",
    pricing: "Pricing Information",
    committee: "Committee Members",
    firstAnnouncement: "First Announcement Document",
    secondAnnouncement: "Second Announcement Document",
    brochure: "Conference Brochure",
    scientificProgram: "Scientific Program Document",
  };

  const renderContent = () => {
    const { conference, scientific_topics, prices, committee_members } = data;

    const renderDocumentContent = (url, label) => (
      <div className="document-section">
        {url ? (
          <>
            <div className="document-preview">
              <img src={image} alt="Document Icon" width={"100px"} />
            </div>
            <div className="document-info">
              <h3>{label}</h3>
              <p className="desc">
                This document contains important details about {label}. Please
                download it for more information.
              </p>
              <a href={url} download className="btn-download">
                Download {label}
              </a>
            </div>
          </>
        ) : (
          <div className="no-document">
            <div className="document-preview">
              <img src="/path/to/no-document-icon.png" />
            </div>
            <div className="document-info">
              <h3>{label}</h3>
              <p>No document is currently available for this section.</p>
            </div>
          </div>
        )}
      </div>
    );

    switch (selectedSection) {
      case "home":
        return (
          <div className="content">
            <Home />
          </div>
        );
      case "Welcome":
        return (
          <div className="content">
            <Welcome />
          </div>
        );
      case "overview":
        return (
          <div className="image-with-content">
            <div className="content">
              {data?.image_url ? (
                <img
                  className="img-conference"
                  src={data?.image_url}
                  alt="Conference"
                />
              ) : (
                <p>No image available.</p>
              )}
            </div>
            <div className="content">
              <h2>{conference?.title}</h2>
              <p>{conference?.description}</p>
              <div className="info-grid">
                <div>
                  <strong>Location:</strong> {conference?.location}
                </div>
              </div>
            </div>
          </div>
        );
      case "Abstract":
        return (
          <div className="content">
            <PaperSubmissionForm conferenceId={conferenceId} />
          </div>
        );
      case "Speakers":
        return (
          <div className="content">
            <Speakers4 conferenceId={conferenceId} />
          </div>
        );
      case "topics":
        return (
          <div className="content">
            {scientific_topics?.map((topic) => (
              <div key={topic.id} className="card">
                <h3>{topic?.title}</h3>
                <p>{topic?.description || "No description available."}</p>
              </div>
            ))}
          </div>
        );
      case "pricing":
        return (
          <div className="content">
            {prices?.map((price) => (
              <div key={price.id} className="card">
                <h3>{price?.price_type}</h3>
                <p>
                  <strong>Price:</strong> {price?.price}
                </p>
                <p>{price?.description}</p>
              </div>
            ))}
          </div>
        );
      case "committee":
        return (
          <div className="content">
            {committee_members?.map((member) => (
              <div key={member.id} className="card">
                <img
                  src={`${backendUrlImages}${member?.committee_image}`}
                  alt={member?.name}
                />
                <h3>{member?.name}</h3>
              </div>
            ))}
          </div>
        );
      case "visa":
        return (
          <div className="content">
            <p>
              <strong>Visa Price:</strong> {conference?.visa_price}
            </p>
          </div>
        );
      case "firstAnnouncement":
        return renderDocumentContent(
          data?.first_announcement_pdf_url,
          "First Announcement"
        );
      case "secondAnnouncement":
        return renderDocumentContent(
          data?.second_announcement_pdf_url,
          "Second Announcement"
        );
      case "brochure":
        return renderDocumentContent(
          data?.conference_brochure_pdf_url,
          "Brochure"
        );
      case "scientificProgram":
        return renderDocumentContent(
          data?.conference_scientific_program_pdf_url,
          "Scientific Program"
        );
    }
  };

  return (
    <div className="conference-detailss">
      <div className="side-drawer">
        {Object.entries(sections).map(([key, title]) => (
          <button
            key={key}
            className={`drawer-item ${selectedSection === key ? "active" : ""}`}
            onClick={() => setSelectedSection(key)}
          >
            {title}
          </button>
        ))}
      </div>
      <div className="main-content">{renderContent()}</div>
    </div>
  );
};

export default ConferenceDetails;
