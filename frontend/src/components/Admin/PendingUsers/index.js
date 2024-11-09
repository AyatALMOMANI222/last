import React, { useState, useEffect, useCallback } from "react";
import Table from "../../../CoreComponent/Table";
import httpService from "../../../common/httpService";
import Select from "../../../CoreComponent/Select";
import { useNavigate } from "react-router-dom";
import "./style.scss";
import Pagination from "../../../CoreComponent/Pagination";

const PendingUsersTable = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const navigate = useNavigate();
  const [pendingUsers, setPendingUsers] = useState([]);
  const [status, setStatus] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  const statusOptions = [
    { value: "pending", label: "Pending" },
    { value: "approved", label: "Approved" },
    { value: "rejected", label: "Rejected" },
    { value: "all", label: "All" },
  ];

  const getAuthToken = () => localStorage.getItem("token");

  const fetchPendingUsers = useCallback(async () => {
    const url = `${BaseUrl}/users?status=${
      status?.value || "all"
    }&page=${currentPage}`;

    try {
      const response = await httpService({
        method: "GET",
        url,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
      });

      const usersWithActions = response?.data?.map((user) => ({
        ...user,
        actions: (
          <button
            className={`submit-btn ${user?.status !== "pending" && "disabled-btn"} `}
            onClick={() => {
              if (user?.registration_type === "speaker") {
                navigate(
                  `/edit/speaker/data/${user.conferences?.[0]?.id}/${user.id}`
                );
              } else if (user?.registration_type === "attendance") {
                navigate(
                  `/edit/attendance/data/${user.conferences?.[0]?.id}/${user.id}`
                );
              }
            }}
            disabled={user?.status !== "pending"}
          >
            Submit
          </button>
        ),
      }));

      setPendingUsers(usersWithActions);
      setTotalPages(response.pagination?.total_pages);
      setCurrentPage(response.pagination?.current_page);
    } catch (err) {}
  }, [status, currentPage, navigate]);

  useEffect(() => {
    fetchPendingUsers();
  }, [fetchPendingUsers]);

  const headers = [
    { key: "name", label: "Name" },
    { key: "email", label: "Email" },
    { key: "phone_number", label: "Phone Number" },
    { key: "whatsapp_number", label: "WhatsApp Number" },
    { key: "specialization", label: "Specialization" },
    { key: "country_of_residence", label: "Country of Residence" },
    { key: "status", label: "Status" },
    { key: "actions", label: "Actions" },
  ];

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  return (
    <div className="pending-users-container">
      <h2>All Users</h2>
      <Select
        options={statusOptions}
        value={status}
        setValue={setStatus}
        label="Visa Status"
      />
      <Table headers={headers} data={pendingUsers} />
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />
    </div>
  );
};

export default PendingUsersTable;