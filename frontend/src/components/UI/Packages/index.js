import React from "react";
import "./style.scss";

const PackagesCard = ({ title, description, buttonLink, imageUrl }) => {
  return (
    <div className="packages-card">
      <div className="headline-picture2" style={{ backgroundImage: `url(${imageUrl})` }}></div>
      <div className="card-content">
        <h2 className="card-title">{title}</h2>
        <p className="card-description">{description}</p>
        <a href={buttonLink} className="read-more-button">
          Get Package →
        </a>
      </div>
    </div>
  );
};

const Packages = () => {
  const conferenceData = [
   
    {
      title: "Luxurious spa trip in the Dead Sea",
      description:"",
      buttonLink: "/",
      imageUrl: require("./image/packages1.jpeg"),
    },
    {
      title: "Historical tour in Jordan",
      description: "",
      buttonLink: "/",
      imageUrl: require("./image/Historical.jpg"),
    },
    {
      title: "Educational tour on Jordan’s religious sights and culture",
      description:"",
      buttonLink: "/",
      imageUrl: require("./image/Educational.jpg"),
    },
    {
      title: "Stargazing in the earths mars (wadi rum)",
      description: "",
      buttonLink: "/",
      imageUrl: require("./image/Stargazing.jpeg"),
    },
  ];

  return (
    <div className="packages-container">
   
      {conferenceData.map((data, index) => (
        <PackagesCard
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

export default Packages;
