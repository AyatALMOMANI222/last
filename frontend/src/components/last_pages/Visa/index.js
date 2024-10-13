import React, { useState } from "react";
import axios from "axios";
import { useParams } from "react-router-dom";
import { toast } from "react-toastify";
import Input from "../../../CoreComponent/Input";
import ImageUpload from "../../../CoreComponent/ImageUpload"; // استيراد مكون ImageUpload
import DateInput from "../../../CoreComponent/Date"; // استيراد مكون DateInput

const VisaPage = () => {
  const { userId } = useParams(); // الحصول على معرف المستخدم من عنوان URL
  const [passportImage, setPassportImage] = useState(null); // حالة الصورة
  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const userId = localStorage.getItem("user_id"); // استرجاع معرف المستخدم من التخزين المحلي
    const token = localStorage.getItem("token"); // استرجاع الرمز من التخزين المحلي

    const formData = new FormData();
    formData.append("user_id", userId);
    formData.append("passport_image", passportImage); // تأكد من أن passportImage هو ملف
    formData.append("arrival_date", arrivalDate);
    formData.append("departure_date", departureDate);

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/visa",
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${token}`, // تمرير الرمز في الهيدر
          },
        }
      );
      toast.success(response.data.message); // عرض رسالة نجاح
    } catch (error) {
      if (error.response) {
        setError(error.response.data.message || "An error occurred");
      } else {
        setError("An error occurred");
      }
    }
  };

  return (
    <div className="visa-page-container">
      <h2>Register New Visa</h2>
      <form onSubmit={handleSubmit} className="visa-form">
        <div className="fields-container">
          <ImageUpload
            label="Upload Passport Image"
            inputValue={passportImage}
            setInputValue={setPassportImage} // تأكد من أن هذه الدالة معرّفة بشكل صحيح في مكون ImageUpload
            allowedExtensions={["jpg", "jpeg", "png", "pdf"]} // تحديد أنواع الملفات المسموح بها
            required
          />

          <DateInput
            label="Arrival Date"
            placeholder="YYYY-MM-DD"
            inputValue={arrivalDate}
            setInputValue={setArrivalDate}
            required
          />

          <DateInput
            label="Departure Date"
            placeholder="YYYY-MM-DD"
            inputValue={departureDate}
            setInputValue={setDepartureDate}
            required
          />
          
          {error && <span className="error-msg">{error}</span>}
        </div>
        <button type="submit" className="submit-btn">
          Submit
        </button>
      </form>
    </div>
  );
};

export default VisaPage;
