import React, { useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input"; // Custom Input component
import PhoneNumberInput from "../../CoreComponent/PhoneNumber"; // Custom Phone Input component
import { countriesOptions } from "../../constant"; // Assuming these are predefined
import Select from "../../CoreComponent/Select"; // Custom Select component
import ImageUpload from "../../CoreComponent/ImageUpload";
import "./style.scss"
const ScientificPaperForm = ({ conferenceId }) => {
  const [authorName, setAuthorName] = useState("");
  const [authorTitle, setAuthorTitle] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsapp, setWhatsapp] = useState("");
  const [country, setCountry] = useState("");
  const [nationality, setNationality] = useState("");
  const [password, setPassword] = useState("");
  const [filePath, setFilePath] = useState(null);
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  const handleFileChange = (e) => {
    setFilePath(e.target.files[0]);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append("author_name", authorName);
    formData.append("author_title", authorTitle);
    formData.append("email", email);
    formData.append("phone", phone);
    formData.append("whatsapp", whatsapp);
    formData.append("country", country);
    formData.append("nationality", nationality);
    formData.append("password", password);
    formData.append("file_path", filePath);

    try {
      const response = await axios.post(
        `http://127.0.0.1:8000/api/con/scientific-papers/1`,
        formData,
       
      );

      setSuccessMessage(response.data.message);
      setError("");
    } catch (error) {
      setError("Failed to add scientific paper. Please try again.");
      setSuccessMessage("");
    }
  };

  return (
    <div className="form-container">
      <h2>Submit Scientific Paper</h2>
      {/* {successMessage && <p className="success">{successMessage}</p>}
      {error && <p className="error">{error}</p>} */}

      <form onSubmit={handleSubmit} encType="multipart/form-data">
        <Input
          label="Author Name"
          placeholder="Author Name"
          inputValue={authorName}
          setInputValue={setAuthorName}
          required
        />

        <Input
          label="Author Title"
          placeholder="Author Title"
          inputValue={authorTitle}
          setInputValue={setAuthorTitle}
          required
        />

        <Input
          label="Email"
          placeholder="Email"
          inputValue={email}
          setInputValue={setEmail}
          required
        />

        <PhoneNumberInput
          label="Phone"
          phone={phone}
          setPhone={setPhone}
          required
        />

        <PhoneNumberInput
          label="Whatsapp (Optional)"
          phone={whatsapp}
          setPhone={setWhatsapp}
        />

        <Select
          options={countriesOptions}
          value={country}
          setValue={setCountry}
          label="Country"
          required
        />

        <Input
          label="Nationality"
          placeholder="nationality"
          inputValue={nationality}
          setInputValue={setNationality}
          required
        />

        <Input
          label="Password"
          placeholder="Password"
          inputValue={password}
          setInputValue={setPassword}
          type="password"
          required
        />
    
        <ImageUpload
          label="Upload Paper (PDF)"
          inputValue={filePath}
          setInputValue={setFilePath}
          allowedExtensions={["pdf"]}
          //   errorMsg={errors.secondAnnouncement}
        />
        <button type="submit" className="submit-btn">Submit Paper</button>
      </form>
    </div>
  );
};

export default ScientificPaperForm;
