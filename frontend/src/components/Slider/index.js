import React, { useState, useEffect } from "react";
import "./style.scss"; 

const Slider = () => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [fade, setFade] = useState(false);
  
  const slides = [
    <img src="/image/conff66.webp" alt="Slide 1" />,
    <img src="/image/conff.webp" alt="Slide 2" />,
    <img src="/image/conf7.webp" alt="Slide 3" />,
    <img src="/image/confg.jpeg" alt="Slide 4" />,
    <img src="/image/1111.webp" alt="Slide 5" />,
    <video 
      src="/image/6774633-uhd_3840_2160_30fps.mp4" 
      className={`slide-video ${fade ? "fade-out" : "fade-in"}`} 
      autoPlay 
      loop 
      muted 
      onEnded={() => {
        setFade(false); // أوقف التلاشي
        setCurrentIndex(0); // ارجع إلى الصورة الأولى
      }} 
      onPlay={() => setFade(false)} // عند تشغيل الفيديو، أوقف التلاشي
    />
  ];

  useEffect(() => {
    const interval = setInterval(() => {
      setFade(true); // بدء التلاشي قبل الانتقال إلى الشريحة التالية
      setTimeout(() => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % slides.length);
        setFade(false); // إعادة الظهور بعد الانتقال
      }, 500); // مدة التلاشي
    }, 4000); // مدة العرض لكل شريحة

    return () => clearInterval(interval);
  }, []);
  
  return (
    <div className="slider-container">
      <div className="slides-container">
        <div
          className="slides"
          style={{
            transform: `translateX(-${currentIndex * 100}%)`,
            transition: currentIndex === 0 ? 'none' : 'transform 0.5s ease-in-out', // إلغاء الانتقال إذا كانت الصورة الأولى
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
};

export default Slider;
