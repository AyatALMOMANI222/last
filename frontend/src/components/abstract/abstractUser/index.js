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

function PaperSubmissionForm({ conferenceId }) {
  const navigate = useNavigate();

  // State for each input field
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsApp, setWhatsApp] = useState("");
  const [selectedNationality, setSelectedNationality] = useState("");
  const [password, setPassword] = useState("");
  const [country, setCountry] = useState("");
  const [title, setTitle] = useState("");
  const [abstract, setAbstract] = useState("");
  const [filePath, setFilePath] = useState(null);
  const [error, setError] = useState({});

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
      {/* Adding the important notes section */}
  

      {/* The rest of the form */}
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
      {/* <div className="important-notes">
        <ul>
          <li>· Please write your abstract using the following headings: Objectives, Materials and Methods, Results, and Conclusions.</li>
          <li>· The abstract text should be no longer than 2500 characters or 300 words, including spaces and tables.</li>
          <li>· Authors will be notified of acceptance within three weeks of receiving their abstracts.</li>
          <li>· Invitation letter: A letter approves that the conference committee board accepts your paper submission, and a registration application will be sent. It will be stated in English and may help with your visa application. However, it does not guarantee you a visa.</li>
          <li>· Invitation letters will only be issued once you've completed your registration and payment.</li>
          <li>· Invitation letters will be sent by e-mail.</li>
          <li>· To request an invitation letter, e-mail us with the following data to coordinator@eventscons.com: Registration Form, Payment Proof, and Passport Scan Copy.</li>
          <li>· For those who require a visa, please note that the Organizing Committee has no control over the visa application process or the decision of the visa adjudicator in the Embassy or consulate.</li>
          <li>· The process length varies from individual to individual, so you should start your application as soon as possible.</li>
          <li>· If your application is denied, we can't change the decision of the Ministry of Foreign Affairs, nor will we talk or communicate with the MOFA or the Embassy on behalf of the applicant.</li>
        </ul>
      </div> */}
    </div>
  );
}

export default PaperSubmissionForm;
