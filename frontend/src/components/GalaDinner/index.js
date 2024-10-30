import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './style.scss'; // Import the Sass file

const DinnerDetails = () => {
    const [dinnerDetail, setDinnerDetail] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchDinnerDetails = async () => {
            const token = localStorage.getItem('token');
            try {
                const response = await axios.get("http://localhost:8000/api/dinners/conference/1", {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                setDinnerDetail(response.data.dinner_detail);
                setLoading(false);
            } catch (error) {
                setError('Error fetching dinner details');
                setLoading(false);
            }
        };

        fetchDinnerDetails();
    }, []);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>{error}</p>;

    return (
        <div className="dinner-details-container">
            <h2 className="dinner-title">Gala Dinner Details</h2>
            <div className="dinner-detail-item">
                <strong>Date:</strong> <span>{new Date(dinnerDetail.dinner_date).toLocaleDateString()}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Restaurant:</strong> <span>{dinnerDetail.restaurant_name}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Location:</strong> <span>{dinnerDetail.location}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Gathering Place:</strong> <span>{dinnerDetail.gathering_place}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Transportation:</strong> <span>{dinnerDetail.transportation_method}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Gathering Time:</strong> <span>{dinnerDetail.gathering_time}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Dinner Time:</strong> <span>{dinnerDetail.dinner_time}</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Duration:</strong> <span> {dinnerDetail.duration} minutes</span>
            </div>
            <div className="dinner-detail-item">
                <strong>Dress Code:</strong> <span>{dinnerDetail.dress_code}</span>
            </div>
        </div>
    );
};

export default DinnerDetails;
