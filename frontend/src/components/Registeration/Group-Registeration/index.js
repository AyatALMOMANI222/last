import React, { useState } from "react";
import Input from "../../../CoreComponent/Input";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";
import "./style.scss";
import axios from "axios";
import DialogMessage from "../../DialogMessage";  // استيراد DialogMessage

const RegisterGroupPage = () => {
  const navigate = useNavigate();
  const { conferenceId } = useParams();
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const [organizationName, setOrganizationName] = useState(""); // اسم الجمعية أو وزارة الصحة أو الشركة
  const [contactPerson, setContactPerson] = useState("");
  const [phone, setPhone] = useState("");
  const [password, setPassword] = useState("");
  const [email, setEmail] = useState("");
  const [doctorsRegistered, setDoctorsRegistered] = useState(""); // عدد الأطباء المسجلين

  const [error, setError] = useState({
    organizationName: "",
    contactPerson: "",
    phone: "",
    password: "",
    email: "",
    companyAddress: "",
    doctorsRegistered: "", // خطأ محتمل في عدد الأطباء
  });

  // حالة لفتح رسالة الحوار
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("name", organizationName); // تعديل اسم الحقل
    formData.append("contact_person", contactPerson);
    formData.append("phone", phone);
    formData.append("email", email);
    formData.append("password", password);
    formData.append("number_of_doctors", doctorsRegistered); // إضافة عدد الأطباء
    formData.append("conference_id", conferenceId); // إضافة conference_id إلى البيانات

    try {
      const response = await axios.post(
        `${BaseUrl}/register/group`,
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );
      toast.success("Organization registered successfully!");
      setIsDialogOpen(true);  // فتح رسالة الحوار عند التسجيل الناجح
      setTimeout(() => {
      }, 3000); // الانتظار 3 ثوانٍ قبل التوجيه
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
    let errorPassword = "";
    let errorEmail = "";
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
    if (!password) {
      errorPassword = "Please enter the password.";
    }

    // Email validation
    if (!email) {
      errorEmail = "Please enter the email.";
    } else if (!emailRegex.test(email)) {
      errorEmail = "Please enter a valid email.";
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
      email: errorEmail,
      doctorsRegistered: errorDoctorsRegistered,
    });

    // Submit the form if no errors
    if (
      organizationName &&
      contactPerson &&
      phone &&
      password &&
      emailRegex.test(email) &&
      doctorsRegistered
    ) {
      setError({
        organizationName: "",
        contactPerson: "",
        phone: "",
        password: "",
        email: "",
        doctorsRegistered: "",
      });
      handleSubmit();
    }
  };

  return (
    <div className="group-registration-page-container789">
      {/* <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
        message={"Your organization has been successfully registered! You will be notified via email once the admin approves your registration."}
      /> */}
      <form onSubmit={handleRegister} className="register-form">
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
        message={"Your organization has been successfully registered! You will be notified via email once the admin approves your registration."}
      />
        <div className="title">
          <span>Register Organization</span>
        </div>

        <div className="fields-container">
          <Input
            label={"Organization Name"}
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
          <Input
            label={"Email"}
            placeholder={"e.g. example@example.com"}
            inputValue={email}
            setInputValue={setEmail}
            required={true}
            errorMsg={error.email}
          />
          <Input
            label={"Password"}
            placeholder={"Your password"}
            inputValue={password}
            setInputValue={setPassword}
            required={true}
            errorMsg={error.password}
            type="password"
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
