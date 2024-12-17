import React, { useEffect, useState } from "react";
import "./style.scss";
import httpService from "../../../common/httpService";
import { toast } from "react-toastify";

const Invoice = () => {
  const [invoices, setInvoices] = useState([]);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  // Fetch flight data from localStorage
  const getFlights = () => {
    const trips = [];
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key.startsWith("Available_Trip_ID_")) {
        const value = localStorage.getItem(key);
        try {
          trips.push(JSON.parse(value));
        } catch {
          console.error("Error parsing localStorage data", value);
        }
      }
    }
    return trips;
  };

  // Fetch invoice data from API
  const getInvoice = async () => {
    const getAuthToken = () => localStorage.getItem("token");
    const flights = getFlights();
    const ids = flights?.map((item) => item?.flight_id);
    try {
      const data = await httpService({
        method: "POST",
        url: `${BaseUrl}/invoice/flight`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          flight_id: ids,
        },
        withToast: true,
        onError: (error) => {
          // toast.error("Failed to submit the form: " + error);
        },
      });
      // console.log(data?.invoices);

      setInvoices(data?.invoices || []);
    } catch (error) {
      // console.error("Error submitting form:", error);
    }
  };

  useEffect(() => {
    getInvoice();
  }, []);

  return (
    <div className="invoice">
      <h2 className="invoice__title">Invoice Details</h2>

      <div className="invoice__list">
        {invoices?.length > 0 ? (
          invoices?.map((invoice) => (
            <div key={invoice?.id} className="invoice__item">
              <div className="invoice__item-header">
                <h3 className="invoice__flight-id">
                  Flight ID: {invoice?.flight_id}
                </h3>
                <span className={`invoice__status ${invoice?.status}`}>
                  {invoice?.status}
                </span>
              </div>
              <div className="invoice__details">
                <p className="invoice__total-price">
                  Total Price: ${invoice?.total_price}
                </p>
                <p className="invoice__date">
                  Created on: {new Date(invoice?.created_at).toLocaleString()}
                </p>
                <p className="invoice__date">
                  Last updated: {new Date(invoice?.updated_at).toLocaleString()}
                </p>
              </div>
            </div>
          ))
        ) : (
          <p className="invoice__no-data">No invoices available.</p>
        )}
      </div>

      <div className="actions-section">
        <button className="next-button">Pay</button>
      </div>
    </div>
  );
};

export default Invoice;
