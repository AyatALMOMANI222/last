import React, { useState, useRef } from "react";
import SVG from "react-inlinesvg";
import { linkIcon, deleteIcon } from "../../icons";
import "./style.scss";

const ImageUpload = ({
  errorMsg,
  required = true,
  label = "Upload File",
  allowedExtensions = [],
  inputValue,
  setInputValue,
}) => {
  const fileInputRef = useRef(null);
  const [fileName, setFileName] = useState("");
  const [fileURL, setFileURL] = useState(null); // URL for preview

  const handleDelete = () => {
    setInputValue(null);
    setFileName("");
    setFileURL(null);
  };

  const handleChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const fileExtension = file.name.split(".").pop().toLowerCase();
      if (allowedExtensions.includes(fileExtension)) {
        setFileName(file.name);
        setInputValue(file); // Save the file object directly
        setFileURL(URL.createObjectURL(file)); // Create a URL for previewing the image
      } else {
        alert(
          `Invalid file type. Allowed extensions are: ${allowedExtensions.join(
            ", "
          )}`
        );
        setInputValue(null);
        setFileName("");
        setFileURL(null);
      }
    }
  };

  const handleClick = () => {
    if (fileInputRef.current) {
      fileInputRef.current.click();
    }
  };

  return (
    <div className="image-upload-container">
      {label && (
        <div className="label-container">
          <span>{label}</span>
          {required && <span className="star">*</span>}
        </div>
      )}
      <div className={`img-upload-container ${errorMsg ? "error-msg" : ""}`}>
        <input
          ref={fileInputRef}
          type="file"
          className="upload-file"
          accept={allowedExtensions.map((ext) => `.${ext}`).join(",")}
          onChange={handleChange}
          style={{ display: "none" }}
          value={""}
        />
        <div className="upload-img-container" onClick={handleClick}>
          <div className="placholder">
            {fileName ? (
              <span className="file-name">{fileName}</span>
            ) : (
              "Upload"
            )}
          </div>
          <SVG
            className="link-icon"
            src={linkIcon}
            height={20}
            width={20}
            aria-label="Upload File"
          />
        </div>
        {errorMsg && <span className="error-msg-container">{errorMsg}</span>}
        {fileName && fileURL && (
          <div className="img-container">
            <img className="img" src={fileURL} alt={fileName} />
            <div className="actions-container">
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={handleDelete}
                height={20}
                width={20}
                aria-label="Delete File"
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default ImageUpload;
