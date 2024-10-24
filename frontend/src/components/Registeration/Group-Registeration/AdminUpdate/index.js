import React, { useState } from 'react';
import axios from 'axios'; // استيراد axios
import './style.scss'; // استيراد ملف Sass
import DateInput from '../../../../CoreComponent/Date';

const AdminGroupComponent = () => {
//   const [acceptGroup, setAcceptGroup] = useState(null); // لتحديد هل ضغط المستخدم YES أم NO
  const [startDate, setStartDate] = useState(''); // تخزين التاريخ المدخل
  const [isActive, setIsActive] = useState(false); // لتحديد حالة is_active
  const userId = 3; // معرف المستخدم الثابت
//   سيؤخذ من الاشعار 
  const token = localStorage.getItem('token'); // جلب الـ token من localStorage


  const handleYesNoClick = (answer) => {
    setIsActive(answer === 'yes'); // تحديث حالة is_active حسب الجواب
  };

  const handleSubmit = async () => {
    try {
      const response = await axios.put(
        'http://127.0.0.1:8000/api/update/Admin/group',
        {
          user_id: userId,
          is_active: isActive,
          update_deadline: startDate,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`, // إضافة التوكن للـ headers
            'Content-Type': 'application/json',
          },
        }
      );
      console.log('Response:', response.data);
      // يمكن إضافة رسالة نجاح أو إعادة توجيه
    } catch (error) {
      console.error('Error updating group:', error);
      // يمكن إضافة رسالة خطأ
    }
  };

  return (
    <div className="container">
      <h2>هل تقبل إضافة المجموعة؟</h2>
      <button onClick={() => handleYesNoClick('yes')}>YES</button>
      <button onClick={() => handleYesNoClick('no')}>NO</button>

      {/* إذا ضغط المستخدم YES، نعرض له حقل التاريخ */}
      {isActive && (
        <div className="date-input-container">
          <DateInput
            label="Update Deadline"
            placeholder="YYYY-MM-DD"
            inputValue={startDate}
            setInputValue={setStartDate}
            required
          />
          {/* زر إرسال المعلومات */}
          <button className="submit-btn" onClick={handleSubmit}>
            Submit
          </button>
        </div>
      )}
    </div>
  );
};

export default AdminGroupComponent;
