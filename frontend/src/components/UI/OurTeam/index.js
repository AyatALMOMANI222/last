import React from 'react';
import './style.scss';

const OurTeams = () => {
  // مصفوفة تحتوي على معلومات الأعضاء
  const teamMembers = [
    {
      name: 'Mamoun Khraisheh',
      role: 'General Manager',
      image: require('./image/Mamoun4-removebg-preview.png'), // استخدام require للصورة
    },
    {
      name: 'Ameera Abu Saif',
      role: 'Executive Secretary',
      image: require('./image/ameera.png'), // استخدام require للصورة
    },
  
    {
      name: 'Ahmad Hassan',
      role: 'Administration Assistant',
      image: require('./image/ahmad4-removebg-preview.png'), // استخدام require للصورة
    },
    {
      name: 'Mohammad Abu Laila',
      role: 'IT Supervisor',
      image: require('./image/mhammd4-removebg-preview (1).png'), // استخدام require للصورة
    },
    {
      name: 'Dana Al Sabbar',
      role: 'Events Manager',
      image: require('./image/dana4-removebg-preview.png'), // استخدام require للصورة
    },
    {
      name: 'Farah Jamal',
      role: 'Public Relations',
      image: require('./image/farah4-removebg-preview.png'), // استخدام require للصورة
    },
    {
      name: 'Baker Helmi',
      role: 'Designer',
      image: require('./image/baker4-removebg-preview.png'), // استخدام require للصورة
    },
    {
      name: 'Nancy Nehad',
      role: 'Events coordinator',
      image: require('./image/nancy2.jpg'), // استخدام require للصورة
    },
  ];

  return (
    <div className="our-teams-container">
      <div className="background-image">
        <h2 className="team-title">Our Team</h2>
      </div>
      <div className="team-members">
        {teamMembers.map((member, index) => (
          <div className="team-member" key={index}>
            <img src={member.image} alt={member.name} className="member-image" />
            <div className="info-overlay">
              <h3 className="member-name">{member.name}</h3>
              <p className="member-role">{member.role}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default OurTeams;
