import React from 'react';
import './style.scss'; // لاستيراد التصميم

const Workshops = () => {
    return (
        <div className="workshops-container">
            {/* Headline picture with title */}
            <div className="headline-picture">
                <h1 className="headline-title">Workshops & Conferences</h1>
            </div>
            
            {/* Content below the picture */}
            <div className="workshops-content">
                <p className="intro-text">
                    Conferences have traditionally provided opportunities for networking, socializing, and hearing the latest management ideas. However, they are often underutilized for creative problem-solving and mobilizing meaningful action.
                </p>
                <p>
                    Our event consultants offer advice on how to make conferences more productive and engaging. From stage design, lighting, sound, and projection, we ensure the message is communicated effectively. We manage all aspects of the event: planning, preparation, and execution, to create impactful experiences.
                </p>
                <p>
                    With years of experience, our team uses the best resources to achieve successful results. Services include budgeting, multilingual assistance, translations, technical, and audio-visual support, tailored to meet client needs efficiently.
                </p>
            </div>
        </div>
    );
};

export default Workshops;
