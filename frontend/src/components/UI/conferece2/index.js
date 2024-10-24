import React from 'react';
import './style.scss'; // Importing styles

const Conference3 = () => {
    return (
        <div className="conference-containerr">
            {/* Headline picture with title */}
            <div className="headline-picture">
                <h1 className="headline-title">Conferences & Events</h1>
            </div>
            
            {/* Content below the picture */}
            <div className="conference-content">
                <p className="intro-text">
                    Conferences have traditionally provided opportunities for networking, socializing, and hearing the latest management speak. But they have rarely been exploited to their full potential as a forum for creative problem-solving and for mobilizing delegates into meaningful action. Events consultants will give advice and assistance on how to achieve this.
                </p>
                <p>
                    The stage setting for any conference is critical to the reception of the message. Set design, lighting, quality of sound, and projection all contribute to communication.
                </p>
                <p>
                    Our very skilled staff carefully provides for all phases of a conference, such as planning, preparation, and management. Our knowledge, based on years of experience in the field of events management, allows us to use the resources at our disposal in the best way possible to obtain successful results for our Clients.
                </p>
                <p>
                    A strong engagement in public relations, marketing, and promotion (contacting newspapers and journalists, preparing and sending press releases, organizing press conferences, creating websites, designing and producing brochures, fliers, and posters) is mandatory for attracting and keeping participants and guaranteeing the success of the event.
                </p>
            </div>
        </div>
    );
}

export default Conference3;
