import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import axiosInstance from "../../common/http";
import { useNavigate, useParams } from "react-router-dom";
import { toast } from "react-toastify";
import PhoneNumberInput from "../../CoreComponent/PhoneNumber";
import { countriesOptions, nationalitiesOptions } from "../../constant";
import SVG from "react-inlinesvg";
import registerImg from "../../icons/registerImg.svg";
import "./style.scss";
import ImageUpload from "../../CoreComponent/ImageUpload";
import TextArea from "../../CoreComponent/TextArea";
import axios from "axios";
import DialogMessage from "../../components/DialogMessage";

const RegisterPage = () => {
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const navigate = useNavigate();
  const { id } = useParams();
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [specialization, setSpecialization] = useState("");
  const [selectedNationality, setSelectedNationality] = useState("");
  const [country, setCountry] = useState("");
  const [image, setImage] = useState(null);
  const [resumeText, setResumeText] = useState("");

  const [error, setError] = useState({
    name: "",
    email: "",
    password: "",
    phone: "",
    whatsApp: "",
    specialization: "",
    nationality: "",
    country: "",
    image: "",
    resume: "",
  });

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("name", name);
    formData.append("email", email);
    formData.append("password", password);
    formData.append("image", image);
    formData.append("biography", resumeText);
    formData.append("registration_type", "speaker");
    formData.append("phone_number", phone);
    formData.append("whatsapp_number", whatsApp);
    formData.append("specialization", specialization);
    formData.append("nationality", selectedNationality.value);
    formData.append("country_of_residence", country.value);

    try {
      const response = await axios.post(
        `${BaseUrl}/users/${id}`,
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
    let errorImage = "";
    let errorResume = "";

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

    // Image validation
    if (!image) {
      errorImage = "Please upload a profile picture.";
    } else if (
      !["jpg", "jpeg", "png", "gif"].includes(image.type.split("/")[1])
    ) {
      errorImage = "Only image files (jpg, jpeg, png, gif) are allowed.";
    }

    // Resume validation
    if (!resumeText) {
      errorResume = "Please enter your resume.";
    } else if (resumeText.length < 50) {
      // Example: resume should be at least 50 characters
      errorResume = "Resume should be at least 50 characters long.";
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
      image: errorImage,
      resume: errorResume,
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
      country &&
      !errorImage &&
      !errorResume
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
        image: "",
        resume: "",
      });
      handleSubmit();
    }
  };

  return (
    <div >
      <DialogMessage
        isDialogOpen={isDialogOpen}
        setIsDialogOpen={setIsDialogOpen}
      />
      <div className="register-page-container00">
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

            <TextArea
              label="Resume"
              placeholder="Write your resume here..."
              value={resumeText}
              setValue={setResumeText}
              errorMsg={error.resume}
              rows={8}
            />

            <div className="image-container">
              <ImageUpload
                errorMsg={error.image}
                required={true}
                label="Profile Picture"
                allowedExtensions={["jpg", "jpeg", "png", "gif"]}
                inputValue={image}
                setInputValue={setImage}
              />
            </div>
          </div>

          <div className="register-btn-container">
            <button className="register-btn" type="submit">
              Register
            </button>
          </div>
        </form>

        <SVG className="register-img" src={registerImg} />
      </div>
    </div>
  );
};

export default RegisterPage;
