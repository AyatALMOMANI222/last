import React, { useEffect, useState } from "react";
import axios from "axios";
import Table from "../../CoreComponent/Table"; // تأكد من تعديل المسار حسب هيكل المجلدات لديك
import "./style.scss";
import AddDiscountForm from "./discountForm";

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [openDiscountForm, setOpenDiscountForm] = useState(false);
  const [userId, setUserId] = useState("");
  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/api/users");
        setUsers(response.data.data);
      } catch (error) {}
    };

    fetchUsers();
  }, []);

  const formattedData = users?.map((user) => ({
    id: user.id,
    name: user.name,
    email: user.email,

    action: (
      <button
        onClick={() => {
          setOpenDiscountForm(true);

          setUserId(user?.id);
        }}
      >
        Add Discount
      </button>
    ),
  }));

  return (
    <div className="all-users-table">
      <div className="">
        <Table
          headers={[
            { key: "name", label: "Name" },
            { key: "email", label: "Email" },
            { key: "action", label: "Action" },
          ]}
          data={formattedData}
        />
      </div>

      <AddDiscountForm
        isOpen={openDiscountForm}
        setIsOpen={setOpenDiscountForm}
        userId={userId}
      />
    </div>
  );
};

export default UsersList;
