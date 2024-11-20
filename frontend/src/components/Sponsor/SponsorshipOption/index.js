import React, { useEffect, useState } from "react";
import "./style.scss"; // تأكد من استيراد ملف CSS الخاص بالمكون
import SponsorshipTable from "../SponsorshipTable";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

// Component for each sponsorship option
const SponsorshipOption = ({ id, title, description, price, onSelect }) => {
  const [selected, setSelected] = useState(false);

  const handleSelect = () => {
    setSelected(!selected); // تغيير حالة التحديد
    onSelect(id, !selected); // تمرير الـ id والـ selected state للمكون الأب
  };

  return (
    <div
      className={`sponsorship-option ${selected ? "selected" : ""}`}
      onClick={handleSelect}
    >
      <div className="option-header">
        <h3>{title}</h3>
        <p className="price">
          <strong>{price}</strong>
        </p>
      </div>
      <p>{description}</p>
      <input type="checkbox" checked={selected} readOnly />
    </div>
  );
};

const StandardBoothPackage = () => {
  
  return (
    <div className="booth-package">
      <h2>Standard Booth Package</h2>
      <img src={require("./both.jfif")} alt="Booth" />
      <p>(Minimum space 9 sqm)</p>
      <ul>
        <li>Fascia board with company name & stand number.</li>
        <li>White partitions.</li>
        <li>Needle-punched carpeting.</li>
        <li>Single-phase electrical socket (220V - 240V).</li>
        <li>2 fluorescent lights.</li>
        <li>2 folding chairs.</li>
        <li>1 information counter.</li>
        <li>1 waste paper basket.</li>
      </ul>
      <p>
        Once the sponsor completes the options, they will have the option to
        upload the agreement. After signing, a financial claim will be sent for
        the fees.
      </p>
      <p>
        For special buildup booths and other special requirements, please
        contact the organizers:
        <a href="mailto:admin@eventcons.com">admin@eventcons.com</a>
      </p>

      {/* إدخال رقم المعرض */}

      {/* زر لفتح ملف PDF */}
      <a
        href="/Floor Plan -UROLOGICAL.pdf" // التأكد من أن الملف موجود في مجلد public
        target="_blank"
        rel="noopener noreferrer"
        className="view-floor-plans-btn"
      >
        <button className="view-floor-plans-button">View Floor Plans</button>
      </a>
      <div className="input-container">
        <label htmlFor="exhibitNumber" className="input-label">
          Enter Exhibit Number:
        </label>
        <input
          type="text"
          id="exhibitNumber"
          placeholder="Enter the exhibit number"
          className="input-field"
        />
      </div>
    </div>
  );
};

// Button for signing the agreement
const SignAgreementButton = ({ onSignAgreement }) => {
  return (
    <button onClick={onSignAgreement} className="sign-agreement-button">
      Sign the Agreement
    </button>
  );
};

// New Submit button
const SubmitButton = ({ onSubmit }) => {
  return (
    <button onClick={onSubmit} className="submit-button">
      Submit
    </button>
  );
};

const BoothCostTable = ({ selectedBoothIds, onSelectBooth }) => {
  const [boothData, setBoothData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [shellSchemeSelected, setShellSchemeSelected] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`${BaseUrl}/size/table/admin/get/1`);
        const { boothCosts } = response.data;
        setBoothData(boothCosts);
        setLoading(false);
      } catch (err) {
        setError("Error fetching data. Please try again.");
        setLoading(false);
      }
    };

    fetchData();
  }, []);

 

  // Handle the shell scheme checkbox change
  const handleShellSchemeChange = (event) => {
    setShellSchemeSelected(event.target.checked);
  };

  const handleClick = (boothId) => {
    const isSelected = selectedBoothIds.includes(boothId);
    onSelectBooth(boothId, !isSelected);
  };
  const handleCheckboxChange = (event, boothId) => {
    const isChecked = event.target.checked;
    onSelectBooth(boothId, isChecked); // استدعاء الدالة من الكمبوننت الأب
  };
  if (loading) return <p>Loading data...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div className="booth-cost-table" style={tableStyle}>
      <h2 style={{ color: "#333", marginBottom: "10px" }}>Booth Cost Table</h2>
      <h5 style={{ marginBottom: "20px", color: "#666" }}>
        Space only stand USD 1400 Per Meter - Depth = 3M
      </h5>
      <table style={tableStyle}>
        <thead>
          <tr style={headerRowStyle}>
            <th style={headerCellStyle}>Booth Size (LM)</th>
            <th style={headerCellStyle}>Cost (USD)</th>
            <th style={headerCellStyle}>Lunch Invitations</th>
            <th style={headerCellStyle}>Name Tags</th>
            <th style={headerCellStyle}>Selected</th>
          </tr>
        </thead>
        <tbody>
          {boothData.map((booth) => (
            <tr key={booth.id} style={rowStyle}>
              <td style={cellStyle}>
                {booth.name}{" "}
                {selectedBoothIds.includes(booth.id) ? "(Selected)" : ""}
              </td>
              <td style={cellStyle}>{booth.cost}</td>
              <td style={cellStyle}>{booth.lunch_invitations}</td>
              <td style={cellStyle}>{booth.name_tags}</td>
              <td style={cellStyle}>
              
                  <input
                  type="checkbox"
                  checked={selectedBoothIds.includes(booth.id)} // تأكد إذا كان القسم مختارًا
                  onChange={(e) => handleCheckboxChange(e, booth.id)}
                />
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Shell Scheme Booth Checkbox */}
      <div style={{ marginTop: "20px" }}>
        <input
          type="checkbox"
          checked={shellSchemeSelected}
          onChange={handleShellSchemeChange}
        />
        <span style={{ marginLeft: "10px" }}>
          Additional cost for Shell Scheme Booth (special build-up booth):{" "}
          <strong style={{ color: "#B22222" }}>50 USD per square meter.</strong>
        </span>
      </div>
    </div>
  );
};

// أسلوب لتنسيق الجدول وعناصره
const tableStyle = {
  width: "100%",
  borderCollapse: "collapse",
  fontFamily: "Arial, sans-serif",
};

const headerRowStyle = {
  backgroundColor: "#f2f2f2",
  textAlign: "left",
};

const headerCellStyle = {
  padding: "10px",
  fontWeight: "bold",
  borderBottom: "2px solid #ddd",
};

const rowStyle = {
  borderBottom: "1px solid #ddd",
};

const cellStyle = {
  padding: "10px",
};

// Sponsor Section

const SponsorSection = () => {
  const [options, setOptions] = useState([]);
  const [selectedOptionIds, setSelectedOptionIds] = useState([]);
  const [isAgreementSigned, setIsAgreementSigned] = useState(false);
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [isPopupOpen, setIsPopupOpen] = useState(false);
  const [selectedSponsorshipIds, setSelectedSponsorshipIds] = useState([]); // لتخزين IDs القادمة من الابن
  const [chosenBooths, setChosenBooths] = useState([]); // حالة الأقسام المختارة
const navigate =useNavigate()
  const handleSelectBooth = (boothId, isSelected) => {
    setChosenBooths((prevIds) => {
      if (isSelected) {
        return [...prevIds, boothId]; // إضافة المعرف إذا تم اختياره
      } else {
        return prevIds.filter((id) => id !== boothId); // إزالة المعرف إذا تم إلغاء الاختيار
      }
    });
  };
  const handleSelectedSponsorshipsChange = (ids) => {
    setSelectedSponsorshipIds(ids); // تحديث state بناءً على البيانات القادمة من الابن
  };
  const openAgreementPopup = () => {
    setIsPopupOpen(true);
  };

  const handleSignAgreement = () => {
    setIsAgreementSigned(true);
    setIsPopupOpen(false);
    toast.success("Agreement signed successfully!");
  };



  const getSponsorshipOptions = async () => {
    try {
      const token = localStorage.getItem("token");
      const response = await axios.get(`${BaseUrl}/sponsorship-options/1`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setOptions(response.data);
    } catch (error) {
      console.error("Error fetching sponsorship options:", error);
    }
  };

  useEffect(() => {
    getSponsorshipOptions();
  }, []);

  const handleSelectOption = (id, isSelected) => {
    setSelectedOptionIds((prevIds) => {
      if (isSelected) {
        return [...prevIds, id];
      } else {
        return prevIds.filter((optionId) => optionId !== id);
      }
    });
  };
  const handleSubmit = async () => {
    const token = localStorage.getItem("token"); // احصل على التوكن
    const payload = {
      user_id: 1, // قم بتغيير القيم وفقًا للبيانات الحقيقية
      user_name: "John Doe",
      conference_sponsorship_option_ids: selectedSponsorshipIds,
      booth_cost_ids: chosenBooths, // استخدم الأقسام المختارة
      sponsorship_option_ids: selectedOptionIds, // استخدم الخيارات المختارة
      conference_id: 1,
      additional_cost_for_shell_scheme_booth: true, // إذا كان هناك تكلفة إضافية
    };

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/invoice",
        payload,
        {
          headers: {
            Authorization: `Bearer ${token}`, // تمرير التوكن
          },
        }
      );
      console.log("Response data:", response.data);
      toast.success(
        "The options have been successfully registered as a sponsor for this event."
      );
      navigate("/sponsor/invoice")
    } catch (error) {
      console.error("Error submitting data:", error);
      toast.error("Failed to submit data. Please try again.");
    }
  };

  return (
    <div className="sponsor-section">
      <h2>Sponsorship Opportunities</h2>
      <div className="sponsorship-options">
        {options.map((option) => (
          <SponsorshipOption
            key={option.id}
            id={option.id}
            title={option.title}
            description={option.description}
            price={option.price}
            onSelect={handleSelectOption}
          />
        ))}
      </div>
    
    
      <SponsorshipTable
        onSelectedSponsorshipsChange={handleSelectedSponsorshipsChange} // تمرير دالة التحديث كـ Prop
      />{" "}
       {/* <div>
        <h3>Selected Sponsorship IDs in Parent:</h3>
        <ul>
          {selectedSponsorshipIds.map((id) => (
            <li key={id}>Sponsorship ID: {id}</li>
          ))}
        </ul>
      </div> */}
      <BoothCostTable
        selectedBoothIds={chosenBooths} // تمرير الأقسام المختارة
        onSelectBooth={handleSelectBooth} // تمرير دالة التحديث
      />
      <StandardBoothPackage />
      <div className="button-container">
        <button onClick={openAgreementPopup}>Sign Agreement</button>
        <SubmitButton onSubmit={handleSubmit} />
      </div>
      {isAgreementSigned && (
        <div className="agreement-status">
          <p>Your agreement has been signed successfully!</p>
        </div>
      )}
      {isPopupOpen && (
        <div className="agreement-popup">
          <div className="popup-content">
            <h3>Agreement for Sponsorship</h3>
            <p>
              By signing this agreement, you confirm your commitment to sponsor
              the event...
            </p>
            <div className="popup-buttons">
              <button onClick={handleSignAgreement} className="btn-sign">
                Sign Agreement
              </button>
              <button
                onClick={() => setIsPopupOpen(false)}
                className="btn-cancel"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default SponsorSection;
