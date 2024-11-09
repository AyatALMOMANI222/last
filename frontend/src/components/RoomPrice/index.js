import React, { useState } from "react";
import axios from "axios";
import Input from "../../CoreComponent/Input"; // تأكد من تعديل المسار حسب مكان وجود الملف
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import "./style.scss"
import httpService from "../../common/httpService";
const RoomPriceForm = () => {
  const [singleBasePrice, setSingleBasePrice] = useState("");
  const [singleCompanionPrice, setSingleCompanionPrice] = useState("");
  const [singleEarlyCheckInPrice, setSingleEarlyCheckInPrice] = useState("");
  const [singleLateCheckOutPrice, setSingleLateCheckOutPrice] = useState("");
  const [doubleBasePrice, setDoubleBasePrice] = useState("");
  const [doubleCompanionPrice, setDoubleCompanionPrice] = useState("");
  const [doubleEarlyCheckInPrice, setDoubleEarlyCheckInPrice] = useState("");
  const [doubleLateCheckOutPrice, setDoubleLateCheckOutPrice] = useState("");
  const [tripleBasePrice, setTripleBasePrice] = useState("");
  const [tripleCompanionPrice, setTripleCompanionPrice] = useState("");
  const [tripleEarlyCheckInPrice, setTripleEarlyCheckInPrice] = useState("");
  const [tripleLateCheckOutPrice, setTripleLateCheckOutPrice] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const navigate = useNavigate();

  const handleRegister2 = async (e) => {
    e.preventDefault();
  
    const token = localStorage.getItem("token"); // استرجاع التوكن
  
    try {
      const response = await httpService({
        method: "POST",
        url: `${BaseUrl}/room-prices`,
        headers: {
          Authorization: `Bearer ${token}`,
        },
        data: {
          conference_id: 1, // إضافة conference_id بقيمة ثابتة
          single_base_price: singleBasePrice,
          single_companion_price: singleCompanionPrice,
          single_early_check_in_price: singleEarlyCheckInPrice,
          single_late_check_out_price: singleLateCheckOutPrice,
          double_base_price: doubleBasePrice,
          double_companion_price: doubleCompanionPrice,
          double_early_check_in_price: doubleEarlyCheckInPrice,
          double_late_check_out_price: doubleLateCheckOutPrice,
          triple_base_price: tripleBasePrice,
          triple_companion_price: tripleCompanionPrice,
          triple_early_check_in_price: tripleEarlyCheckInPrice,
          triple_late_check_out_price: tripleLateCheckOutPrice,
        },
        onSuccess: (data) => {
          toast.success(data.success);
        //   navigate("/somewhere"); // تحديد المسار بعد النجاح
        },
        onError: (err) => {
          toast.error(err);
        },
      });
    } catch (error) {
      toast.error("An error occurred while adding room prices.");
    }
  };
  

  return (
    <div className="register-page-container">
      <form onSubmit={handleRegister2} className="register-form">
        <div className="title">
          <span>Room Price Form</span>
        </div>

        <div className="fields-container">
          <Input
            label={"Single Base Price"}
            placeholder={"Enter single base price"}
            inputValue={singleBasePrice}
            setInputValue={setSingleBasePrice}
            required={true}
          />
          <Input
            label={"Single Companion Price"}
            placeholder={"Enter single companion price"}
            inputValue={singleCompanionPrice}
            setInputValue={setSingleCompanionPrice}
            required={true}
          />
          <Input
            label={"Single Early Check-in Price"}
            placeholder={"Enter early check-in price"}
            inputValue={singleEarlyCheckInPrice}
            setInputValue={setSingleEarlyCheckInPrice}
            required={true}
          />
          <Input
            label={"Single Late Check-out Price"}
            placeholder={"Enter late check-out price"}
            inputValue={singleLateCheckOutPrice}
            setInputValue={setSingleLateCheckOutPrice}
            required={true}
          />
          <Input
            label={"Double Base Price"}
            placeholder={"Enter double base price"}
            inputValue={doubleBasePrice}
            setInputValue={setDoubleBasePrice}
            required={true}
          />
          <Input
            label={"Double Companion Price"}
            placeholder={"Enter double companion price"}
            inputValue={doubleCompanionPrice}
            setInputValue={setDoubleCompanionPrice}
            required={true}
          />
          <Input
            label={"Double Early Check-in Price"}
            placeholder={"Enter early check-in price"}
            inputValue={doubleEarlyCheckInPrice}
            setInputValue={setDoubleEarlyCheckInPrice}
            required={true}
          />
          <Input
            label={"Double Late Check-out Price"}
            placeholder={"Enter late check-out price"}
            inputValue={doubleLateCheckOutPrice}
            setInputValue={setDoubleLateCheckOutPrice}
            required={true}
          />
          <Input
            label={"Triple Base Price"}
            placeholder={"Enter triple base price"}
            inputValue={tripleBasePrice}
            setInputValue={setTripleBasePrice}
            required={true}
          />
          <Input
            label={"Triple Companion Price"}
            placeholder={"Enter triple companion price"}
            inputValue={tripleCompanionPrice}
            setInputValue={setTripleCompanionPrice}
            required={true}
          />
          <Input
            label={"Triple Early Check-in Price"}
            placeholder={"Enter early check-in price"}
            inputValue={tripleEarlyCheckInPrice}
            setInputValue={setTripleEarlyCheckInPrice}
            required={true}
          />
          <Input
            label={"Triple Late Check-out Price"}
            placeholder={"Enter late check-out price"}
            inputValue={tripleLateCheckOutPrice}
            setInputValue={setTripleLateCheckOutPrice}
            required={true}
          />
        </div>

        <div className="register-btn-container">
          <button className="register-btn" type="submit">
            Add Room Prices
          </button>
        </div>
      </form>
    </div>
  );
};

export default RoomPriceForm;
