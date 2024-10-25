import React, { useState } from "react";
import axios from "axios";
import DateInput from "../../../CoreComponent/Date";
import "./style.scss";

const UpdateDeadline = ({ data, setOpen }) => {

  const [adminUpdateDeadline, setAdminUpdateDeadline] = useState("");

console.log(data);

const flightId =data.flight_id
const handleSubmit = () => {
    const token = localStorage.getItem('token'); 
  
    const formData = {
      admin_update_deadline: adminUpdateDeadline
    };
  
    // إرسال البيانات باستخدام axios
    axios.put(`http://127.0.0.1:8000/api/admin/update-flight/${flightId}`, formData, {
      headers: {
        'Authorization': `Bearer ${token}`, // تضمين التوكن في الهيدر
        'Content-Type': 'application/json'  // تحديد نوع المحتوى
      }
    })
    .then(response => {
      console.log(response);
      setOpen(false); // إغلاق النموذج بعد الإرسال
    })
    .catch(error => {
      if (error.response) {
        // الطلب تم إرساله ولكن الخادم أعاد استجابة بخطأ
        console.error("Error data:", error.response.data);
        console.error("Error status:", error.response.status);
        console.error("Error headers:", error.response.headers);
      } else if (error.request) {
        // الطلب تم إرساله ولكن لم يتم تلقي استجابة
        console.error("No response received:", error.request);
      } else {
        // حدث خطأ أثناء إعداد الطلب
        console.error("Error setting up request:", error.message);
      }
    });
  };
  
  
  return (
    <div className="add-trip-admin">
      <div className="form-section">
      
        <DateInput
          label="Update Deadline"
          placeholder="Enter Admin Update Deadline"
          inputValue={adminUpdateDeadline}
          setInputValue={setAdminUpdateDeadline}
          required={true}
        />
       
      </div>
      <div className="actions-section-container">
        <button
          className="cancel-btn"
          onClick={() => {
            setOpen(false);
          }}
        >
          Cancel
        </button>
        <button className="submit-btn" onClick={handleSubmit}>Submit</button>
      </div>
    </div>
  );
};
export default UpdateDeadline;
