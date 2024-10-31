import React, { useState } from 'react';
import './style.scss'; // تأكد من استيراد ملف CSS الخاص بالمكون
import SponsorshipTable from '../SponsorshipTable';

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
    const sponsorshipOptions = [
        {
            title: 'Scientific Book Program',
            description: '500 printed copies (23 cm × 17 cm) distributed free to VIP guests, delegates, media, and speakers.',
            price: 'USD 1500',
        },
        {
            title: 'Website Banner',
            description: '300 × 300 pixels banner with company logo linked to the sponsor’s website.',
            price: 'USD 1000',
        },
        {
            title: 'Logo on Floor Plans',
            description: 'Displayed on 2 floor plans at the exhibition entrance and conference exit.',
            price: 'USD 500',
        },
        {
            title: 'Delegate Bags',
            description: '500 bags (for VIP guests, media, and delegates) with printed sponsor logo.',
            price: 'USD 8000',
        },
        {
            title: 'Lanyards',
            description: '500 lanyards distributed to all conference participants with the sponsor’s logo.',
            price: 'USD 1500',
        },
        {
            title: 'Inserts in Delegate Bags',
            description: '1 booklet/pen and notebook or 1 flyer per bag for 500 bags.',
            price: 'USD 1000',
        },
        {
            title: 'Exclusive Registration Area',
            description: 'Company logo displayed in the registration lounge.',
            price: 'USD 2000',
        },
        {
            title: 'USB Flash Drive Sponsorship',
            description: 'Sponsor logo printed on the USB drive.',
            price: 'USD 3500',
        },
        {
            title: 'Exhibition Hall',
            description: '20 banners (1m × 1.80m) placed in the exhibition area.',
            price: 'USD 2000',
        },
        {
            title: 'Conference Room Sponsorship',
            description: '2 sponsor banners in the conference halls next to the stage.',
            price: 'USD 1000',
        },
    ];

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
                {sponsorshipOptions.map((option, index) => (
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
