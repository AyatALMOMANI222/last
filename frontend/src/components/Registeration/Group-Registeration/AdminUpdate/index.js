import React, { useState } from "react";
import axios from "axios"; // استيراد axios
import "./style.scss"; // استيراد ملف Sass
import DateInput from "../../../../CoreComponent/Date";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
import { useParams } from "react-router-dom";
const AdminGroupComponent = () => {
  const [startDate, setStartDate] = useState("");
  const [isActive, setIsActive] = useState(false);
  const [isDisabled, setIsDisabled] = useState(false);
  const [isLoading, setIsLoading] = useState(false); // إضافة حالة التحميل
  const {register_id} = useParams();
  const token = localStorage.getItem("token");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

const navigate=useNavigate()
  const handleYesNoClick = (answer) => {
    setIsActive(answer === "yes");
    setIsDisabled(true);
  };

  const handleSubmit = async () => {
    setIsLoading(true); // تعيين حالة التحميل إلى true
    try {
      const response = await axios.put(
        `${BaseUrl}/group/update/admin/${register_id}`,
        {
          is_active: isActive,
          update_deadline: startDate,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        }
      );
      console.log("Response:", response.data);
      toast.success("Group Updated Successfully!");
      
      navigate("/home")
    } catch (error) {
      console.error("Error updating group:", error);
      toast.error("Failed to Update the Group: " + error);
    } finally {
      setIsLoading(false); // تعيين حالة التحميل إلى false بعد الانتهاء
    }
  };

  return (
    <div className="admin-update-container">
      <h2>Do you accept adding the group?</h2>

      <button onClick={() => handleYesNoClick("yes")} disabled={isDisabled}>
        YES
      </button>
      <button onClick={() => handleYesNoClick("no")} disabled={isDisabled}>
        NO
      </button>

      {isActive && (
        <div className="date-input-container">
          <DateInput
            label="Update Deadline"
            placeholder="YYYY-MM-DD"
            inputValue={startDate}
            setInputValue={setStartDate}
            required
          />
          <button className="submit-btn" onClick={handleSubmit} disabled={isLoading}>
            {isLoading ? "Submitting..." : "Submit"} {/* عرض حالة التحميل */}
          </button>
        </div>
      )}
    </div>
  );
};


export default AdminGroupComponent;
