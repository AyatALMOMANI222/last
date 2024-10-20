import React from 'react';
import './style.scss'; // لاستيراد التصميم

const Workshops = () => {
    return (
        <div className="workshops-container">
            {/* Headline section */}
            <div className="headline-section">
                <div className="overlay">
                    <h1 className="title">Workshops & Conferences</h1>
                </div>
            </div>
            
            {/* Content section below the picture */}
            <div className="content-section">
                <h2 className="subtitle">Welcome to Our Workshops</h2>
                <p className="description">
                    Conferences have traditionally provided opportunities for networking, socializing, and hearing the latest management ideas. However, they are often underutilized for creative problem-solving and mobilizing meaningful action.
                </p>
                <p className="description">
                    Our event consultants offer advice on how to make conferences more productive and engaging. From stage design, lighting, sound, and projection, we ensure the message is communicated effectively. We manage all aspects of the event: planning, preparation, and execution, to create impactful experiences.
                </p>
                <p className="description">
                    With years of experience, our team uses the best resources to achieve successful results. Services include budgeting, multilingual assistance, translations, technical, and audio-visual support, tailored to meet client needs efficiently.
                </p>
            </div>
        </div>
    );
};

export default Workshops;
