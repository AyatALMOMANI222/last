import React, { useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import ImageUpload from "../../../../CoreComponent/ImageUpload";
import "./style.scss";

const ExcelUpload = () => {
  const [excelFile, setExcelFile] = useState(""); // حالة الملف
  const [error, setError] = useState(""); // حالة الخطأ

  const handleUpload = async (e) => {
    e.preventDefault();

    if (!excelFile) {
      toast.error("Please select an Excel file to upload.");
      return;
    }

    const formData = new FormData();
    formData.append("excel_file", excelFile); // إضافة الملف إلى FormData
    const token = localStorage.getItem("token");
    console.log(token);
    
    if (!token) {
      toast.error("User is not authenticated.");
      return;
    }
console.log(excelFile);

    try {
      const response = await axios.post(
        `http://127.0.0.1:8000/api/update/user`, // عنوان الـ API
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${token}`, // إضافة التوكن إلى رأس الطلب
          },
        }
      );
      toast.success("Excel file uploaded successfully!");
      console.log(response);
    } catch (error) {
      if (error.response) {
        toast.error(error.response.data.error);
      } else {
        toast.error("Something went wrong, please try again.");
      }
    }
  };

  return (
    <form onSubmit={handleUpload} className="excel-upload-form">
      <ImageUpload
        inputValue={excelFile}
        label="Upload Excel File"
        allowedExtensions={["xls", "xlsx"]}
        setInputValue={setExcelFile}
      />
      <button type="submit" className="upload-btn">
        Upload
      </button>
      {error && <p className="error-message">{error}</p>}
    </form>
  );
};

export default ExcelUpload;
