import React from "react";
import Card from "../../CardEvent";

const PastEvent = () => {
  return (
    <div className="upcoming-conferences-container" >
      <h2 className="section-title">Past Event</h2>

      <Card
        imageUrl={require("./233.jpg")}
        title="عنوان المكون"
        description="هنا نص مختصر يوضح محتوى المكون..."
        seeMoreLink="/target-page"
        galleryLink="https://example.com/gallery"
        buttonText="Read More"
        galleryButtonText="Explore Gallery"
      />
      <Card
        imageUrl={require("./233.jpg")}
        title="عنوان المكون"
        description="هنا نص مختصر يوضح محتوى المكون..."
        seeMoreLink="/target-page"
        galleryLink="https://example.com/gallery"
        buttonText="Read More"
        galleryButtonText="Explore Gallery"
      />
      <Card
        imageUrl={require("./233.jpg")}
        title="عنوان المكون"
        description="هنا نص مختصر يوضح محتوى المكون..."
        seeMoreLink="/target-page"
        galleryLink="https://example.com/gallery"
        buttonText="Read More"
        galleryButtonText="Explore Gallery"
      />
    </div>
  );
};

export default PastEvent;
