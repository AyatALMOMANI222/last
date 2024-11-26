import React, { useEffect, useState } from "react";
import axios from "axios";
import "./style.scss";

const InvoicesS = () => {
  const [invoices, setInvoices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1); // الصفحة الحالية
  const [totalPages, setTotalPages] = useState(1); // العدد الإجمالي للصفحات
  const [perPage, setPerPage] = useState(10); // عدد النتائج لكل صفحة
  const [selectedInvoice, setSelectedInvoice] = useState(null); // الفاتورة المحددة لعرض تفاصيلها

  const token = localStorage.getItem("token"); // الحصول على التوكن من التخزين المحلي

  const fetchInvoices = (page) => {
    setLoading(true);
    axios
      .get(`http://127.0.0.1:8000/api/invoice?page=${page}&per_page=${perPage}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setInvoices(response.data.invoices.data); // بيانات الفواتير
        setTotalPages(response.data.invoices.last_page); // العدد الإجمالي للصفحات
        setCurrentPage(response.data.invoices.current_page); // الصفحة الحالية
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching invoices:", error);
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchInvoices(currentPage);
  }, [currentPage, perPage]);

  const handlePageChange = (page) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  const handleViewDetails = (invoice) => {
    setSelectedInvoice(invoice); // تعيين الفاتورة المحددة
  };

  const closeModal = () => {
    setSelectedInvoice(null); // إغلاق التفاصيل
  };

  if (loading) {
    return <div className="loader">Loading...</div>;
  }

  return (
    <div className="invoice-container">
      <h1 className="title">Sponsor Invoices</h1>
      {invoices.length > 0 ? (
        <>
          {/* عرض الفواتير في جدول */}
          <table className="invoice-table">
            <thead>
              <tr>
                {/* <th>Invoice #</th> */}
                <th>User</th>
                <th>Conference</th>
                <th>Total Amount</th>
                <th>Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              {invoices.map((invoice) => (
                <tr key={invoice.invoice_id}>
                  {/* <td>{invoice.id}</td> */}
                  <td>{invoice.user_name}</td>
                  <td>{invoice.conference_title}</td>
                  <td>${invoice.total_amount}</td>
                  <td>{new Date(invoice.created_at).toLocaleDateString()}</td>
                  <td>
                    <button
                      className="view-btn"
                      onClick={() => handleViewDetails(invoice)}
                    >
                      View
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>

          {/* عرض التفاصيل عند النقر على View */}
          {selectedInvoice && (
  <div className="invoice-modal">
    <div className="modal-content">
      {/* عرض تفاصيل الفاتورة */}
      <p>
        <strong>User:</strong> {selectedInvoice.user_name}
      </p>
      <p>
        <strong>Conference:</strong> {selectedInvoice.conference_title}
      </p>
      <p>
        <strong>Total Amount:</strong> ${selectedInvoice.total_amount}
      </p>
      <p>
        <strong>Date:</strong>{" "}
        {new Date(selectedInvoice.created_at).toLocaleDateString()}
      </p>

      {/* عرض exhibit_number فقط إذا كانت موجودة */}
      {selectedInvoice.exhibit_number && (
        <p>
          <strong>Exhibit Number:</strong> {selectedInvoice.exhibit_number}
        </p>
      )}

      {/* عرض تفاصيل الرعاية إذا كانت موجودة */}
      {selectedInvoice.conference_sponsorship_details.length > 0 && (
        <>
          <h3>Sponsorship Details:</h3>
          <ul className="details-list">
            {selectedInvoice.conference_sponsorship_details.map((item, index) => (
              <li key={index}>
                {item.item} - ${item.price}
              </li>
            ))}
          </ul>
        </>
      )}

      {/* عرض تفاصيل تكلفة الأكشاك إذا كانت موجودة */}
      {selectedInvoice.booth_cost_details.length > 0 && (
        <>
          <h3>Booth Cost Details:</h3>
          <ul className="details-list">
            {selectedInvoice.booth_cost_details.map((booth, index) => (
              <li key={index}>
                Size: {booth.size} - Cost: ${booth.cost}
              </li>
            ))}
          </ul>
        </>
      )}

      {/* عرض خيارات الرعاية إذا كانت موجودة */}
      {selectedInvoice.sponsorship_option_details.length > 0 && (
        <>
          <h3>Sponsorship Options:</h3>
          <ul className="details-list">
            {selectedInvoice.sponsorship_option_details.map((option, index) => (
              <li key={index}>
                {option.title} - ${option.price}
              </li>
            ))}
          </ul>
        </>
      )}

      <button className="close-btn" onClick={closeModal}>
        Close
      </button>
    </div>
  </div>
)}


          {/* أزرار التنقل بين الصفحات */}
          <div className="pagination">
            <button
              disabled={currentPage === 1}
              onClick={() => handlePageChange(currentPage - 1)}
            >
              Previous
            </button>
            {Array.from({ length: totalPages }, (_, index) => (
              <button
                key={index + 1}
                className={currentPage === index + 1 ? "active" : ""}
                onClick={() => handlePageChange(index + 1)}
              >
                {index + 1}
              </button>
            ))}
            <button
              disabled={currentPage === totalPages}
              onClick={() => handlePageChange(currentPage + 1)}
            >
              Next
            </button>
          </div>

          {/* تحديد عدد العناصر لكل صفحة */}
          <div className="per-page-selector">
            <label htmlFor="perPage">Results per page:</label>
            <select
              id="perPage"
              value={perPage}
              onChange={(e) => setPerPage(Number(e.target.value))}
            >
              <option value={5}>5</option>
              <option value={10}>10</option>
              <option value={20}>20</option>
            </select>
          </div>
        </>
      ) : (
        <p>No invoices found.</p>
      )}
    </div>
  );
};

export default InvoicesS;
