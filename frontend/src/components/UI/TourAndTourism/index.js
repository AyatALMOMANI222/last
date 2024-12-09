import React from "react";
import { useNavigate } from "react-router-dom";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import destinations from "./destinations";
import "./style.scss";

// Slick slider settings
const sliderSettings = {
  dots: true,
  infinite: true,
  speed: 500,
  slidesToShow: 1,
  slidesToScroll: 1,
  autoplay: true,
  autoplaySpeed: 3000,
  arrows: true,
};

const TourSlider = () => {
  const navigate = useNavigate();

  const DestinationCard = ({ destination }) => (
    <div className="destination">
      <div className="slider-container">
        <Slider {...sliderSettings}>
          {destination.images.map((img, imgIndex) => (
            <div key={imgIndex} className="slide">
              <img src={img} alt={destination.title} />
            </div>
          ))}
        </Slider>
        <DestinationInfo destination={destination} />
      </div>
    </div>
  );

  const DestinationInfo = ({ destination }) => (
    <div className="destination-info">
      <h1>{destination.title}</h1>
      <p>{destination.description}</p>
      <div className="button-container3">
        <button
          className="book-now-button"
          onClick={() => navigate("/registerType")}
        >
          Book Now
        </button>
      </div>
    </div>
  );

  return (
    <div className="tour-slider56">
      <h1>Tourist Attractions in Jordan</h1>
      {destinations.map((destination, index) => (
        <DestinationCard key={index} destination={destination} />
      ))}
    </div>
  );
};

export default TourSlider;
