import axios from "axios";
import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import "./style.scss";

const OnePage = () => {
  const { conferenceId } = useParams();
  const [conInfo, setConInfo] = useState(null);
  const navigate = useNavigate(); // استخدام navigate للتنقل بين الأقسام

  useEffect(() => {
    axios
      .get(`http://127.0.0.1:8000/api/con/id/${conferenceId}`)
      .then((response) => {
        setConInfo(response.data);
      })
      .catch((error) => {
        console.error("Error fetching conference data:", error);
      });
  }, [conferenceId]);

  if (!conInfo) {
    return <p>Loading conference details...</p>;
  }

  const handleNavigate = (section) => {
    navigate(`#${section}`); // التنقل إلى القسم المطلوب باستخدام id
  };

  return (
    <div className="conference-page">
      {/* قسم القائمة الجانبية */}
      <div className="sidebar">
        <ul>
          <li><button onClick={() => handleNavigate("hero-section")}>Welcome</button></li>
          <li><button onClick={() => handleNavigate("hero-section")}>Home</button></li>
          <li><button onClick={() => handleNavigate("hero-section")}>Committees</button></li>
          <li><button onClick={() => handleNavigate("hero-section")}>Speakers</button></li>
          <li><button onClick={() => handleNavigate("hero-section")}>Abstract</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Scientific Program</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Registration</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Accommodation</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Sponsors</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Contact Us</button></li>
          <li><button onClick={() => handleNavigate("hero-section")}>Main Image</button></li>
          <li><button onClick={() => handleNavigate("details-section")}>Conference Details</button></li>
          <li><button onClick={() => handleNavigate("topics-section")}>Scientific Topics</button></li>
          <li><button onClick={() => handleNavigate("prices-section")}>Prices</button></li>
          <li><button onClick={() => handleNavigate("documents-section")}>Documents</button></li>
        </ul>
      </div>

      {/* قسم الصورة الرئيسية */}
     <div className="second-section">
     <div id="hero-section" className="hero-section">
        <img
          className="hero-image"
          src={conInfo.image_url}
          alt={conInfo.conference?.title || "Conference"}
        />
        <div className="hero-overlay">
          <h1 className="hero-title">{conInfo.conference?.title}</h1>
          <p className="hero-description">{conInfo.conference?.description}</p>
        </div>
      </div>

      {/* قسم تفاصيل المؤتمر */}
      <div id="details-section" className="details-section">
        <div className="container">
          <h2>Conference Details</h2>
          <div className="details-grid">
            <p>
              <strong>Start Date:</strong>{" "}
              {new Date(conInfo.conference?.start_date).toLocaleDateString()}
            </p>
            <p>
              <strong>End Date:</strong>{" "}
              {new Date(conInfo.conference?.end_date).toLocaleDateString()}
            </p>
            <p>
              <strong>Location:</strong> {conInfo.conference?.location}
            </p>
            <p>
              <strong>Organizer:</strong> {conInfo.conference?.organizer}
            </p>
          </div>
        </div>
      </div>

      {/* قسم المواضيع العلمية */}
      {conInfo.scientific_topics && conInfo.scientific_topics.length > 0 && (
        <div id="topics-section" className="topics-section">
          <div className="container">
            <h2>Scientific Topics</h2>
            <ul>
              {conInfo.scientific_topics.map((topic, index) => (
                <li key={index}>
                  <strong>{topic.title}:</strong> {topic.description}
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}

      {/* قسم الأسعار */}
      {conInfo.prices && conInfo.prices.length > 0 && (
        <div id="prices-section" className="prices-section">
          <div className="container">
            <h2>Prices</h2>
            <div className="prices-grid">
              {conInfo.prices.map((price, index) => (
                <div key={index} className="price-item">
                  <p>
                    <strong>{price.price_type}</strong>: ${price.price}
                  </p>
                  <p>{price.description}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* قسم الملفات */}
      <div id="documents-section" className="documents-section">
        <div className="container">
          <h2>Conference Documents</h2>
          <a
            href={conInfo.conference_brochure_pdf_url}
            target="_blank"
            rel="noopener noreferrer"
            className="document-link"
          >
            Download Brochure
          </a>
          <a
            href={conInfo.conference_scientific_program_pdf_url}
            target="_blank"
            rel="noopener noreferrer"
            className="document-link"
          >
            Download Scientific Program
          </a>
        </div>
      </div>
     </div>
    </div>
  );
};

export default OnePage;
