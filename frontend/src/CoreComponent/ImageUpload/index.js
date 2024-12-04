import React, { useState, useRef, useEffect } from "react";
import SVG from "react-inlinesvg";
import { linkIcon, deleteIcon, downloadIcon } from "../../icons"; // Ensure downloadIcon is imported
import "./style.scss";
import { backendUrlImages } from "../../constant/config";
import defaultFileImage from "../../icons/fileIcon.svg";

const ImageUpload = ({
  errorMsg,
  required = true,
  label = "Upload File",
  allowedExtensions = [],
  inputValue,
  setInputValue,
  existingFile, // مسار الملف القديم
}) => {
  const fileInputRef = useRef(null);
  const [fileName, setFileName] = useState("");
  const [fileURL, setFileURL] = useState(null); // URL للمعاينة
  const [imageError, setImageError] = useState(false); // Track image loading error

  const handleImageError = () => {
    setImageError(true); 
  };
  // إذا كان هناك ملف قديم، استخدمه
  useEffect(() => {
    if (existingFile) {
      console.log(`${backendUrlImages}${existingFile}`);

      setFileName(existingFile.split("/").pop()); // استخراج اسم الملف من المسار
      setFileURL(`${backendUrlImages}${existingFile}`); // تأكد من أنه يتم استخدام المسار بشكل صحيح
    }
  }, [existingFile]);

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
        setInputValue(file); // حفظ الملف الجديد
        setFileURL(URL.createObjectURL(file)); // إنشاء URL للمعاينة
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

  const handleDownload = () => {
    if (fileURL) {
      const link = document.createElement("a"); // Create a link element
      link.href = fileURL; // Set the href to the file URL
      link.download = fileName; // Set the download attribute with the file name
      link.click(); // Programmatically click the link to trigger the download
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
            height={30}
            width={30}
            aria-label="Upload File"
          />
        </div>
        {errorMsg && <span className="error-msg-container">{errorMsg}</span>}
        {(fileName || fileURL) && (
          <div className="img-container">
            {/* <img className="img" src={fileURL} alt={fileName} /> */}

            <img
              className="img"
              src={imageError ? defaultFileImage : fileURL} // If imageError is true, show the default image
              alt={fileName}
              onError={handleImageError} // If image fails to load, trigger handleImageError
            />

            <div className="actions-container">
              <SVG
                className="delete-icon"
                src={deleteIcon}
                onClick={handleDelete}
                height={20}
                width={20}
                aria-label="Delete File"
              />
              <SVG
                className="download-icon"
                src={downloadIcon}
                onClick={handleDownload}
                height={20}
                width={20}
                aria-label="Download File"
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default ImageUpload;
