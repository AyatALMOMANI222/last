import React, { useState, useEffect } from "react";
import Slider from "react-slick";
import axios from "axios";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import "./style.scss";
import Footer from "../../components/UI/Footer";
import { toast } from "react-toastify";
import { backendUrlImages } from "../../constant/config";
import { useNavigate } from "react-router-dom";

const Home = () => {
  const [allConferences, setAllConferences] = useState([]);
  const navigate = useNavigate();

  const sliderSettings = {
    dots: true,
    infinite: true,
    speed: 500,
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 3000,
  };

  const getConference = () => {
    const BaseUrl = process.env.REACT_APP_BASE_URL;
    const url = `${BaseUrl}/con/upcoming`;
    const token = localStorage.getItem("token");

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAllConferences(response.data.upcoming_conferences);
      })
      .catch((error) => {
        toast.error("Error fetching conferences");
      });
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleConferenceClick = (conferenceId) => {
    navigate(`/conference/details/${conferenceId}`);
  };

  return (
    <div className="home-page-section">
      {/* Hero Slider */}
      <div className="slider">
        <Slider {...sliderSettings}>
          <div>
            <img
              src="/image/conff66.webp"
              alt="Slide 1"
              className="slide-image"
            />
          </div>
          <div>
            <img
              src="/image/conff.webp"
              alt="Slide 2"
              className="slide-image"
            />
          </div>
          <div>
            <img
              src="/image/conf7.webp"
              alt="Slide 3"
              className="slide-image"
            />
          </div>
          <div>
            <img
              src="/image/confg.jpeg"
              alt="Slide 4"
              className="slide-image"
            />
          </div>
        </Slider>
      </div>

      {/* Welcome Section */}
      <section className="welcome-section">
        <h1>Welcome to Our Website</h1>
        <p>
          Discover amazing content and experience top-quality services tailored
          to your needs.
        </p>
      </section>

      {/* Featured Services Section */}
      <section className="featured-section">
        <h2>Our Services</h2>
        <div className="features">
          <div className="feature">
            <img
              src="/image/conff66.webp"
              alt="Conferences"
              className="feature-icon"
            />
            <h3>Conferences</h3>
            <div className="desc">
              Conferences provide opportunities for networking, socializing, and
              hearing the latest industry trends.
            </div>
          </div>
          <div className="feature">
            <img
              src="/image/conff66.webp"
              alt="Exhibitions"
              className="feature-icon"
            />
            <h3>Exhibitions</h3>
            <div className="desc">
              Specialized in organizing Medical, Tourism, and Scientific
              Exhibitions to showcase advancements.
            </div>
          </div>
          <div className="feature">
            <img
              src="/image/conff66.webp"
              alt="Planning"
              className="feature-icon"
            />
            <h3>Planning</h3>
            <div className="desc">
              We provide high-quality planning services tailored to meet your
              needs with excellence.
            </div>
          </div>
          <div className="feature">
            <img
              src="/image/conff66.webp"
              alt="Media Campaign"
              className="feature-icon"
            />
            <h3>Media Campaign</h3>
            <div className="desc">
              Full media campaign management, including press releases and press
              conferences for maximum visibility.
            </div>
          </div>
        </div>
      </section>

      {/* Display Upcoming Conferences */}
      <section className="upcoming-conferences">
        <h2>Upcoming Conferences</h2>
        <div className="conference-images">
          {allConferences.map((conference) => (
            <div
              key={conference.id}
              className="conference-image"
              onClick={() => handleConferenceClick(conference.id)}
            >
              <img
                src={`${backendUrlImages}${conference.image}`}
                alt={conference.title}
                className="conference-thumbnail"
              />
            </div>
          ))}
        </div>
      </section>

      <Footer />
    </div>
  );
};

export default Home;
