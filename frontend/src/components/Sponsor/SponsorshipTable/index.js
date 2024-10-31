import React from "react";

const SponsorshipTable = () => {
  const data = [
    {
      item: "Diamond",
      price: "40.000 USD",
      maxSponsors: 1,
      boothSize: "24 sqm",
      bookletAd: "4 Pages",
      websiteAd: "Home Page Main banner",
      BagsInserts: "Two Brochures / Pen + 3 Flyers/ Promo materials",
      backdropLogo: "Yes",
      nonResidentialReg: 25,
      residentialReg: 5,
    },
    {
      item: "Titanium",
      price: "35.000 USD",
      maxSponsors: 1,
      boothSize: "21 sqm",
      bookletAd: "3 Pages",
      websiteAd: "Home Page",
      BagsInserts: "One Brochure / Pen + 2 Flyers",
      backdropLogo: "Yes",
      nonResidentialReg: 20,
      residentialReg: 4,
    },
    {
      item: "Platinum",
      price: "30.000 USD",
      maxSponsors: 2,
      boothSize: "18 sqm",
      bookletAd: "2 Pages",
      websiteAd: "Registration page",
      BagsInserts: "One Brochure / Pen + 1 Flyer",
      backdropLogo: "Yes",
      nonResidentialReg: 15,
      residentialReg: 3,
    },
    {
      item: "Gold",
      price: "22.500 USD",
      maxSponsors: 3,
      boothSize: "15 sqm",
      bookletAd: "1 Page",
      websiteAd: "Conference Sponsor page",
      BagsInserts: "One Flyer",
      backdropLogo: "Yes",
      nonResidentialReg: 12,
      residentialReg: 1,
    },
    {
      item: "Silver",
      price: "15.000 USD",
      maxSponsors: 4,
      boothSize: "12 sqm",
      bookletAd: "1/2 page",
      websiteAd: "Conference Sponsor page",
      BagsInserts: "One Brochure Pen + 1Flyer",
      backdropLogo: "Yes",
      nonResidentialReg: 8,
      residentialReg: 0,
    },
    {
      item: "Bronze",
      price: "10.000 USD",
      maxSponsors: 6,
      boothSize: "9 sqm",
      bookletAd: "",
      websiteAd: " ",
      BagsInserts: " ",
      backdropLogo: "Yes",
      nonResidentialReg: 4,
      residentialReg: 1,
    },
  ];

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
                <input type="checkbox" />
              </td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Maximum Sponsors per category</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.maxSponsors}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Booth Size</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.boothSize}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Conference Booklet ad</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.bookletAd}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Website Advertisement</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.websiteAd}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Bags Inserts</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.BagsInserts}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Logo on Backdrop (Main Hall)</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.backdropLogo}</td>
            ))}
          </tr>
          <tr style={rowStyleEven}>
            <td style={cellStyle}>Free Non-Residential Registration</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.nonResidentialReg}</td>
            ))}
          </tr>
          <tr style={rowStyleOdd}>
            <td style={cellStyle}>Free Residential Registration PKG SGL Room/4nights</td>
            {data.map((row, index) => (
              <td key={index} style={cellStyle}>{row.residentialReg}</td>
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
