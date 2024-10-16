import React from 'react';
import './style.scss';

const Gallery = () => {
  return (
    <section className="gallery">
      <h2>Our Work</h2>
      <div className="media-grid">
        <div className="media-item">
          <img src="https://via.placeholder.com/400x300" alt="Gallery 1" />
        </div>
        <div className="media-item">
          <video controls>
            <source src="your-video.mp4" type="video/mp4" />
          </video>
        </div>
        <div className="media-item">
          <img src="https://via.placeholder.com/400x300" alt="Gallery 2" />
        </div>
        <div className="media-item">
          <img src="https://via.placeholder.com/400x300" alt="Gallery 3" />
        </div>
      </div>
    </section>
  );
};

export default Gallery;
