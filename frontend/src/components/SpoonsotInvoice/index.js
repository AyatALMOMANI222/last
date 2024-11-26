import React, { useEffect, useState } from "react";
import axios from "axios";
import "./style.scss";
import { useAuth } from "../../common/AuthContext";

const SponsorInvoice = () => {
  const [invoiceData, setInvoiceData] = useState(null);
  const [loading, setLoading] = useState(true);
  const { myConferenceId } = useAuth();

  // Fetch the token from localStorage
  const getAuthToken = () => localStorage.getItem("token");

  const getInvoice = () => {
    axios
      .get(`http://127.0.0.1:8000/api/invoice/${myConferenceId}`, {
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      })
      .then((response) => {
        setInvoiceData(response.data.invoices[0]);
        setLoading(false);
      })
      .catch((error) => {
        setLoading(false);
        console.error("Error fetching invoice data:", error);
      });
  };

  useEffect(() => {
    getInvoice();
  }, [myConferenceId]);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return (
    <div className="invoiceContainerS">
      <h1 className="invoiceTitle">Invoice Details</h1>
      <div className="invoiceDetails">
        {invoiceData && (
          <>
            {/* General Information */}
            <div className="section general-info">
              <h2>General Information</h2>
              <div className="row">
                <span className="label">Exhibit Number:</span>
                <span className="value">{invoiceData.exhibit_number || "N/A"}</span>
              </div>
              <div className="row">
                <span className="label">User Name:</span>
                <span className="value">{invoiceData.user_name}</span>
              </div>
              <div className="row">
                <span className="label">Total Amount:</span>
                <span className="value">${invoiceData.total_amount}</span>
              </div>
              <div className="row">
                <span className="label">Created At:</span>
                <span className="value">{new Date(invoiceData.created_at).toLocaleDateString()}</span>
              </div>
            </div>

            {/* Conference Sponsorship Details */}
            <div className="section sponsorship-details">
              <h2>Conference Sponsorship Details</h2>
              {invoiceData.conference_sponsorship_details.length > 0 ? (
                invoiceData.conference_sponsorship_details.map((item, index) => (
                  <div key={index} className="row">
                    <span className="label">{item.item}:</span>
                    <span className="value">${item.price}</span>
                  </div>
                ))
              ) : (
                <p>No conference sponsorship details available.</p>
              )}
            </div>

            {/* Booth Cost Details */}
            <div className="section booth-details">
              <h2>Booth Cost Details</h2>
              {invoiceData.booth_cost_details.length > 0 ? (
                invoiceData.booth_cost_details.map((booth, index) => (
                  <div key={index} className="row">
                    <span className="label">Size:</span>
                    <span className="value">{booth.size}</span>
                    <span className="label">Cost:</span>
                    <span className="value">${booth.cost}</span>
                  </div>
                ))
              ) : (
                <p>No booth cost details available.</p>
              )}
            </div>

            {/* Sponsorship Option Details */}
            <div className="section sponsorship-options">
              <h2>Sponsorship Option Details</h2>
              {invoiceData.sponsorship_option_details.length > 0 ? (
                invoiceData.sponsorship_option_details.map((option, index) => (
                  <div key={index} className="row">
                    <span className="label">{option.title}:</span>
                    <span className="value">${option.price}</span>
                  </div>
                ))
              ) : (
                <p>No sponsorship options available.</p>
              )}
            </div>
          </>
        )}
      </div>
    </div>
  );
};

export default SponsorInvoice;
