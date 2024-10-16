import React from 'react';
import './style.scss'; // ملف الأنماط

const ConceptCreation = () => {
    return (
        <div className="concept-creation-container">
            {/* قسم الصورة العلوية */}
            <div className="headline-picture">
                <h1 className="headline-title">Concept Creation</h1>
            </div>
            
            {/* نص المحتوى */}
            <div className="concept-creation-content">
                <p>
                    Setting objectives to creatively design and develop the overall branding and image for the meetings 
                    or events.
                </p>
                <ul>
                    <li>Assisting in setting proper event pricing.</li>
                    <li>Developing sponsorship and exhibition opportunities.</li>
                    <li>Managing the budget and building effective strategic alliances.</li>
                </ul>
            </div>
        </div>
    );
};

export default ConceptCreation;
