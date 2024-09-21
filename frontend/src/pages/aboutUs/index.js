import React from "react";
import "./style.scss";

const AboutUs = () => {
  return (
    <div className="about-page">
      <section className="hero-section">
        <div className="about-title">About Us</div>
        <div>
          Welcome to BookStore, where stories come to life. We are passionate
          about bringing you the best in literature from around the world.
        </div>
      </section>

      <section className="our-story">
        <h2>Our Story</h2>
        <p>
          Founded in 2023, BookStore was born from a love of books and a desire
          to make reading more accessible to everyone. What started as a small
          corner bookshop has grown into a thriving community of readers,
          authors, and book lovers.
        </p>
      </section>

      <section className="mission-section">
        <h2>Our Mission</h2>
        <p>
          Our mission is to inspire and empower through the written word.
          Whether you're looking for a new bestseller or a timeless classic, we
          strive to curate a collection that offers something for every reader.
        </p>
      </section>
    </div>
  );
};

export default AboutUs;
