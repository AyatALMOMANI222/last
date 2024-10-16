import React from "react";
import "./style.scss";

const ConferenceCard = ({ title, description, buttonLink, imageUrl }) => {
  return (
    <div className="conference-card">
      <div className="headline-picture2" style={{ backgroundImage: `url(${imageUrl})` }}></div>
      <div className="card-content">
        <h2 className="card-title">{title}</h2>
        <p className="card-description">{description}</p>
        <a href={buttonLink} className="read-more-button">
          Read more →
        </a>
      </div>
    </div>
  );
};

const Conf = () => {
  const conferenceData = [
    {
      title: "Conferences",
      description:
        "Our very skilled staff carefully provides for all phases of a conference, such as planning, preparation, and management.",
      buttonLink: "/conf",
      imageUrl: require("./image/confercnee.jpg"),
    },
    {
      title: "Expositions",
      description:
        "Our staff offers to associations, ministries, academies, institutions, and foundations all the services which are necessary to organize exhibitions satisfying every standard.",
      buttonLink: "/expositions",
      imageUrl: require("./image/Expositions2.jpeg"),
    },
    {
      title: "Workshops",
      description:
        "Facilitate the work between the research team and the other teams and assist in managing workshop materials, including preparing materials to be used.",
      buttonLink: "/workshops",
      imageUrl: require("./image/Workshops2.jpg"),
    },
    {
      title: "Seminars",
      description: "Our team assists in organizing seminars for knowledge sharing.",
      buttonLink: "/seminars",
      imageUrl: require("./image/Seminars2.jpg"),
    },
    {
      title: "Corporate meetings",
      description: "We manage corporate meetings to ensure seamless execution.",
      buttonLink: "/corporate_meetings",
      imageUrl: require("./image/Corporatemeetings33.jpg"),
    },
    {
      title: "Event planning",
      description:
        "Our expert level of planning and budgeting ensures deadlines are met and budget overruns never arise.",
      buttonLink: "/planning",
      imageUrl: require("./image/Eventplanning2.jpg"),
    },
    {
      title: "Media campaigns",
      description:
        "Our dedicated marketing department handles all publicity and marketing aspects to help you reach out to your potential sponsors, participants, delegates, and targeted audience.",
      buttonLink: "/media_campaign",
      imageUrl: require("./image/Mediacampaigns.webp"),
    },
    {
      title: "Concept creation",
      description:
        "Our team is an expert on setting objectives to creatively design and develop the overall branding and image for the meetings or events.",
      buttonLink: "/concept_creation",
      imageUrl: require("./image/Conceptcreation.jpeg"),
    },
    {
      title: "Logistics",
      description: "We ensure smooth logistics for your events.",
      buttonLink: "/logistic_secretarial",
      imageUrl: require("./image/Logistics.jpeg"),
    },
    {
      title: "Management consulting",
      description:
        "Our clients call us when they have something pressing on their minds—whether it is a major strategic or operational need or an organizational challenge. Looking for honest, objective, thoughtful, and experienced advice.",
      buttonLink: "/management_consulting",
      imageUrl: require("./image/Managementconsulting.jpeg"),
    },
    {
      title: "Audiovisual",
      description: "We provide all audiovisual services for your events.",
      buttonLink: "/audiovisuals",
      imageUrl: require("./image/Audiovisual.webp"),
    },
  ];

  return (
    <div className="conferences-container">
      <div className="headline-picture-main" style={{ backgroundImage: `url(path-to-your-main-image.jpg)` }}>
        <h1>Welcome to Our Events</h1>
      </div>
      {conferenceData.map((data, index) => (
        <ConferenceCard
          key={index}
          title={data.title}
          description={data.description}
          buttonLink={data.buttonLink}
          imageUrl={data.imageUrl}
        />
      ))}
    </div>
  );
};

export default Conf;
