import React, { useState } from "react";
import axios from "axios";

import ImageUpload from "../../CoreComponent/ImageUpload";

import "./style.scss"
import Input from "../../CoreComponent/Input";
const ClientAdmin = () => {
  const [description, setDescription] = useState("");
  const [logo, setLogo] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const token =localStorage.getItem("token")
    const formData = new FormData();
    formData.append("description", description);
    if (logo) formData.append("image", logo);
    
    try {
      setLoading(true);
      const token = "YOUR_TOKEN"; // هنا ضع التوكن الخاص بك
      const response = await axios.post("http://127.0.0.1:8000/api/clients", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Data submitted successfully:", response.data);
      // إعادة تعيين الحقول بعد النجاح
      setDescription("");
      setLogo(null);
    } catch (err) {
      setError("An error occurred. Please try again.");
      console.error("Submission error:", err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="submit-paper-container">
      <form onSubmit={handleSubmit} encType="multipart/form-data">
      <ImageUpload
          label="Logo"
          inputValue={logo}
          setInputValue={setLogo}
          allowedExtensions={["jpg", "jpeg", "png", "gif"]}
        />
        <Input
          label="Description"
          placeholder="Description"
          inputValue={description}
          setInputValue={setDescription}
          required
        />

     

        <button type="submit" className="submit-btn" disabled={loading}>
          {loading ? "Submitting..." : "Submit Paper"}
        </button>

        {error && <div className="error-message">{error}</div>}
      </form>
    </div>
  );
};

export default ClientAdmin;
