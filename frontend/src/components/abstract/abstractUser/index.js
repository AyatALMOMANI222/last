import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import { useParams } from "react-router-dom";
import Input from "../../../CoreComponent/Input";
import PhoneNumberInput from "../../../CoreComponent/PhoneNumber";
import Select from "../../../CoreComponent/Select";
import TextArea from "../../../CoreComponent/TextArea";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import { countriesOptions, nationalitiesOptions } from "../../../constant";
import "./style.scss";
import { toast } from "react-toastify";
function PaperSubmissionForm({conferenceId}) {
  const navigate = useNavigate();
  // const { conferenceId } = useParams(); hedayatodo
  // State for each input field
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [selectedNationality, setSelectedNationality] = useState("");
  const [password, setPassword] = useState("");
  const [country, setCountry] = useState("");
  // const [conferenceId, setConferenceId] = useState("");
  const [title, setTitle] = useState("");
  const [abstract, setAbstract] = useState("");
  const [filePath, setFilePath] = useState(null);
  const [error, setError] = useState({});

  // // Options for Select components
  // const nationalitiesOptions = [{ value: "Jordanian", label: "Jordanian" }];
  // const countriesOptions = [{ value: "Jordan", label: "Jordan" }];
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append("name", name);
    formData.append("email", email);
    formData.append("phone_number", phone);
    formData.append("whatsapp_number", whatsApp);
    formData.append("nationality", selectedNationality.value);
    formData.append("password", password);
    formData.append("country_of_residence", country.value);
    formData.append("title", title);
    formData.append("abstract", abstract);
    formData.append("conference_id", conferenceId); // إذا كنت بحاجة إلى هذا
    formData.append("file_path", filePath); // إذا كان هناك ملف

    try {
      await axios.post(`${BaseUrl}/abstract`, formData);
      toast.success(
        "Your abstract has been successfully submitted. Thank you for your contribution!"
      );
    } catch (error) {
      console.error("Error submitting form:", error);

      setError({
        form: "There was an error submitting your form. Please try again.",
      });
    }
  };

  return (
    <div className="register-page-container112">
      <form onSubmit={handleSubmit} className="register-form">
        <div className="title">Abstract</div>
        <div className="fields-container">
          <Input
            className="input-field"
            label="Name"
            placeholder="e.g. John Doe"
            inputValue={name}
            setInputValue={setName}
            required={true}
            errorMsg={error.name}
          />
          <Input
            className="input-field"
            label="Title"
            placeholder="Enter Your Title"
            inputValue={title}
            setInputValue={setTitle}
            required={true}
            errorMsg={error.title}
          />
          <Input
            className="input-field"
            label="Email"
            placeholder="e.g. example@example.com"
            inputValue={email}
            setInputValue={setEmail}
            required={true}
            errorMsg={error.email}
          />
          <PhoneNumberInput
            className="input-field"
            label="Phone Number"
            phone={phone}
            setPhone={setPhone}
            required={true}
            errorMsg={error.phone}
          />
          <PhoneNumberInput
            className="input-field"
            label="WhatsApp Number"
            phone={whatsApp}
            setPhone={setWhatsApp}
            required={true}
            errorMsg={error.whatsApp}
          />
          <Select
            options={countriesOptions}
            value={country}
            setValue={setCountry}
            label="Country"
            errorMsg={error.country}
          />
          <Input
            className="input-field"
            label="Password"
            placeholder="Your password"
            inputValue={password}
            setInputValue={setPassword}
            required={true}
            errorMsg={error.password}
            type="password"
          />
          <Select
            options={nationalitiesOptions}
            value={selectedNationality}
            setValue={setSelectedNationality}
            label="Nationality"
            errorMsg={error.nationality}
          />
          <TextArea
            className="textarea-field"
            label="Abstract"
            placeholder="Enter abstract"
            value={abstract}
            setValue={setAbstract}
            required={true}
            errorMsg={error.abstract}
            rows={15}
          />
          <ImageUpload
            className="upload-field"
            label="Upload Paper File"
            inputValue={filePath}
            setInputValue={setFilePath}
            allowedExtensions={["pdf"]}
          />
        </div>
        <div className="register-btn-container">
          <button className="register-btn" type="submit">
            Upload
          </button>
        </div>
      </form>
    </div>
  );
}

export default PaperSubmissionForm;
