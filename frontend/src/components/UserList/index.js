import React, { useEffect, useState } from "react";
import axios from "axios";
import Table from "../../CoreComponent/Table";
import "./style.scss";
import AddDiscountForm from "./discountForm";
import Pagination from "../../CoreComponent/Pagination";

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [openDiscountForm, setOpenDiscountForm] = useState(false);
  const [userId, setUserId] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [status, setStatus] = useState("all"); // Track status filter

  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const getAuthToken = () => localStorage.getItem("token");

  const fetchUsers = async () => {
    try {
      const response = await axios.get(`${BaseUrl}/users`, {
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        params: { page: currentPage },
      });

      console.log({ response });

      setTotalPages(response.data.pagination.total_pages);
      setUsers(response.data.data || []);
    } catch (error) {
      console.error("Error fetching users:", error);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, [currentPage]);

  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  const formattedData = users.map((user) => ({
    id: user.id,
    name: user.name,
    email: user.email,
    action: (
      <button
        onClick={() => {
          setOpenDiscountForm(true);
          setUserId(user.id);
        }}
        className="link-button"
      >
        Add Discount
      </button>
    ),
  }));

  return (
    <div className="all-users-table">
      <Table
        headers={[
          { key: "name", label: "Name" },
          { key: "email", label: "Email" },
          { key: "action", label: "Action" },
        ]}
        data={formattedData}
      />
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={handlePageChange}
      />
      <AddDiscountForm
        isOpen={openDiscountForm}
        setIsOpen={setOpenDiscountForm}
        userId={userId}
      />
    </div>
  );
};

export default UsersList;
