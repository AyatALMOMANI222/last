import React, { useState, useEffect } from "react";
import "./style.scss"; 

const slides = [
  <img src="slide1.jpg" alt="Slide 1" />,
  <img src="slide2.jpg" alt="Slide 2" />,
  <img src="slide3.jpg" alt="Slide 3" />,
  <img src="slide1.jpg" alt="Slide 4" />,
  <img src="slide2.jpg" alt="Slide 5" />,
  <img src="slide3.jpg" alt="Slide 6" />,
];

const Slider = () => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [render, setRender] = useState(true);

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentIndex((prevIndex) => {
        if (prevIndex === slides.length - 1) {
          setRender(false);
          setTimeout(() => {
            setRender(true);
          }, [10]);
          return 0;
        }
        return prevIndex + 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, []);
  if (render) {
    return (
      <div className="slider-container">
        <div className="slides-container">
          <div
            className="slides"
            style={{
              transform: `translateX(-${currentIndex * 100}%)`,
              transition: "transform 0.5s ease-in-out",
            }}
          >
            {slides.map((slide, index) => (
              <div key={index} className="slide">
                {slide}
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }
};

export default Slider;
