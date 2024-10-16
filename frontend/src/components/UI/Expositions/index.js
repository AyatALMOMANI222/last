import React from 'react';
import './style.scss'; // للتصميم الخارجي

const Expositions = () => {
    return (
        <div className="expositions-container">
            {/* Section for the headline picture with title */}
            <div className="headline-picture">
                <h1 className="headline-title">Expositions</h1>
            </div>
            
            {/* Text content below the picture */}
            <div className="expositions-content">
                <p>
                    Events consultant is specialized in organizing Medical, Tourism and Scientific Exhibitions. 
                    To prepare and realize successful exhibitions a skillful organizing support is essential.
                </p>
                <p>
                    Our staff offers to associations, ministries, academies, institutions and foundations all the services 
                    which are necessary to organize exhibitions satisfying every standard. We support our clients in the research 
                    and choice of the best locations.
                </p>
                <p>
                    We are experienced in the demanding marketing, promoting and public relations activities and the 
                    creation of typographic material and posters which communicate a strong image.
                </p>
                <p>
                    Events consultant also proposes creative solutions and the best locations for related events such as 
                    workshops, seminars and openings and gala evenings.
                </p>
                <p>
                    We can also include among the options of the event a multimedia room, meeting rooms, bookshop, and 
                    coffee area and cyber locations.
                </p>
            </div>
        </div>
    );
};

export default Expositions;
