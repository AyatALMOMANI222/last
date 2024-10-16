import React from 'react';
import './style.scss';

const Slider = () => {
  return (
    <div className="slider">
      <div className="slides">
        <div className="slide">
          <img src="https://via.placeholder.com/1200x500" alt="Slide 1" />
        </div>
        <div className="slide">
          <video controls>
            <source src="your-video.mp4" type="video/mp4" />
          </video>
        </div>
        <div className="slide">
          <img src="https://via.placeholder.com/1200x500" alt="Slide 2" />
        </div>
      </div>
      <div className="controls">
        <button className="prev">❮</button>
        <button className="next">❯</button>
      </div>
    </div>
  );
};

export default Slider;
