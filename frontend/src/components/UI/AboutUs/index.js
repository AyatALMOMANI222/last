import React from "react";
import { useNavigate } from "react-router-dom"; // استيراد useNavigate
import "./style.scss"; // ملف التنسيق

const AboutUsEvent = () => {
  const navigate = useNavigate(); // إنشاء دالة التنقل

  return (
    <div className="about-us-container">
      <div className="about-us-content">
        <h1 className="about-us-title">Our History</h1>
        <section className="who-we-are">
          <p>
            <span className="E">E</span>vent Consultant is a company
            specializing in the preparation, organization, and marketing of
            scientific conferences, exhibitions, workshops, and seminars in
            Jordan. Although newly established, the company boasts a pioneering
            team of professionals with extensive experience in supervising and
            managing various conferences and exhibitions across Jordan.
          </p>
        </section>

        <section className="about-event-consultant">
          <p>
            In response to the rapidly changing market, more companies are
            seeking external expertise from efficient providers who can organize
            and manage prestigious events while offering marketing solutions at
            minimal cost and time.
          </p>
          <p>
            Event Consultant delivers services backed by global expertise to a
            diverse range of clients. From initial site selection through
            on-site management to post-event analysis, Event Consultant ensures
            comprehensive event arrangements and offers innovative solutions. We
            are committed to clear and effective communication, meticulous
            attention to detail, and delivering distinguished features that
            enhance every event.
          </p>
        </section>

        {/* الأزرار */}
        <div className="button-container">
          <button className="custom-button">
            <a
              href="./Company's Profile.pdf" // استبدل 'اسم_الملف.pdf' باسم ملفك
              download 
              className="custom-button" 
            >
            Company Profile
            </a>
          </button>
          <button className="custom-button" onClick={() => navigate("/contact_us")}>
            Contact us
          </button>
        </div>
      </div>
    </div>
  );
};

export default AboutUsEvent;
