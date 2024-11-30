import { useNavigate } from "react-router-dom";
import "./style.scss";
import React, { useEffect, useState } from "react";
import httpService from "../../common/httpService";
import { backendUrlImages } from "../../constant/config";
import Pagination from "../../CoreComponent/Pagination";

const ConferenceCards = ({ conferences }) => {
  const navigate = useNavigate();

  const handleCardClick = (id) => {
    navigate(`/conference/details/${id}`);
  };

  return (
    <div className="conference-cards-container">
      {conferences.map((conference) => (
        <div
          key={conference.id}
          className="conference-card"
          onClick={() => handleCardClick(conference.id)}
        >
          <div className="conference-card-image">
            {conference.image ? (
              <img
                src={`${backendUrlImages}${conference.image}`}
                alt={conference.title}
              />
            ) : (
              <div className="conference-placeholder">No Image</div>
            )}
          </div>
          <div className="conference-card-details">
            <h3 className="conference-card-title">{conference.title}</h3>
            <p className="conference-card-description">
              {conference.description
                ? conference.description.slice(0, 100) + "..."
                : "No description available"}
            </p>
            <p className="conference-card-dates">
              {new Date(conference.start_date).toLocaleDateString()} -{" "}
              {conference.end_date
                ? new Date(conference.end_date).toLocaleDateString()
                : "TBD"}
            </p>
            <p className="conference-card-location">
              {conference.location || "Location not specified"}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
};

const ConferencesPage = () => {
  const [conferences, setConferences] = useState([]);
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 0,
  });

  // Fetch conferences whenever the currentPage changes
  useEffect(() => {
    httpService({
      method: "GET",
      url: `${process.env.REACT_APP_BASE_URL}/con`,
      params: { page: pagination.currentPage, per_page: 10 },
      onSuccess: (response) => {
        setConferences(response.data || []);
        setPagination({
          currentPage: response?.current_page,
          totalPages: response?.total_pages, // Assuming total_pages exists in the response
        });
      },
      onError: (error) => console.error("Error fetching conferences:", error),
    });
  }, [pagination.currentPage]); // Dependency on currentPage

  const handlePageChange = (page) => {
    setPagination((prev) => ({ ...prev, currentPage: page }));
  };

  return (
    <div className="user-conference-cards-container">
      <ConferenceCards conferences={conferences} />
      <Pagination
        currentPage={pagination.currentPage}
        totalPages={pagination.totalPages}
        onPageChange={handlePageChange}
      />
    </div>
  );
};

export default ConferencesPage;
