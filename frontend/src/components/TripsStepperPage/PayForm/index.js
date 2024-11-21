import React, { useState, useEffect } from "react";
import { toast } from "react-toastify";
import httpService from "../../../common/httpService";
import { getFromLocalStorage } from "../../../common/localStorage";
import SimpleLabelValue from "../../SimpleLabelValue";
import "./style.scss";
const PayForm = () => {
  const [invoices, setInvoices] = useState([]);
  const [loading, setLoading] = useState(false);
  const invoiceIds = getFromLocalStorage("invoiceIds") || [];

  const fetchInvoices = async () => {
    setLoading(true);
    const getAuthToken = () => localStorage.getItem("token");

    try {
      const responses = await Promise.all(
        invoiceIds.map((id) =>
          httpService({
            method: "GET",
            url: `http://127.0.0.1:8000/api/invoice/trip/${id}`,
            headers: { Authorization: `Bearer ${getAuthToken()}` },
            showLoader: true,
            withToast: true,
          })
        )
      );

      const invoiceData = responses.map((response) => response.data || []);
      setInvoices(invoiceData);
    } catch (error) {
      console.error("Error fetching invoices:", error);
      toast.error("Failed to load invoices.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchInvoices();
  }, []);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  return (
    <div className="pay-form-container">
      {invoices?.length > 0 ? (
        <ul className="invoice-list">
          {invoices.map((invoiceList, invoiceIndex) =>
            invoiceList?.map((invoice) => (
              <li key={invoice.id} className="invoice-item">
                <h3 className="invoice-title">
                  Invoice {invoiceIds[invoiceIndex]}
                </h3>
                <div className="lessta">
                  <SimpleLabelValue
                    label="Base Price"
                    value={invoice.base_price}
                    className="invoice-detail"
                  />
                  <SimpleLabelValue
                    label="Options Price"
                    value={invoice.options_price}
                    className="invoice-detail"
                  />
                  <SimpleLabelValue
                    label="Total Price"
                    value={invoice.total_price}
                    className="invoice-detail"
                  />
                  <SimpleLabelValue
                    label="Status"
                    value={invoice.status}
                    className="invoice-detail"
                  />
                </div>
              </li>
            ))
          )}
        </ul>
      ) : (
        <p>No invoices available.</p>
      )}

      <div className="actions-section">
        <button className="next-button">Pay Now </button>
      </div>
    </div>
  );
};

export default PayForm;
