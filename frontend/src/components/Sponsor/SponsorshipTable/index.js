import React, { useEffect, useState } from "react";
import axios from "axios";

const SponsorshipTable = ({ onSelectedSponsorshipsChange }) => {
  const [data, setData] = useState([]);
  const [selectedSponsorshipIds, setSelectedSponsorshipIds] = useState([]); // تم تغيير الاسم هنا
  const handleCheckboxChange = (id) => {
    const updatedIds = selectedSponsorshipIds.includes(id)
      ? selectedSponsorshipIds.filter((prevId) => prevId !== id) // إذا تم إلغاء التحديد
      : [...selectedSponsorshipIds, id]; // إذا تم تحديد ID

    setSelectedSponsorshipIds(updatedIds); // تحديث state المحلية
    onSelectedSponsorshipsChange(updatedIds); // استدعاء دالة الأب لتحديث state
  };
  useEffect(() => {
    const BaseUrl = process.env.REACT_APP_BASE_URL;

    axios
      .get(`${BaseUrl}/sponsorship-options/table/get/1`) // Replace with your API endpoint
      .then((response) => {
        setData(response.data.data);
        console.log(response.data.data);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  }, []);



  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif" }}>
      <h1 style={{ textAlign: "center", color: "#B22222" }}>Sponsorship Packages</h1>
      <table
        style={{
          width: "100%",
          borderCollapse: "collapse",
          boxShadow: "0 4px 8px rgba(0, 0, 0, 0.2)",
          borderRadius: "8px",
          overflow: "hidden",
        }}
      >
        <thead>
          <tr style={{ backgroundColor: "#B22222", color: "#ffffff" }}>
            <th style={headerStyle}>Details</th>
            {data.map((row, index) => (
              <th key={index} style={headerStyle}>
                {row.item}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Total Package Price</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>
                {row.price}
                <br />
                <input
                  type="checkbox"
                  checked={selectedSponsorshipIds.includes(row.id)} // التحقق من إذا كان الـ ID موجودًا في selectedSponsorshipIds
                  onChange={() => handleCheckboxChange(row.id)} // التعامل مع التغيير
                />
              </td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Maximum Sponsors per category</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.max_sponsors}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Booth Size</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.booklet_ad}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Conference Booklet ad</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.booklet_ad}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Website Advertisement</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.website_ad}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Bags Inserts</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.bags_inserts}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Logo on Backdrop (Main Hall)</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.backdrop_logo}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Free Non-Residential Registration</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.non_residential_reg}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Free Residential Registration PKG SGL Room/4nights</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.residential_reg}</td>
            ))}
          </tr>
        </tbody>
      </table>


    </div>
  );
};

const headerStyle = {
  padding: "12px 15px",
  textAlign: "center",
  fontWeight: "bold",
  fontSize: "16px",
};

const cellStyle = {
  padding: "10px 15px",
  textAlign: "center",
  borderBottom: "1px solid #ddd",
  fontSize: "15px",
};

const rowStyleEven = {
  backgroundColor: "#f2f2f2",
};

const rowStyleOdd = {
  backgroundColor: "#fff5f5", // لون أحمر فاتح للخلفية
};

export default SponsorshipTable;
