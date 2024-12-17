import React, { useState } from "react";
import axios from "axios";
import "./style.scss";
import { useParams } from "react-router-dom";
import Input from "../../CoreComponent/Input"; // استيراد المدخل المخصص
import DateInput from "../../CoreComponent/Date";

const GroupTripRegistration = () => {
  // حالة لتخزين المدخلات
  const { tripId } = useParams(); // افتراضيًا 3
  const [selectedDate, setSelectedDate] = useState("2024-12-10");
  const [companionsCount, setCompanionsCount] = useState(3);
  const [totalPrice, setTotalPrice] = useState(null);
  const [error, setError] = useState("");
  const [submitted, setSubmitted] = useState(false); // حالة لتتبع ما إذا كان النموذج قد تم تقديمه

  const token = localStorage.getItem("token");

  // دالة لإرسال البيانات إلى API وحساب total_price
  const handleSubmit = async (e) => {
    e.preventDefault();
    const token = localStorage.getItem("token");

    try {
      const response = await axios.post(
        "http://127.0.0.1:8000/api/group-trip-participants",
        {
          trip_id: tripId,
          selected_date: selectedDate,
          companions_count: companionsCount,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`, // تأكد من تضمين التوكن هنا
          },
        }
      );

      // حفظ total_price بعد الحصول عليه من الرد
      setTotalPrice(response.data.participant.total_price);
      setSubmitted(true); // تغيير حالة submitted عند النجاح
    } catch (error) {
      // التعامل مع الأخطاء
      if (error.response) {
        // إذا كانت هناك استجابة من الخادم
        setError(error.response.data.message || "حدث خطأ في الطلب");
      } else {
        setError("حدث خطأ في الاتصال بالخادم");
      }
    }
  };

  return (
    <div className="registration-container">
      <h2>Group Trip Registration</h2>

      {/* إذا تم إرسال البيانات بنجاح، عرض السعر فقط */}
      {submitted ? (
        <div className="result">
          <h3>Total Price: {totalPrice} $</h3>
        </div>
      ) : (
        // نموذج المدخلات فقط إذا لم يتم إرسال البيانات بعد
        <form onSubmit={handleSubmit} className="registration-form">
          <div className="form-group9">
            <DateInput
              inputValue={selectedDate}
              setInputValue={setSelectedDate}
              label={"Selected Date"}
            />
            <Input
              label={"Companions Count"}
              type="number"
              inputValue={companionsCount}
              setInputValue={setCompanionsCount}
            />
          </div>

          <button type="submit" className="submit-button">
            Submit
          </button>
        </form>
      )}

      {/* عرض الأخطاء في حال وجودها */}
      {error && <p className="error-message">{error}</p>}
    </div>
  );
};

export default GroupTripRegistration;
