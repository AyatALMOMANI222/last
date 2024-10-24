import React from "react";
import { Row, Col, Card, Table } from "antd";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
} from "recharts";
import "./style.scss";

const Dashboard = () => {
  const conferenceData = [
    {
      id: 1,
      title: "Tech Conference 2024",
      location: "New York",
      attendees: 300,
      price: 150,
    },
    {
      id: 2,
      title: "AI Summit 2024",
      location: "San Francisco",
      attendees: 450,
      price: 200,
    },
    {
      id: 3,
      title: "Web Dev Expo 2024",
      location: "Los Angeles",
      attendees: 275,
      price: 120,
    },
    {
      id: 4,
      title: "Web Dev Expo 2024",
      location: "Los Angeles",
      attendees: 275,
      price: 120,
    },
    {
      id: 5,
      title: "Web Dev Expo 2024",
      location: "Los Angeles",
      attendees: 275,
      price: 120,
    },
  ];

  const barData = conferenceData.map((conference) => ({
    title: conference.title,
    attendees: conference.attendees,
  }));

  const pieData = conferenceData.map((conference) => ({
    title: conference.title,
    price: conference.price,
  }));

  const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042", "red"];

  const columns = [
    { title: "Title", dataIndex: "title", key: "title" },
    { title: "Location", dataIndex: "location", key: "location" },
    { title: "Attendees", dataIndex: "attendees", key: "attendees" },
    { title: "Price ($)", dataIndex: "price", key: "price" },
  ];

  return (
    <div className="dashboard">
      <div className="container-charts">
        <div className="BarChart-container">
          <ResponsiveContainer width="100%" height={300}>
            <BarChart data={barData}>
              <XAxis dataKey="title" />
              <YAxis />
              <Tooltip />
              <Bar dataKey="attendees" fill="#8884d8" />
            </BarChart>
          </ResponsiveContainer>
        </div>
        <div className="PieChart-container">
          {" "}
          <ResponsiveContainer width="100%" height={300}>
            <PieChart>
              <Pie
                data={pieData}
                dataKey="price"
                nameKey="title"
                cx="50%"
                cy="50%"
                outerRadius={100}
                fill="#fff"
              >
                {pieData.map((entry, index) => (
                  <Cell
                    key={`cell-${index}`}
                    fill={COLORS[index % COLORS.length]}
                  />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>
      </div>
      <div>
        <Table
          columns={columns}
          dataSource={conferenceData}
          pagination={false}
          rowKey="id"
        />
      </div>
    </div>
  );
};

export default Dashboard;
