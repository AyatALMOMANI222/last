import React, { useState, useEffect } from "react";
import "./style.scss";

const ImageSlider = () => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [fade, setFade] = useState(false);

  const slides = [
    { type: 'image', src: "/image/conff66.webp", alt: "Slide 1" },
    { type: 'image', src: "/image/conff.webp", alt: "Slide 2" },
    { type: 'image', src: "/image/conf7.webp", alt: "Slide 3" },
    { type: 'image', src: "/image/confg.jpeg", alt: "Slide 4" },
    { type: 'image', src: "/image/1111.webp", alt: "Slide 5" },
    { type: 'video', src: "/image/6774633-uhd_3840_2160_30fps.mp4", alt: "Video Slide" },
  ];

  useEffect(() => {
    const interval = setInterval(() => {
      setFade(true);
      setTimeout(() => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % slides.length);
        setFade(false);
      }, 500);
    }, 4000);

    return () => clearInterval(interval);
  }, [slides.length]);

  return (
    <div className="image-slider">
      <div className={`slide-wrapper ${fade ? "fade-effect" : ""}`}>
        {slides.map((slide, index) => (
          <div
            key={index}
            className={`slide-item ${index === currentIndex ? "active-slide" : ""}`}
            style={{ display: index === currentIndex ? "block" : "none" }}
          >
            {slide.type === 'image' ? (
              <img src={slide.src} alt={slide.alt} className="slide-image" />
            ) : (
              <video src={slide.src} autoPlay loop muted className="slide-video" />
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default ImageSlider;
