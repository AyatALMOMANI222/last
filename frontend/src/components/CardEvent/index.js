import React from 'react';
import { useNavigate } from 'react-router-dom';
import './style.scss';

const Card = ({
  imageUrl,
  title,
  description,
  seeMoreLink,
  galleryLink,
  buttonText = 'See More',
  galleryButtonText = 'View Gallery',
}) => {
  const navigate = useNavigate();

  const handleSeeMore = () => {
    navigate(seeMoreLink); // التنقل إلى المسار الذي تم تمريره عبر props
  };

  return (
    <div className="card">
      <div className="card-image">
        <img src={imageUrl} alt="card" />
        {galleryLink && (
          <button className="view-gallery-btn" onClick={() => window.open(galleryLink, '_blank')}>
            {galleryButtonText}
          </button>
        )}
      </div>
      <div className="card-content">
        <h3>{title}</h3>
        <p>{description}</p>
        {seeMoreLink && (
          <button className="see-more-btn" onClick={handleSeeMore}>
            {buttonText}
          </button>
        )}
      </div>
    </div>
  );
};

export default Card;
