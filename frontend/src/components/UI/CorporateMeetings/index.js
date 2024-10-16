import React from 'react';
import './style.scss'; // ملف الأنماط

const CorporateMeetings = () => {
    return (
        <div className="corporate-meetings-container">
            {/* قسم الصورة العلوية */}
            <div className="headline-picture">
                <h1 className="headline-title">Corporate Meetings</h1>
            </div>
            
            {/* نص المحتوى */}
            <div className="corporate-meetings-content">
                <p>
                    Conferences have traditionally provided opportunities for networking, socializing, and hearing the latest 
                    management speak. But they have rarely been exploited to their full potential as a forum for creative 
                    problem solving and for mobilizing delegates into meaningful action. Events consultant will give advice and 
                    assistance on how to achieve this. The stage setting for any conference is critical to the reception of the 
                    message. Set design, lighting, quality of sound, and projection all contribute to communication.
                </p>
                <p>
                    Our very skilled staff carefully provides for all phases of a conference, such as planning, preparation, 
                    and management. Our knowledge, based on years of experience in the field of events management, allows us 
                    to use the resources at our disposal in the best way possible to obtain successful results for our Clients.
                </p>
                <p>
                    Formulation of a budget, management of all preparations, multilingual assistance, translations, technical, 
                    and audio-visual support are some of the services that we supply to meet in an efficient way all types of 
                    requirements.
                </p>
            </div>
        </div>
    );
};

export default CorporateMeetings;
