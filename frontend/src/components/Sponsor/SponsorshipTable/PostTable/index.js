import React, { useState, useEffect } from "react";
import axios from "axios";
import Select from "../../../../CoreComponent/Select";

const SponsorshipTable2 = () => {
  const [formData, setFormData] = useState({
    item: "",
    price: "",
    maxSponsors: "",
    boothSize: "",
    bookletAd: "",
    websiteAd: "",
    BagsInserts: "",
    backdropLogo: "",
    nonResidentialReg: "",
    residentialReg: "",
  });

  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const token = localStorage.getItem("token");
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  // Fetch all conferences
  const getConference = () => {
    const url = `${BaseUrl}/con/upcoming`;

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAllConference(
          response.data.upcoming_conferences?.map((item) => ({
            label: item?.title,
            value: item?.id,
          }))
        );
      })
      .catch((error) => {
        setError("Error fetching conferences");
      });
  };

  useEffect(() => {
    getConference();
  }, []);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handlePostRequest = () => {
    const con = conferenceId.value;
    if (!con) {
      setError("Please select a conference");
      return;
    }
  
    setLoading(true);
    setError(null);
  
    // Preparing data to match the comment structure
    const dataToSend = {
      item: formData.item, // Required: Name of the item (e.g., sponsorship package)
      price: formData.price, // Required: Price of the sponsorship
      max_sponsors: formData.maxSponsors, // Required: Maximum number of sponsors
      booth_size: formData.boothSize, // Required: Booth size (e.g., "10x10")
      booklet_ad: formData.bookletAd || null, // Optional: Advertisement in the booklet (nullable)
      website_ad: formData.websiteAd || null, // Optional: Advertisement on the website (nullable)
      bags_inserts: formData.BagsInserts || null, // Optional: Inserts for sponsor bags (nullable)
      backdrop_logo: formData.backdropLogo || null, // Optional: Logo for the backdrop (nullable)
      non_residential_reg: formData.nonResidentialReg, // Required: Number of non-residential registrations
      residential_reg: formData.residentialReg, // Required: Number of residential registrations
      conference_id: con, // Required: The selected conference ID
    };
  
    axios
      .post(`${BaseUrl}/sponsorship-options/table/add`, dataToSend, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        console.log("Request successful:", response.data);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Request failed:", error);
        setLoading(false);
        setError("Error submitting data");
      });
  };
  

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>Sponsorship Packages</h1>
      {error && <p style={styles.error}>{error}</p>}

      <div style={styles.formContainer}>
        {/* Conference Dropdown */}
        <div style={styles.inputGroup}>
          <Select
            options={allConference}
            value={conferenceId}
            setValue={setConferenceId}
            label="Conference "
            placeholder="Select..."
          />
        </div>

        {/* Sponsorship Form Inputs */}
        {Object.keys(formData).map((key) => (
          <div key={key} style={styles.inputGroup}>
            <label htmlFor={key} style={styles.label}>
              {key
                .replace(/([A-Z])/g, " $1")
                .replace(/^./, (str) => str.toUpperCase())}
              :
            </label>
            <input
              type={
                key.includes("price") ||
                key.includes("Reg") ||
                key.includes("maxSponsors")
                  ? "number"
                  : "text"
              }
              id={key}
              name={key}
              value={formData[key]}
              onChange={handleInputChange}
              style={styles.input}
              placeholder={`Enter ${key
                .replace(/([A-Z])/g, " $1")
                .toLowerCase()}`}
            />
          </div>
        ))}

        <button
          onClick={handlePostRequest}
          style={styles.button}
          disabled={loading}
        >
          {loading ? "Submitting..." : "Submit"}
        </button>
      </div>
    </div>
  );
};

const styles = {
  container: {
    padding: "40px",
    fontFamily: "Arial, sans-serif",
    maxWidth: "600px",
    margin: "auto",
    backgroundColor: "#f9f9f9",
    boxShadow: "0 4px 8px rgba(0, 0, 0, 0.1)",
    borderRadius: "10px",
  },
  title: {
    textAlign: "center",
    color: "#B22222",
    marginBottom: "20px",
    fontSize: "24px",
    fontWeight: "bold",
  },
  formContainer: {
    display: "flex",
    flexDirection: "column",
    gap: "15px",
  },
  inputGroup: {
    display: "flex",
    flexDirection: "column",
  },
  label: {
    fontSize: "14px",
    color: "#333",
    marginBottom: "5px",
    fontWeight: "500",
  },
  input: {
    padding: "10px",
    fontSize: "14px",
    borderRadius: "5px",
    border: "1px solid #ccc",
    backgroundColor: "#fff",
    transition: "border-color 0.2s",
  },
  error: {
    color: "#B22222",
    fontSize: "14px",
    marginBottom: "10px",
  },
  button: {
    padding: "12px 20px",
    backgroundColor: "#B22222",
    color: "#fff",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    fontWeight: "bold",
    fontSize: "16px",
    textAlign: "center",
    transition: "background-color 0.3s",
  },
};

export default SponsorshipTable2;
