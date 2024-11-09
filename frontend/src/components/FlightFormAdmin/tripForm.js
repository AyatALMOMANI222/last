import React, { useState } from "react";
import Input from "../../CoreComponent/Input";
import DateInput from "../../CoreComponent/Date";
import Checkbox from "../../CoreComponent/Checkbox";
import axios from "axios";
import "./style.scss";

const AddTripForm = ({ data, setOpen }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [departureDate, setDepartureDate] = useState("");
  const [departureTime, setDepartureTime] = useState("");
  const [price, setPrice] = useState("");
  const [isFree, setIsFree] = useState(false);



  const handleSubmit = () => {
    const token = localStorage.getItem('token'); 
  
    const formData = {
      flight_id: data.flight_id, // استخدام flight_id من props
      departure_date: departureDate,
      departure_time: departureTime,
      price: price,
      is_free: isFree,
    };

    // إرسال البيانات باستخدام axios
    axios.post(`${BaseUrl}/available-flights`, formData, {
      headers: {
        'Authorization': `Bearer ${token}`, // تضمين التوكن في الهيدر
        'Content-Type': 'application/json'  // تحديد نوع المحتوى
      }
    })
    .then(response => {
      // يمكنك التعامل مع النجاح هنا مثل إغلاق النموذج أو عرض رسالة نجاح
      setOpen(false); // إغلاق النموذج بعد الإرسال
    })
    .catch(error => {
      // يمكنك التعامل مع الخطأ هنا مثل عرض رسالة خطأ
    });
  };
  
  return (
    <div className="add-trip-admin">
      {/* <div className="header">{data.passenger_name}</div> */}
      <div className="form-section">
    
        <DateInput
          label="Departure Date"
          placeholder="Enter departure date"
          inputValue={departureDate}
          setInputValue={setDepartureDate}
          required={true}
        />
        <Input
          label="Departure Time"
          placeholder="Enter departure time"
          inputValue={departureTime}
          setInputValue={setDepartureTime}
          type="time"
          required={true}
        />
        <Input
          label="Price"
          placeholder="Enter price"
          inputValue={price}
          setInputValue={setPrice}
          type="number"
          required={true}
        />
        <Checkbox
          label="Is Free?"
          checkboxValue={isFree}
          setCheckboxValue={setIsFree}
          icon={""}
          errorMsg={""}
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
export default AddTripForm;
