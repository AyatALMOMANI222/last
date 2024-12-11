import React, { useEffect, useState, Fragment } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import Pagination from "../../CoreComponent/Pagination";
import httpService from "../../common/httpService";
import { backendUrlImages } from "../../constant/config";
import { useNavigate } from "react-router-dom";
import "./style.scss";

const ExhibitionsPage = () => {
  // States
  const navigate = useNavigate();
  const [exhibitions, setExhibitions] = useState([]);
  const [filters, setFilters] = useState({ name: "", status: "", page: 1 });
  const [pagination, setPagination] = useState({
    currentPage: 1,
    totalPages: 0,
  });
  const [error, setError] = useState(null);

  // Base URL
  const BASE_URL = process.env.REACT_APP_BASE_URL;

  // Fetch exhibitions
  const fetchExhibitions = async () => {
    try {
      const { data } = await httpService({
        method: "GET",
        url: `${BASE_URL}/exhibitions`,
        params: {
          search: filters.name,
          status: filters.status,
          page: filters.page,
        },
      });
      setExhibitions(data);
      console.log(exhibitions);

      setPagination({
        currentPage: filters.page,
        totalPages: data.total_pages,
      });
      setError(null);
    } catch (err) {
      console.error("Failed to fetch exhibitions:", err);
      setError("Unable to load exhibitions. Please try again later.");
    }
  };

  // Effect to trigger data fetching on filters change
  useEffect(() => {
    fetchExhibitions();
  }, [filters]);

  // Handlers
  const handleFilterChange = (field, value) => {
    setFilters((prevFilters) => ({ ...prevFilters, [field]: value }));
  };

  return (
    <div className="user-exhibition-cards-container">
      <div className="">
        <header className="exhibitions-header">
          <div className="filter-section">
            <Input
              placeholder="Search"
              inputValue={filters.name}
              setInputValue={(value) => handleFilterChange("name", value)}
              label="Exhibition Name"
            />
            {/* <Select
              options={[
                { value: "upcoming", label: "Upcoming" },
                { value: "past", label: "Past" },
              ]}
              value={filters.status}
              setValue={(value) => handleFilterChange("status", value)}
              label="Status"
            /> */}
          </div>
        </header>
        {error ? (
          <p className="error-message">{error}</p>
        ) : exhibitions.length ? (
          <div className="exhibition-cards-container">
            {exhibitions.map(
              ({ id, title, location, description, image, conference_id }) => (
                <div key={id} className="exhibition-card">
                  <div className="exhibition-card-image">
                    {image ? (
                      <img src={`${backendUrlImages}${image}`} alt={title} />
                    ) : (
                      <div className="exhibition-placeholder">No Image</div>
                    )}
                  </div>
                  <div className="exhibition-card-details">
                    <h3 className="exhibition-card-title">{title}</h3>
                    <p className="exhibition-card-description">{description}</p>
                    <p className="exhibition-card-location">{location}</p>
                  </div>
                  <div className="two-btn">
                    <button className="btn"
                      onClick={() => {
                        navigate(`/one/exhibits/${id}`);
                      }}
                    >
                      View Gallery
                    </button>
                    <button className="btn"
                      onClick={() => {
                        navigate(`/register/sponsor/${conference_id}`);
                      }}
                    >
                      Join as Sponsor
                    </button>
                  </div>
                </div>
              )
            )}
          </div>
        ) : (
          <p className="no-data">No exhibitions available.</p>
        )}
      </div>

      {/* Pagination */}
      <Pagination
        currentPage={pagination.currentPage}
        totalPages={pagination.totalPages}
        onPageChange={(page) => handleFilterChange("page", page)}
      />
    </div>
  );
};

export default ExhibitionsPage;
