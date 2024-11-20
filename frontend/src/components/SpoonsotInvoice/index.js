import React, { useEffect, useState } from "react";
import axios from "axios";
import "./style.scss";

const SponsorInvoice = () => {
  const [invoiceData, setInvoiceData] = useState(null);
  const [loading, setLoading] = useState(true);

  // Fetch the token from localStorage
  const getAuthToken = () => localStorage.getItem("token");

  useEffect(() => {
    // Fetch invoice data using axios
    axios
      .get("http://127.0.0.1:8000/api/invoice/1", {
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      })
      .then((response) => {
        setInvoiceData(response.data.invoices[0]);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching invoice data:", error);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return (
    <div className="invoiceContainerS">
      <h1 className="invoiceTitle">Invoice</h1>
      <div className="invoiceDetails">
        {invoiceData && (
          <>
            <div className="row">
              <span className="label">Exhibit Number:</span>
              <span className="value">{invoiceData?.exhibit_number}</span>
            </div>
            <div className="row">
              <span className="label">User Name:</span>
              <span className="value">{invoiceData?.user_name}</span>
            </div>
            <div className="row">
              <span className="label">Total Amount:</span>
              <span className="value">{invoiceData?.total_amount}</span>
            </div>
            {/* <div className="row">
              <span className="label">Conference ID:</span>
              <span className="value">{invoiceData?.conference_id}</span>
            </div> */}
            
            {/* Booth Costs */}
            <div className="section">
              <h2>Booth Costs</h2>
              {invoiceData?.booth_costs && invoiceData?.booth_costs.map((booth, index) => (
                <div key={index} className="row">
                  <span className="label">Booth {index + 1} Cost:</span>
                  <span className="value">{booth?.cost}</span>
                </div>
              ))}
            </div>

            {/* Sponsorship Options */}
            <div className="section">
              <h2>Sponsorship Options</h2>
              {invoiceData?.sponsorship_options && invoiceData?.sponsorship_options.map((option, index) => (
                <div key={index} className="row">
                  <span className="label">{option?.title}:</span>
                  <span className="value">{option?.price}</span>
                </div>
              ))}
            </div>

            {/* Sponsorships */}
            <div className="section">
              <h2>Sponsorships</h2>
              {invoiceData?.sponsorships && invoiceData?.sponsorships.map((sponsorship, index) => (
                <div key={index} className="row">
                  <span className="label">{sponsorship?.item}:</span>
                  <span className="value">{sponsorship?.price}</span>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    </div>
  );
};

export default SponsorInvoice;
