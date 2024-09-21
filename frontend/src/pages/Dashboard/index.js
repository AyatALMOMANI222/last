import React, { Fragment } from "react";
import "./style.scss";
import DonutChart from "../../components/DonutChart";

const Dashboard = () => {
  return (
    <Fragment>
      <header className="dashboard-header">
        <div className="header">Dashboard</div>
      </header>
      <div className="dashboard-container">
        <DonutChart />
        <div className="dashboard-overview">
          <div className="overview-card">
            <div className="title-card">Total Books</div>
            <div className="overview-value">1,234</div>
            <div className="overview-description">
              Total number of books in the store.
            </div>
          </div>
          <div className="overview-card">
            <div className="title-card">Books Sold</div>
            <div className="overview-value">567</div>
            <div className="overview-description">
              Total books sold this month.
            </div>
          </div>
          <div className="overview-card">
            <div className="title-card">Users</div>
            <div className="overview-value">89</div>
            <div className="overview-description">Total registered users.</div>
          </div>
          <div className="overview-card">
            <div className="title-card">Active Carts</div>
            <div className="overview-value">12</div>
            <div className="overview-description">
              Number of active shopping carts.
            </div>
          </div>
        </div>
      </div>
    </Fragment>
  );
};

export default Dashboard;
