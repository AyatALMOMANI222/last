import React, { useState } from "react";
import axios from "axios"; // تأكد من استيراد axios
import Input from "../../../../CoreComponent/Input"; // تأكد من استيراد مكون Input بشكل صحيح
import MySideDrawer from "../../../../CoreComponent/SideDrawer";
import CustomFormWrapper from "../../../../CoreComponent/CustomFormWrapper";
import "./style.scss";
const AirportTransferPrice = () => {
  const [fromAirportPrice, setFromAirportPrice] = useState("");
  const [toAirportPrice, setToAirportPrice] = useState("");
  const [roundTripPrice, setRoundTripPrice] = useState("");
  const [isOpen, setIsOpen] = useState(true);
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const conferenceId = 1;

  const handleSubmit = async (e) => {
    e.preventDefault();
    const prices = {
      conference_id: conferenceId, // استخدم المعرف المحدد للمؤتمر
      from_airport_price: parseFloat(fromAirportPrice), // تحويل القيمة إلى عدد عشري
      to_airport_price: parseFloat(toAirportPrice), // تحويل القيمة إلى عدد عشري
      round_trip_price: parseFloat(roundTripPrice), // تحويل القيمة إلى عدد عشري
    };
    const token = localStorage.getItem("token");
    try {
      const response = await axios.post(
        `${BaseUrl}/airport-transfer-prices`,
        prices,
        {
          headers: {
            Authorization: `Bearer ${token}`, // إضافة التوكن إلى الهيدر
          },
        }
      );
      console.log("Response:", response.data);
      // يمكنك إضافة المزيد من المنطق بعد الإرسال الناجح هنا
    } catch (error) {
      console.error("There was an error submitting the prices!", error); // التعامل مع الأخطاء
    }
  };

  return (
    <div>
      <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
        <CustomFormWrapper
          title="Airport Transfer Price"
          handleSubmit={handleSubmit}
          setOpenForm={setIsOpen}
        >
          {/* <h2>Airport Transfer Price</h2> */}
          <form onSubmit={handleSubmit} className="price-airport-form9">
            <Input
              label="From Airport Price"
              inputValue={fromAirportPrice}
              setInputValue={setFromAirportPrice}
              placeholder="Enter price"
              type="number"
              step="0.01"
              required
            />
            <Input
              label="To Airport Price"
              inputValue={toAirportPrice}
              setInputValue={setToAirportPrice}
              placeholder="Enter price"
              type="number" // تأكد من أن النوع هو number
              step="0.01" // للسماح بالقيم العشرية
              required
            />
            <Input
              label="Round Trip Price"
              inputValue={roundTripPrice}
              setInputValue={setRoundTripPrice}
              placeholder="Enter price"
              type="number"
              step="0.01"
              required
            />
          </form>
        </CustomFormWrapper>
      </MySideDrawer>
    </div>
  );
};

export default AirportTransferPrice;
