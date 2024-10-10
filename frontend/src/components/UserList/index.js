import React, { useEffect, useState } from "react";
import axios from "axios";
import Table from "../../CoreComponent/Table"; // تأكد من تعديل المسار حسب هيكل المجلدات لديك
import "./style.scss";

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await axios.get("http://127.0.0.1:8000/api/users");
        setUsers(response.data.data);
        console.log(response.data.data);
        
        setLoading(false);
      } catch (error) {
        setError("Error fetching user data");
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  const handleAddTrip = (userId) => {
    // هنا يمكنك تنفيذ منطق إضافة الرحلة للمستخدم
    alert(`Add trip for user with ID: ${userId}`);
  };

  // إذا كان لديك بيانات المستخدمين في شكل كائنات، قم بتحديد تنسيقها
  const formattedData = users?.map((user) => ({
    id: user.id, // تأكد من أن لديك id للمستخدم
    name: user.name,
  
    action: (
      <button onClick={() => handleAddTrip(user.id)}>Add Trip</button>
    ),
  }));

  return (
    <div>
      {loading && <p>Loading...</p>}
      {error && <p>{error}</p>}
      {!loading && !error && (
        <Table
          headers={[
            { key: "name", label: "Name" },
        
            { key: "action", label: "Action" },
          ]}
          data={formattedData}
        />
      )}
    </div>
  );
};

export default UsersList;
