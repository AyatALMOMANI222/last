// TourSlider.js
import React, { useState, useEffect } from "react";
import destinations from "./destinations";
import { useNavigate } from "react-router-dom";
import "./style.scss"; // تأكد من إضافة ملف CSS للتنسيق

const TourSlider = () => {
  const [currentSlideIndex, setCurrentSlideIndex] = useState(
    Array(destinations.length).fill(0)
  );
  const navigate = useNavigate();
  const changeSlide = (direction, index) => {
    setCurrentSlideIndex((prevIndex) => {
      const newIndex = [...prevIndex];
      newIndex[index] =
        (newIndex[index] + direction + destinations[index].images.length) %
        destinations[index].images.length;
      return newIndex;
    });
  };

  // إضافة دالة لتغيير الشريحة تلقائيًا
  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentSlideIndex((prevIndex) => {
        const newIndex = [...prevIndex];
        return newIndex.map(
          (index, i) => (index + 1) % destinations[i].images.length
        );
      });
    }, 3000); // تغيير الشريحة كل 3 ثوانٍ

    return () => clearInterval(interval); // تنظيف الـ interval عند فك التركيب
  }, []);

  return (
    <div className="tour-slider">
      <h1>Tourist Attractions in Jordan</h1>
      {destinations.map((destination, index) => (
        <div key={index} className="destination">
          <div className="slider-container">
            <div className="slider">
              <div
                className="slides"
                style={{
                  transform: `translateX(-${currentSlideIndex[index] * 100}%)`,
                }}
              >
                {destination.images.map((img, imgIndex) => (
                  <div key={imgIndex} className="slide">
                    <img src={img} alt={destination.title} />
                  </div>
                ))}
              </div>
              <button className="prev" onClick={() => changeSlide(-1, index)}>
                ❮
              </button>
              <button className="next" onClick={() => changeSlide(1, index)}>
                ❯
              </button>
            </div>
            <div className="destination-info">
              <h1>{destination.title}</h1>
              <p>{destination.description}</p>
              <div className="button-container3">
                <button
                  className="book-now-button"
                  onClick={() => {
                    navigate("/registerType");
                  }}
                >
                  Book Now
                </button>
                {/* <button className="get-package-button">Get Package</button> */}
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default TourSlider;
