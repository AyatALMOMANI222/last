import React, { useState } from "react";
import axios from "axios"; // تأكد من استيراد axios
import Input from "../../CoreComponent/Input";
import "./style.scss";

const SeatCostForm = ({ setOpen, data }) => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const [seatCost, setSeatCost] = useState("");
  const [upgradeClassCost, setUpgradeClassCost] = useState("");
  const [additionalRequestsCost, setAdditionalRequestsCost] = useState("");
  const [baseTicketPrice, setBaseTicketPrice] = useState("");
console.log(data);

  const handleSubmit = async (event) => {
    event.preventDefault();
    const formData = {
      reserved_seat_cost: seatCost, // تأكد من استخدام الأسماء الصحيحة
      business_class_upgrade_cost: upgradeClassCost,
      additional_baggage_cost: additionalRequestsCost,
      base_ticket_price: baseTicketPrice,
      
    };

    try {
      // الحصول على التوكن من localStorage
      const token = localStorage.getItem("token");

      // إرسال الطلب باستخدام axios
      const response = await axios.put(`${BaseUrl}/admin/update-flight/${data.flight_id}`, formData, {
        headers: {
          Authorization: `Bearer ${token}`, // تضمين التوكن في الهيدر
          "Content-Type": "application/json", // تأكد من تعيين نوع المحتوى بشكل صحيح
        },
      });

      // يمكنك هنا التعامل مع الاستجابة كما تريد
      console.log(response.data);
      setOpen(false); // إغلاق النموذج بعد النجاح
    } catch (error) {
      console.error("Error updating flight:", error);
      // يمكنك هنا إضافة معالجة الأخطاء (مثل عرض رسالة خطأ)
    }
  };

  return (
    <div className="cost-form-container">
      <div className="header">Add Cost</div>
      <form onSubmit={handleSubmit}>
        <div className="form-section">
        <Input
            label="Base Ticket Price"
            placeholder="Enter Base Ticket Price"
            inputValue={baseTicketPrice}
            setInputValue={setBaseTicketPrice}
            type="text"
            required={true}
          />
          <Input
            label="Seat Cost"
            placeholder="Enter Seat Cost"
            inputValue={seatCost}
            setInputValue={setSeatCost}
            type="text"
            required={true}
          />
          <Input
            label="Upgrade Class Cost"
            placeholder="Enter Upgrade Class Cost"
            inputValue={upgradeClassCost}
            setInputValue={setUpgradeClassCost}
            type="text"
            required={true}
          />
          <Input
            label="Additional Requests Cost"
            placeholder="Enter Additional Requests Cost"
            inputValue={additionalRequestsCost}
            setInputValue={setAdditionalRequestsCost}
            type="text"
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
          <button className="submit-btn" type="submit">
            Submit
          </button>
        </div>
      </form>
    </div>
  );
};

export default SeatCostForm;
