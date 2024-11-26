import React, { useState } from "react";
import Input from "../../../CoreComponent/Input";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";

import "./style.scss";
import httpService from "../../../common/httpService";
import DialogMessage from "../../DialogMessage";

const RegisterSponsorPage = () => {
  const navigate = useNavigate();
  const { conferenceId } = useParams();
  const [password, setPassword] = useState("");
  const [companyName, setCompanyName] = useState("");
  const [contactPerson, setContactPerson] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [email, setEmail] = useState("");
  const [companyAddress, setCompanyAddress] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const [error, setError] = useState({
    companyName: "",
    contactPerson: "",
    phone: "",
    whatsApp: "",
    email: "",
    companyAddress: "",
  });

  const handleSubmit = async () => {
    const sponsorData = {
      company_name: companyName,
      contact_person: contactPerson,
      phone_number: phone,
      whatsapp_number: whatsApp,
      email: email,
      company_address: companyAddress,
      password: password,
      registration_type: "sponsor",
      conference_id: conferenceId,
    };

    try {
      // استدعاء HTTP لإنشاء الراعي
      await httpService({
        method: "POST",
        url: `${BaseUrl}/sponsor`,
        data: sponsorData,
        withToast: true,
      });

      setIsDialogOpen(true);
    } catch (error) {
      toast.error("Something went wrong, please try again.");
    }
  };

  const handleRegister = (e) => {
    e.preventDefault();
    let errorCompanyName = "";
    let errorContactPerson = "";
    let errorPhone = "";
    let errorWhatsApp = "";
    let errorEmail = "";
    let errorCompanyAddress = "";

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // Company name validation
    if (!companyName) {
      errorCompanyName = "Please enter the company name.";
    }

    // Contact person validation
    if (!contactPerson) {
      errorContactPerson = "Please enter the contact person.";
    }

    // Phone validation
    if (!phone) {
      errorPhone = "Please enter the phone number.";
    }

    // WhatsApp validation
    if (!whatsApp) {
      errorWhatsApp = "Please enter the WhatsApp number.";
    }

    // Email validation
    if (!email) {
      errorEmail = "Please enter the email.";
    } else if (!emailRegex.test(email)) {
      errorEmail = "Please enter a valid email.";
    }

    // Company address validation
    if (!companyAddress) {
      errorCompanyAddress = "Please enter the company address.";
    }

    // Set errors in state
    setError({
      companyName: errorCompanyName,
      contactPerson: errorContactPerson,
      phone: errorPhone,
      whatsApp: errorWhatsApp,
      email: errorEmail,
      companyAddress: errorCompanyAddress,
    });

    // Submit the form if no errors
    if (
      companyName &&
      contactPerson &&
      phone &&
      whatsApp &&
      emailRegex.test(email) &&
      companyAddress
    ) {
      setError({
        companyName: "",
        contactPerson: "",
        phone: "",
        whatsApp: "",
        email: "",
        companyAddress: "",
      });
      handleSubmit();
    }
  };

  return (
    <div>
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
        message={"Thank you for applying to Sponser at the conference.You will be contacted directly by the organizing company via email."}
      />
      <div className="register-page-container">
        <form onSubmit={handleRegister} className="register-form">
          <div className="title">
            <span>Register Company</span>
          </div>

          <div className="fields-container">
            <Input
              label={"Company Name"}
              placeholder={"e.g. ABC Corp"}
              inputValue={companyName}
              setInputValue={setCompanyName}
              required={true}
              errorMsg={error.companyName}
            />
            <Input
              label={"Contact Person"}
              placeholder={"e.g. John Doe"}
              inputValue={contactPerson}
              setInputValue={setContactPerson}
              required={true}
              errorMsg={error.contactPerson}
            />
            <PhoneNumberInput
              label={"Phone Number"}
              phone={phone}
              setPhone={setPhone}
              required={true}
              errorMsg={error.phone}
            />
            <PhoneNumberInput
              label={"WhatsApp Number"}
              phone={whatsApp}
              setPhone={setWhatsApp}
              required={true}
              errorMsg={error.whatsApp}
            />
            <Input
              label={"Email"}
              placeholder={"e.g. example@example.com"}
              inputValue={email}
              setInputValue={setEmail}
              required={true}
              errorMsg={error.email}
            />
            <Input
              label="Password"
              placeholder="Enter password"
              inputValue={password}
              setInputValue={setPassword}
              type="password"
              required
            />
            <Input
              label={"Company Address"}
              placeholder={"e.g. 1234 Elm St, City, Country"}
              inputValue={companyAddress}
              setInputValue={setCompanyAddress}
              required={true}
              errorMsg={error.companyAddress}
            />
          </div>

          <div className="register-btn-container">
            <button className="register-btn" type="submit">
              Register
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default RegisterSponsorPage;
