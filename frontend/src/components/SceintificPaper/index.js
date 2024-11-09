import React, { useState } from "react";
import axios from "axios";
import ImageUpload from "../../CoreComponent/ImageUpload";
import Input from "../../CoreComponent/Input";
import PhoneNumberInput from "../../CoreComponent/PhoneNumber"; // تأكد من استيراد المكون

const AddScientificPaper = () => {
  const [authorName, setAuthorName] = useState("");
  const [authorTitle, setAuthorTitle] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [whatsapp, setWhatsapp] = useState("");
  const [country, setCountry] = useState("");
  const [nationality, setNationality] = useState("");
  const [password, setPassword] = useState("");
  const [file, setFile] = useState(null);
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const handleSubmit = async () => {
    const formData = new FormData();
    formData.append("conference_id", 19);
    formData.append("author_name", authorName);
    formData.append("author_title", authorTitle);
    formData.append("email", email);
    formData.append("phone", phone);
    formData.append("whatsapp", whatsapp);
    formData.append("country", country);
    formData.append("nationality", nationality);
    formData.append("password", password);
    formData.append("file_path", file);

    try {
      const response = await axios.post(`${BaseUrl}papers`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      alert("Paper submitted successfully!");
    } catch (error) {
      console.error("Error submitting paper", error);
      alert("Error submitting paper. Please try again.");
    }
  };

  return (
    <div className="conference-form-admin">
      <div className="header-conference-form">Submit Scientific Paper</div>
      <div className="form-section">
        <Input
          label="Author Name"
          placeholder="Enter author name"
          inputValue={authorName}
          setInputValue={setAuthorName}
          type="text"
          required
        />
        <Input
          label="Author Title"
          placeholder="Enter author title"
          inputValue={authorTitle}
          setInputValue={setAuthorTitle}
          type="text"
          required
        />
        <Input
          label="Email"
          placeholder="Enter email"
          inputValue={email}
          setInputValue={setEmail}
          type="email"
          required
        />
        <PhoneNumberInput
          label="Phone Number"
          phone={phone}
          setPhone={setPhone}
          required={true}
        />
        <PhoneNumberInput
          label="WhatsApp Number"
          phone={whatsapp}
          setPhone={setWhatsapp}
          required={true}
        />
        <Input
          label="Country"
          placeholder="Enter country"
          inputValue={country}
          setInputValue={setCountry}
          type="text"
          required
        />
        <Input
          label="Nationality"
          placeholder="Enter nationality"
          inputValue={nationality}
          setInputValue={setNationality}
          type="text"
          required
        />
        <Input
          label="Password"
          placeholder="Enter password"
          inputValue={password}
          setInputValue={setPassword}
          type="password"
          required
        />
        <ImageUpload
          label="Upload Paper File"
          inputValue={file}
          setInputValue={setFile}
          allowedExtensions={["pdf"]}
          required
        />
      </div>
      <div className="actions-section-container">
        <button className="submit-btn" onClick={handleSubmit}>
          Submit
        </button>
      </div>
    </div>
  );
};

export default AddScientificPaper;
