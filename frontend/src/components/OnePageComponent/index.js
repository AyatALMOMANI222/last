import axios from "axios";
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import "./style.scss"; // استيراد ملف SCSS

const OnePage = () => {
  const { conferenceId } = useParams(); // جلب المعرف من الـ URL
  const [conInfo, setConInfo] = useState(null); // تعيين القيمة الافتراضية null بدل {} لتجنب حدوث خطأ

  // دالة لجلب بيانات المؤتمر
  function fetchConferenceData(conferenceId) {
    axios
      .get(`http://127.0.0.1:8000/api/con/id/${conferenceId}`)
      .then((response) => {
        console.log("Conference data:", response.data);
        setConInfo(response.data); // تعيين البيانات للمؤتمر
      })
      .catch((error) => {
        console.error("Error fetching conference data:", error);
      });
  }

  useEffect(() => {
    fetchConferenceData(conferenceId); // جلب البيانات عند تحميل المكون
  }, [conferenceId]);

  // التأكد من وجود conInfo قبل الوصول إلى خصائصه
  if (!conInfo) {
    return <p>Loading conference details...</p>;
  }

  return (
    <div className="conference-container6">
      <div className="conference-details">
        <div className="conference-image">
          <img className="img" src={conInfo.image_url} alt="Conference" />
        </div>
        <h1 className="conference-title">{conInfo.conference?.title}</h1>
        <p className="conference-description">
          {conInfo.conference?.description}
        </p>
        <div className="conference-info">
          <p>
            <strong>Start Date:</strong>{" "}
            {new Date(conInfo.conference?.start_date).toLocaleDateString(
              "en-US",
              { year: "numeric", month: "long", day: "numeric" }
            )}
          </p>
          <p>
            <strong>End Date:</strong>{" "}
            {new Date(conInfo.conference?.end_date).toLocaleDateString(
              "en-US",
              { year: "numeric", month: "long", day: "numeric" }
            )}
          </p>

          <p>
            <strong>Location:</strong> {conInfo.conference?.location}
          </p>
          <p>
            <strong>Organizer:</strong> {conInfo.conference?.organizer}
          </p>
        </div>

        {/* إضافة قسم لعرض المشاركين */}
        {conInfo.conference?.members && conInfo.conference.members.length > 0 && (
          <div className="conference-members">
            <h3>Conference Members</h3>
            {conInfo.conference.members.map((member, index) => (
              <div key={index}>
                <p>
                  <strong>{member.name}</strong> - {member.role}
                </p>
                <p>{member.bio}</p>
              </div>
            ))}
          </div>
        )}

        {/* Example of displaying PDF links */}
        <div className="conference-documents">
          <a
            href={conInfo.conference_brochure_pdf_url}
            target="_blank"
            rel="noopener noreferrer"
          >
            Download Conference Brochure
          </a>
          <a
            href={conInfo.conference_scientific_program_pdf_url}
            target="_blank"
            rel="noopener noreferrer"
          >
            Download Scientific Program
          </a>
        </div>

        {/* Displaying Prices and Scientific Topics */}
        {conInfo.prices && conInfo.prices.length > 0 && (
          <div className="conference-prices">
            <h3>Conference Prices</h3>
            {conInfo.prices.map((price, index) => (
              <div key={index}>
                <p>
                  <strong>{price.price_type}</strong>: ${price.price}
                </p>
                <p>{price.description}</p>
              </div>
            ))}
          </div>
        )}

        {conInfo.scientific_topics && conInfo.scientific_topics.length > 0 && (
          <div className="conference-scientific-topics">
            <h3>Scientific Topics</h3>
            {conInfo.scientific_topics.map((topic, index) => (
              <div key={index}>
                <p>
                  <strong>{topic.title}</strong>
                </p>
                <p>{topic.description}</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default OnePage;
