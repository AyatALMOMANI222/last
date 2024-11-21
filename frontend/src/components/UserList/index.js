import React, { useEffect, useState } from "react";
import axios from "axios";
import Table from "../../CoreComponent/Table";
import "./style.scss";
import AddDiscountForm from "./discountForm";

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [openDiscountForm, setOpenDiscountForm] = useState(false);
  const [userId, setUserId] = useState("");

  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const getAuthToken = () => localStorage.getItem("token");

  const fetchUsers = async () => {
    try {
      const response = await axios({
        method: "GET",
        url: `${BaseUrl}/users`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      });
      console.log({ response });

      // Assuming the response contains an array of users
      setUsers(response.data.data || []); // Make sure to use the correct key from your API response
    } catch (error) {
      console.error("Error fetching users:", error); // Improved error logging
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []); // The empty array ensures this only runs once when the component is mounted.

  useEffect(() => {
    console.log({ users });
  }, [users]); // Debugging state updates

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

      <AddDiscountForm
        isOpen={openDiscountForm}
        setIsOpen={setOpenDiscountForm}
        userId={userId}
      />
    </div>
  );
};

export default UsersList;
