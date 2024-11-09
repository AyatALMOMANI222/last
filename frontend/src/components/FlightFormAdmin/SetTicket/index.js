import React, { useEffect, useState } from "react";
import axios from "axios";
import "./style.scss";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import Input from "../../../CoreComponent/Input";
import CustomFormWrapper from "../../../CoreComponent/CustomFormWrapper";

const UpdateTicket = ({ data, setOpen }) => {
  const [ticket, setTicket] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  console.log(data);

  const flightId = data.flight_id;

  const handleSubmit = () => {
    const token = localStorage.getItem("token");

    const formData = {
      download_url: ticket,
    };

    // إرسال البيانات باستخدام axios
    axios
      .put(
        `${BaseUrl}/admin/update-flight/${flightId}`,
        formData,
        {
          headers: {
            Authorization: `Bearer ${token}`, // تضمين التوكن في الهيدر
            "Content-Type": "application/json", // تحديد نوع المحتوى
          },
        }
      )
      .then((response) => {
        console.log(response);
        setOpen(false); // إغلاق النموذج بعد الإرسال
      })
      .catch((error) => {
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

  useEffect(() => {
    console.log(flightId);
  });
  return (
    <CustomFormWrapper
      title="Ticket Information"
      handleSubmit={handleSubmit}
      setOpenForm={setOpen}
      noActions={false}
    >
      <div>
        <div>
          <Input label="Ticket" inputValue={ticket} setInputValue={setTicket} />
        </div>
      </div>
    </CustomFormWrapper>
  );
};
export default UpdateTicket;
