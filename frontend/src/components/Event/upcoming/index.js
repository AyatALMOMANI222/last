import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './style.scss';
import Card from '../../CardEvent';
import { backendUrlImages } from '../../../constant/config';

const UpcomingConferences2 = () => {
  const [conferences, setConferences] = useState([]);
  const [loading, setLoading] = useState(true);
  const BaseUrl = 'http://127.0.0.1:8000/api';

  useEffect(() => {
    const fetchConferences = async () => {
      const token = localStorage.getItem('token');
      try {
        const response = await axios.get(`${BaseUrl}/con/upcoming`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setConferences(response.data.upcoming_conferences);
        console.log(response.data.upcoming_conferences);
      } catch (error) {
        console.error('Error fetching conferences:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchConferences();
  }, []);

  if (loading) return <p>Loading conferences...</p>;

  return (
    <div className="upcoming-conferences-container">
      <h2 className="section-title">Upcoming Event</h2>
      <div className="card-container">
        {conferences.map((conference) => (
          <Card
            key={conference.id}
            // src={`${backendUrlImages}${conference.imageUrl}`}
            imageUrl={`${backendUrlImages}${conference?.image}`} 

            title={conference.title}
            description={conference.description}
            // seeMoreLink={`/conference/${conference.id}`}
            seeMoreLink={"https://www.eventscons.com/4th-diet-nutrition-expo-2015/"}
            galleryLink={conference.galleryLink}
            buttonText="Read More"
            galleryButtonText="Explore Gallery"
          />
        ))}
      </div>
    </div>
  );
};

export default UpcomingConferences2;
