import React, { useEffect, useState } from 'react';
import axios from 'axios';
import "./style.scss"
const ActiveRegistrations = () => {
  const [registrations, setRegistrations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [pagination, setPagination] = useState({
    currentPage: 1,
    perPage: 15,
    total: 0,
    lastPage: 1,
  });
  const token=localStorage.getItem("token")

  // Fetch active registrations from the API
  const fetchRegistrations = async (page = 1) => {
    const token=localStorage.getItem("token")

    setLoading(true);
    setError(null);
    try {
        const response = await axios.get(
          `http://127.0.0.1:8000/api/admin/all/excel/`,
          {
            params: { per_page: pagination.perPage, page },
            headers: { Authorization: `Bearer ${token}` },
          }
        );

      const { data } = response.data.registrations;
      const { current_page, last_page, total, per_page } =
        response.data.registrations;

      setRegistrations(data);
      setPagination({
        currentPage: current_page,
        lastPage: last_page,
        total,
        perPage: per_page,
      });
    } catch (err) {
      setError('An error occurred while fetching data.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchRegistrations();
  }, []);

  // Handle page change
  const handlePageChange = (page) => {
    fetchRegistrations(page);
  };

  return (
    <div className="container">
      <h1>Active Registrations</h1>
      {loading && <p>Loading...</p>}
      {error && <p className="error">{error}</p>}

      {!loading && !error && (
        <>
          <table className="table">
            <thead>
              <tr>
                {/* <th>User Name</th> */}
                <th>User Email</th>
                <th>User Phone</th>
                <th>Organization Name</th>
                <th>Contact Person</th>
                {/* <th>Contact Email</th> */}
                {/* <th>Contact Phone</th> */}
                <th>Number of Doctors</th>
                <th>Excel File</th>
                <th>Update Deadline</th>
              </tr>
            </thead>
            <tbody>
              {registrations.map((registration, index) => (
                <tr key={index}>
                  {/* <td>{registration.user_name || 'N/A'}</td> */}
                  <td>{registration.user_email || 'N/A'}</td>
                  <td>{registration.contact_phone || 'N/A'}</td>
                  <td>{registration.organization_name || 'N/A'}</td>
                  <td>{registration.contact_person || 'N/A'}</td>
                  {/* <td>{registration.email || 'N/A'}</td> */}
                  {/* <td>{registration.contact_phone || 'N/A'}</td> */}
                  <td>{registration.number_of_doctors || 'N/A'}</td>
                  <td>
                  <a href={`http://127.0.0.1:8000/storage/${registration.excel_file}`} target="_blank" rel="noopener noreferrer">
    Download
  </a>
                  </td>
                  <td>{registration.update_deadline || 'N/A'}</td>
                </tr>
              ))}
            </tbody>
          </table>

          {/* Pagination Controls */}
          <div className="pagination">
            <button
              disabled={pagination.currentPage === 1}
              onClick={() => handlePageChange(pagination.currentPage - 1)}
            >
              Previous
            </button>
            <span>
              Page {pagination.currentPage} of {pagination.lastPage}
            </span>
            <button
              disabled={pagination.currentPage === pagination.lastPage}
              onClick={() => handlePageChange(pagination.currentPage + 1)}
            >
              Next
            </button>
          </div>
        </>
      )}
    </div>
  );
};

export default ActiveRegistrations;
