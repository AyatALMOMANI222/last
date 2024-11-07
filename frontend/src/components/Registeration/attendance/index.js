import React, { Fragment, useEffect, useState } from "react";
import Input from "../../../CoreComponent/Input";
import Select from "../../../CoreComponent/Select";
import axiosInstance from "../../../common/http";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import { countriesOptions, nationalitiesOptions } from "../../../constant";
import SVG from "react-inlinesvg";
import registerImg from "../../../icons/registerImg.svg";
import axios from "axios";
import "./style.scss";
import DialogMessage from "../../DialogMessage";

const RegisterAttendancePage = () => {
  const navigate = useNavigate();
  const { conferenceId } = useParams(); // هنا نستخدم معرف المؤتمر من المعاملات
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [specialization, setSpecialization] = useState("");
  const [selectedNationality, setSelectedNationality] = useState("");
  const [country, setCountry] = useState("");

  const [error, setError] = useState({
    name: "",
    email: "",
    password: "",
    phone: "",
    whatsApp: "",
    specialization: "",
    nationality: "",
    country: "",
  });

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("name", name);
    formData.append("email", email);
    formData.append("password", password);
    formData.append("registration_type", "attendance");
    formData.append("phone_number", phone);
    formData.append("whatsapp_number", whatsApp);
    formData.append("specialization", specialization);
    formData.append("nationality", selectedNationality.value);
    formData.append("country_of_residence", country.value);
    formData.append("conference_id", conferenceId); // تم التعديل هنا

    // try {
    //   const response = await axios.post(
    //     `http://127.0.0.1:8000/api/attendances`,
    //     formData,
    //     {
    //       headers: {
    //         "Content-Type": "multipart/form-data",
    //       },
    //     }
    //   );
    //   toast.success("User created successfully!");
    //   console.log(response);

    // } catch (error) {
    //   if (error.response) {
    //     toast.error(error.response.data.error);
    //   }
    // }

    try {
      const response = await axios.post(
        `http://127.0.0.1:8000/api/users/${conferenceId}`,
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );
      setIsDialogOpen(true);
      toast.success("User created successfully!");
    } catch (error) {
      if (error.response) {
        toast.error(error.response.data.error);
      } else {
      }
    }
  };

  const handleRegister = (e) => {
    e.preventDefault();
    let errorName = "";
    let errorEmail = "";
    let errorPassword = "";
    let errorPhone = "";
    let errorWhatsApp = "";
    let errorSpecialization = "";
    let errorNationality = "";
    let errorCountry = "";

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // Name validation
    if (!name) {
      errorName = "Please enter your name.";
    }

    // Email validation
    if (!email) {
      errorEmail = "Please enter your email.";
    } else if (!emailRegex.test(email)) {
      errorEmail = "Please enter a valid email.";
    }

    // Password validation
    if (!password) {
      errorPassword = "Please enter your password.";
    }

    // Phone validation
    if (!phone) {
      errorPhone = "Please enter your phone number.";
    }

    // WhatsApp validation
    if (!whatsApp) {
      errorWhatsApp = "Please enter your WhatsApp number.";
    }

    // Specialization validation
    if (!specialization) {
      errorSpecialization = "Please enter your specialization.";
    }

    // Nationality validation
    if (!selectedNationality) {
      errorNationality = "Please select your nationality.";
    }

    // Country validation
    if (!country) {
      errorCountry = "Please select your country.";
    }

    // Set errors in state
    setError({
      name: errorName,
      email: errorEmail,
      password: errorPassword,
      phone: errorPhone,
      whatsApp: errorWhatsApp,
      specialization: errorSpecialization,
      nationality: errorNationality,
      country: errorCountry,
    });

    // Submit the form if no errors
    if (
      name &&
      email &&
      emailRegex.test(email) &&
      password &&
      phone &&
      whatsApp &&
      specialization &&
      selectedNationality &&
      country
    ) {
      setError({
        name: "",
        email: "",
        password: "",
        phone: "",
        whatsApp: "",
        specialization: "",
        nationality: "",
        country: "",
      });
      handleSubmit();
    }
  };

  return (
    <Fragment>
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
      />
      <div className="register-page-container">
        <form onSubmit={handleRegister} className="register-form">
          <div className="title">
            <span>Sign Up</span>
            <span
              className="sub-title"
              onClick={() => {
                navigate("/login");
              }}
            >
              login
            </span>
          </div>

          <div className="fields-container">
            <Input
              label={"Name"}
              placeholder={"e.g. John Doe"}
              inputValue={name}
              setInputValue={setName}
              required={true}
              errorMsg={error.name}
            />
            <Input
              label={"Email"}
              placeholder={"e.g. example@example.com"}
              inputValue={email}
              setInputValue={setEmail}
              required={true}
              errorMsg={error.email}
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
              label={"Specialization"}
              placeholder={"e.g. Software Engineer"}
              inputValue={specialization}
              setInputValue={setSpecialization}
              required={true}
              errorMsg={error.specialization}
            />

            <Select
              options={nationalitiesOptions}
              value={selectedNationality}
              setValue={setSelectedNationality}
              label="Nationality"
              errorMsg={error.nationality}
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

            <Select
              options={countriesOptions}
              value={country}
              setValue={setCountry}
              label="Country"
              errorMsg={error.country}
            />
          </div>

          <div className="register-btn-container">
            <button className="register-btn" type="submit">
              Register
            </button>
          </div>
        </form>

        <SVG className="register-img" src={registerImg} />
      </div>
    </Fragment>
  );
};

export default RegisterAttendancePage;
