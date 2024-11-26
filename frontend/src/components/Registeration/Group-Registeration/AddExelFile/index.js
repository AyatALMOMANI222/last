import React, { useEffect, useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import ImageUpload from "../../../../CoreComponent/ImageUpload";
import "./style.scss";
import httpService from "../../../../common/httpService";
import { backendUrlImages } from "../../../../constant/config";

const ExcelUpload = () => {
  const [excelFile, setExcelFile] = useState(""); // حالة الملف
  const [userGroupData, setUserGroupData] = useState(null); // بيانات المستخدم
  const [showUploadForm, setShowUploadForm] = useState(true); // إظهار فورم التحميل
  const [isUpdating, setIsUpdating] = useState(false); // حالة التحديث
  const [dataLoaded, setDataLoaded] = useState(false); // حالة تتبع تحميل البيانات
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const getGroupData = async () => {
    const getAuthToken = () => localStorage.getItem("token");

    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/group`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
      });
      setUserGroupData(response.data);
      setShowUploadForm(!response.data.excel_file); // إخفاء النموذج إذا كان هناك ملف Excel موجود
      setDataLoaded(true); // تحديث حالة تحميل البيانات
    } catch (error) {
      console.error("Failed to fetch group data:", error);
      toast.error("Failed to fetch data. Please try again later.");
    }
  };

  useEffect(() => {
    // تحميل البيانات فقط إذا لم يتم تحميلها سابقًا
    if (!dataLoaded) {
      getGroupData();
    }
  }, [dataLoaded]); // يعتمد فقط على dataLoaded

  const handleUpload = async (e) => {
    e.preventDefault();

    // التحقق من وجود ملف Excel
    if (!excelFile) {
      toast.error("🚫 Please select an Excel file to upload.");
      return;
    }

    // التحقق من نوع الملف
    const allowedExtensions = ["xls", "xlsx", "csv"];
    const fileExtension = excelFile.name.split(".").pop().toLowerCase();

    if (!allowedExtensions.includes(fileExtension)) {
      toast.error(
        "⚠️ The file you uploaded is not a valid Excel file. Please upload a file of type: xlsx, csv, or xls."
      );
      return;
    }

    const formData = new FormData();
    formData.append("excel_file", excelFile);
    const token = localStorage.getItem("token");

    if (!token) {
      toast.error("User is not authenticated.");
      return;
    }

    try {
      const url = `${BaseUrl}/update/user`; // استخدام URL ثابت

      const response = await axios({
        method: "POST",
        url,
        data: formData,
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${token}`,
        },
      });

      toast.success("Excel file uploaded successfully!");

      // تحديث بيانات المستخدم بالاستجابة من الخادم
      setUserGroupData(response.data); // تحديث البيانات بدون ريفرش
      setShowUploadForm(false); // إخفاء النموذج بعد التحميل
      setIsUpdating(false); // إنهاء حالة التحديث
      setExcelFile(""); // إعادة تعيين ملف Excel
      setDataLoaded(false); // إعادة تعيين حالة تحميل البيانات بعد التحديث
    } catch (error) {
      if (error.response) {
        toast.error(error.response.data.error);
      } else {
        toast.error("Something went wrong, please try again.");
      }
    }
  };

  const isUpdateDeadlinePassed =
    userGroupData && new Date() > new Date(userGroupData.update_deadline);

  return (
    <div className="excel-upload-container">
      {showUploadForm ? (
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
        </form>
      ) : (
        <div className="file-display-container">
          <h2>Uploaded Excel File</h2>
          {/* <a
            href={userGroupData.excel_file} // تأكد من أن هذا المسار صحيح
            download
            className="file-download-link"
          >
            Download Excel File
          </a> */}
          <a
            href={`${backendUrlImages}/${userGroupData.excel_file}`}
            download
            className="file-download-link"
          >
            Download Excel File
          </a>

        {userGroupData.update_deadline && <p>Update Deadline: {userGroupData.update_deadline}</p>}
          {/* إضافة شرط لإخفاء الجملة إذا كان الموعد النهائي قد انقضى */}
          {!isUpdateDeadlinePassed && (
            <p>
              After this deadline, you won’t be able to modify or send any
              updated list.
            </p>
          )}
          {/* إضافة شرط لإخفاء الزر إذا كان الموعد النهائي قد انقضى */}
          {!isUpdateDeadlinePassed && !isUpdating && (
            <button
              onClick={() => setIsUpdating(true)} // يقوم بتفعيل حالة التحديث
              className="update-btn"
            >
              Update
            </button>
          )}
        </div>
      )}

      {isUpdating && (
        <form onSubmit={handleUpload} className="excel-upload-form">
          <ImageUpload
            inputValue={excelFile}
            label="Upload New Excel File"
            allowedExtensions={["xls", "xlsx"]}
            setInputValue={setExcelFile}
          />
          <button type="submit" className="upload-btn">
            Submit Update
          </button>
        </form>
      )}
    </div>
  );
};

export default ExcelUpload;
