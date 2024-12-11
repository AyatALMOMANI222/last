import React, { useState } from "react";
import axios from "axios";
import "./style.scss";
import ImageUpload from "../../CoreComponent/ImageUpload";
import { toast } from "react-toastify";

const AddClient = () => {
  const [image, setImage] = useState(null);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);

  // Handler for file input
  const handleFileChange = (e) => {
    const file = e.target.files[0];
    if (file && file.type.startsWith("image/")) {
      setImage(file);
      setError(null);
    } else {
      setError("Please upload a valid image.");
    }
  };

  // Handler for form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!image) {
      setError("Please select an image to upload.");
      return;
    }

    const formData = new FormData();
    formData.append("image", image);

    try {
      const token = localStorage.getItem("token");
      const BaseUrl = process.env.REACT_APP_BASE_URL;

      const response = await axios.post(
        `${BaseUrl}/clients`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      if (response.status === 200) {
        toast.success("Client created successfully!");

        setSuccess(true);
        setImage(null);
        setError(null);
      }
    } catch (error) {
      setError("An error occurred while uploading the image.");
    }
  };

  return (
    <div className="add-client">
      <h2>Add Client Image</h2>
      <form onSubmit={handleSubmit} className="form">
        <ImageUpload
        label="Upload Image"
        inputValue={image}
        setInputValue={setImage}
        allowedExtensions={["jpg", "jpeg", "png", "gif"]}

        />
        {/* <div className="form-group">
          <label htmlFor="image">Upload Image</label>
          <input
            type="file"
            id="image"
            accept="image/*"
            onChange={handleFileChange}
          />
          {error && <p className="error">{error}</p>}
        </div> */}
        <button type="submit" className="submit-btn">
          Upload
        </button>
      </form>
      {success && <p className="success">Image uploaded successfully!</p>}
    </div>
  );
};

export default AddClient;
