import React, { useState, useEffect } from "react";
import axios from "axios";
import Select from "../../../../CoreComponent/Select";
import { toast } from "react-toastify";
import Input from "../../../../CoreComponent/Input"; // Assuming Input is imported from the correct path
import "./style.scss";
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
    const url = `${BaseUrl}/conferences/all`;

    axios
      .get(url, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        setAllConference(
          response.data.data?.map((item) => ({
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
        toast.success("The Data updated Successfully"); // Show success message
        setLoading(false);

        // Reset form data to initial values after successful submission
        setFormData({
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
        setConferenceId(""); // Reset conference selection as well
      })
      .catch((error) => {
        console.error("Request failed:", error);
        setLoading(false);
        setError("Error submitting data");
      });
  };
  const isFormEmpty = Object.values(formData).every((value) => value === "");

  return (
    <div className="container-sponsorship-list">
      <div className="container-sponsorship-packages">
        {!isFormEmpty && <div  className="header-sponsorship-opportunities">Sponsorship Packages</div>}

        {error && <p className="error">{error}</p>}

        <div className="form-container">
          <div className="sponsorship-packages-section">
            {/* Conference Dropdown */}
            <div className="input-group">
              <Select
                options={allConference}
                value={conferenceId}
                setValue={setConferenceId}
                label="Conference"
                placeholder="Select..."
              />
            </div>

            {/* Sponsorship Form Inputs */}
            {Object.keys(formData).map((key) => (
              <div key={key} className="input-group">
                <Input
                  className="input-field"
                  label={key
                    .replace(/([A-Z])/g, " $1")
                    .replace(/^./, (str) => str.toUpperCase())}
                  placeholder={`Enter ${key
                    .replace(/([A-Z])/g, " $1")
                    .toLowerCase()}`}
                  inputValue={formData[key]}
                  setInputValue={(value) =>
                    handleInputChange({ target: { name: key, value } })
                  }
                  required={true}
                  errorMsg={error && error[key]} // Assuming error messages are structured similarly
                />
              </div>
            ))}
          </div>
          <button
            onClick={handlePostRequest}
            className="submit-button"
            disabled={loading}
          >
            {loading ? "Submitting..." : "Submit"}
          </button>
        </div>
      </div>
    </div>
  );
};

export default SponsorshipTable2;
