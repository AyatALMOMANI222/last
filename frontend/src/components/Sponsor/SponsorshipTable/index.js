import React, { useEffect, useState } from "react";
import axios from "axios";
import { useAuth } from "../../../common/AuthContext";
import "./style.scss";
const SponsorshipTable = ({ onSelectedSponsorshipsChange }) => {
  const { myConferenceId } = useAuth();
  const [data, setData] = useState([]);
  const [selectedSponsorshipIds, setSelectedSponsorshipIds] = useState([]);
  const handleCheckboxChange = (id) => {
    const updatedIds = selectedSponsorshipIds.includes(id)
      ? selectedSponsorshipIds.filter((prevId) => prevId !== id)
      : [...selectedSponsorshipIds, id];

    setSelectedSponsorshipIds(updatedIds);
    onSelectedSponsorshipsChange(updatedIds);
  };
  const getData = () => {
    const BaseUrl = process.env.REACT_APP_BASE_URL;
    if (!myConferenceId) return;
    axios
      .get(`${BaseUrl}/sponsorship-options/table/get/${myConferenceId}`) // Replace with your API endpoint
      .then((response) => {
        setData(response.data.data);
      })
      .catch((error) => {
        console.error("Error fetching data:", error);
      });
  };
  useEffect(() => {
    if (myConferenceId) {
      getData();
    }
  }, [myConferenceId]);
  if (!myConferenceId) {
    return <div>Loading conference data...</div>;
  }
  return (
    <div className="con-sponsorship">
      {data.length > 0 && (
        <div className="header-sponsorship-packages">Sponsorship Packages</div>
      )}
      {data.length > 0 && (
        <div className="tab-con">
        <table className="sponsorship-table">
          <thead>
            <tr>
              <th className="table-header">Details</th>
              {data.map((row, index) => (
                <th key={index}>{row.item}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Total Package Price</td>
              {data.map((row, index) => (
                <td key={index}>
                  {row.price}
                  <br />
                  <input
                    type="checkbox"
                    checked={selectedSponsorshipIds.includes(row.id)}
                    onChange={() => handleCheckboxChange(row.id)}
                  />
                </td>
              ))}
            </tr>
            <tr>
              <td>Maximum Sponsors per category</td>
              {data.map((row, index) => (
                <td key={index}>{row.max_sponsors}</td>
              ))}
            </tr>
            <tr>
              <td>Booth Size</td>
              {data.map((row, index) => (
                <td key={index}>{row.booklet_ad}</td>
              ))}
            </tr>
            <tr>
              <td>Conference Booklet ad</td>
              {data.map((row, index) => (
                <td key={index}>{row.booklet_ad}</td>
              ))}
            </tr>
            <tr>
              <td>Website Advertisement</td>
              {data.map((row, index) => (
                <td key={index}>{row.website_ad}</td>
              ))}
            </tr>
            <tr>
              <td>Bags Inserts</td>
              {data.map((row, index) => (
                <td key={index}>{row.bags_inserts}</td>
              ))}
            </tr>
            <tr>
              <td>Logo on Backdrop (Main Hall)</td>
              {data.map((row, index) => (
                <td key={index}>{row.backdrop_logo}</td>
              ))}
            </tr>
            <tr>
              <td>Free Non-Residential Registration</td>
              {data.map((row, index) => (
                <td key={index}>{row.non_residential_reg}</td>
              ))}
            </tr>
            <tr>
              <td>Free Residential Registration PKG SGL Room/4nights</td>
              {data.map((row, index) => (
                <td key={index}>{row.residential_reg}</td>
              ))}
            </tr>
          </tbody>
        </table>  </div>
      )}
    </div>
  );
};

export default SponsorshipTable;
