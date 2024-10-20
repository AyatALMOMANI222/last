import React, { useState } from "react";
import Input from "../../../CoreComponent/Input";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";
import "./style.scss";
import axios from "axios";

const RegisterGroupPage = () => {
  const navigate = useNavigate();
  const { id } = useParams();

  const [organizationName, setOrganizationName] = useState(""); // اسم الجمعية أو وزارة الصحة أو الشركة
  const [contactPerson, setContactPerson] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [email, setEmail] = useState("");
  const [companyAddress, setCompanyAddress] = useState("");
  const [doctorsRegistered, setDoctorsRegistered] = useState(""); // عدد الأطباء المسجلين

  const [error, setError] = useState({
    organizationName: "",
    contactPerson: "",
    phone: "",
    whatsApp: "",
    email: "",
    companyAddress: "",
    doctorsRegistered: "", // خطأ محتمل في عدد الأطباء
  });

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("organization_name", organizationName); // تعديل اسم الحقل
    formData.append("contact_person", contactPerson);
    formData.append("phone_number", phone);
    formData.append("whatsapp_number", whatsApp);
    formData.append("email", email);
    formData.append("company_address", companyAddress);
    formData.append("doctors_registered", doctorsRegistered); // إضافة عدد الأطباء

    try {
      const response = await axios.post(
        `http://127.0.0.1:8000/api/companies/${id}`,
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );
      toast.success("Organization registered successfully!");
    } catch (error) {
      if (error.response) {
        toast.error(error.response.data.error);
      } else {
        toast.error("Something went wrong, please try again.");
      }
    }
  };

  const handleRegister = (e) => {
    e.preventDefault();
    let errorOrganizationName = "";
    let errorContactPerson = "";
    let errorPhone = "";
    let errorWhatsApp = "";
    let errorEmail = "";
    let errorCompanyAddress = "";
    let errorDoctorsRegistered = "";

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // Organization name validation
    if (!organizationName) {
      errorOrganizationName = "Please enter the organization name.";
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

    // Doctors registered validation
    if (!doctorsRegistered) {
      errorDoctorsRegistered = "Please enter the number of registered doctors.";
    }

    // Set errors in state
    setError({
      organizationName: errorOrganizationName,
      contactPerson: errorContactPerson,
      phone: errorPhone,
      whatsApp: errorWhatsApp,
      email: errorEmail,
      companyAddress: errorCompanyAddress,
      doctorsRegistered: errorDoctorsRegistered,
    });

    // Submit the form if no errors
    if (
      organizationName &&
      contactPerson &&
      phone &&
      whatsApp &&
      emailRegex.test(email) &&
      companyAddress &&
      doctorsRegistered
    ) {
      setError({
        organizationName: "",
        contactPerson: "",
        phone: "",
        whatsApp: "",
        email: "",
        companyAddress: "",
        doctorsRegistered: "",
      });
      handleSubmit();
    }
  };

  return (
    <div className="group-registration-page-container">
      <form onSubmit={handleRegister} className="register-form">
        <div className="title">
          <span>Register Organization</span>
        </div>

        <div className="fields-container">
          <Input
            label={"Organization Name (Company/Health Ministry)"}
            placeholder={"e.g. ABC Corp or Ministry of Health"}
            inputValue={organizationName}
            setInputValue={setOrganizationName}
            required={true}
            errorMsg={error.organizationName}
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
            label={"Company Address"}
            placeholder={"e.g. 1234 Elm St, City, Country"}
            inputValue={companyAddress}
            setInputValue={setCompanyAddress}
            required={true}
            errorMsg={error.companyAddress}
          />
          <Input
            label={"Number of Registered Doctors"}
            placeholder={"e.g. 50"}
            inputValue={doctorsRegistered}
            setInputValue={setDoctorsRegistered}
            required={true}
            errorMsg={error.doctorsRegistered}
          />
        </div>

        <div className="register-btn-container">
          <button className="register-btn" type="submit">
            Register
          </button>
        </div>
      </form>
    </div>
  );
};

export default RegisterGroupPage;
