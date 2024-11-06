import React, { useEffect, useState } from 'react';
import './style.scss'; // تأكد من استيراد ملف CSS الخاص بالمكون
import SponsorshipTable from '../SponsorshipTable';
import axios from 'axios';

// Component for each sponsorship option
const SponsorshipOption = ({ title, description, price }) => {
    const [selected, setSelected] = useState(false);

    const handleSelect = () => {
        setSelected(!selected);
    };

    return (
        <div className={`sponsorship-option ${selected ? 'selected' : ''}`} onClick={handleSelect}>
            <div className="option-header">
                <h3>{title}</h3>
                <p className="price"><strong>{price}</strong></p>
            </div>
            <p>{description}</p>
            <input type="checkbox" checked={selected} readOnly />
        </div>
    );
};

// Component for Standard Booth Package
const StandardBoothPackage = () => {
    return (
        <div className="booth-package">
            <h2>Standard Booth Package</h2>
            <img src={require("./both.jfif")}/>
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
                Once the sponsor completes the options, they will have the option to upload the agreement.
                After signing, a financial claim will be sent for the fees.
            </p>
            <p>
                For special buildup booths and other special requirements, please contact the organizers: 
                <a href="mailto:admin@eventcons.com">admin@eventcons.com</a>
            </p>
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

const BoothCostTable = () => {
    const boothData = [
        { size: '3 LM', cost: 4200, lunchInvitations: 1, nameTags: 2 },
        { size: '4 LM', cost: 5600, lunchInvitations: 2, nameTags: 2 },
        { size: '6 LM', cost: 8400, lunchInvitations: 3, nameTags: 2 },
    ];

    return (
        <div className="booth-cost-table">
            <h2>Booth Cost Table</h2>
            <h5>Space only stand USD 1400 Per Meter - Depth = 3M</h5>
            <table>
                <thead>
                    <tr>
                        <th>Booth Size (LM)</th>
                        <th>Cost (USD)</th>
                        <th>Lunch Invitations</th>
                        <th>Name Tags</th>
                    </tr>
                </thead>
                <tbody>
                    {boothData.map((booth, index) => (
                        <tr key={index}>
                            <td>{booth.size}</td>
                            <td>{booth.cost}</td>
                            <td>{booth.lunchInvitations}</td>
                            <td>{booth.nameTags}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            <p>
                Additional cost for Shell Scheme Booth (special build-up booth): 
                <strong> 50 USD per square meter.</strong>
            </p>
        </div>
    );
};



// Sponsor Section
const SponsorSection = () => {
    const [options,setOptions]=useState([])
   
    const getSponsorshipOptions = async (conferenceId) => {
        try {
          const token = localStorage.getItem('token'); // تأكد من وجود التوكن في الـ localStorage
          const response = await axios.get(`http://127.0.0.1:8000/api/sponsorship-options/1`, {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          });
      
          // التعامل مع البيانات المسترجعة
          console.log('Sponsorship Options:', response.data);
          setOptions(response.data)
        } catch (error) {
          // التعامل مع الخطأ
          console.error('Error fetching sponsorship options:', error);
        }
      };
      useEffect(()=>{
        getSponsorshipOptions()
      },[])
    // Handle agreement signing
    const handleSignAgreement = () => {
        alert('Agreement signed.');
        // يمكنك إضافة منطق إضافي هنا
    };

    // Handle form submission
    const handleSubmit = () => {
        alert('Form submitted.');
        // منطق إضافي لتقديم النموذج
    };

    return (
        <div className="sponsor-section">
            <h2>Sponsorship Opportunities</h2>
            <div className="sponsorship-options">
                {options.map((option, index) => (
                    <SponsorshipOption 
                        key={index} 
                        title={option.title} 
                        description={option.description} 
                        price={option.price} 
                    />
                ))}
            </div>
            <SponsorshipTable />
            < BoothCostTable/>
            <StandardBoothPackage />
            <div className="button-container">
                <SignAgreementButton onSignAgreement={handleSignAgreement} />
                <SubmitButton onSubmit={handleSubmit} />
            </div>
        </div>
    );
};

export default SponsorSection;
