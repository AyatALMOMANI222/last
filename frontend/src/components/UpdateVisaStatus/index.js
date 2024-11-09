import React, { useState } from "react";
import "./style.scss"; // تأكد من أن لديك تنسيق CSS مناسب
import Select from "../../CoreComponent/Select";
import httpService from "../../common/httpService";
import { toast } from "react-toastify";
import { useParams } from "react-router-dom";
const UpdateVisaStatus = () => {
  const [status, setStatus] = useState("pending"); // الحالة الافتراضية
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [loading, setLoading] = useState(false); // متغير لتحميل الحالة
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const { registerId } = useParams();

  const handleUpdate = async () => {
    setLoading(true); // بدء التحميل
    const token = localStorage.getItem("token"); // الحصول على التوكن من التخزين المحلي

    try {
      const response = await httpService({
        method: "POST",
        url: `${BaseUrl}/admin/update-visa/${registerId}`,
        headers: {
          Authorization: `Bearer ${token}`,
        },
        data: {
          status: status.value,
        },
        showLoader: true,
        withToast: true,
      });
      toast.success("The Data Updated Successfully");

      setSuccess(response.data.success); // تخزين الرسالة الناجحة
    } catch (err) {
      setSuccess(null); // إعادة تعيين الرسالة الناجحة
    } finally {
      setLoading(false); // انتهاء التحميل
    }
  };

  return (
    <div className="update-visa-status">
      <h2>Update Visa Status</h2>
      {success && <div className="success-message">{success}</div>}
      {error && <div className="error-message">{error}</div>}
      <Select
        options={[
          { value: "approved", label: "Approved" },
          { value: "rejected", label: "Rejected" },
        ]}
        value={status}
        setValue={setStatus}
        label="Status"
        errorMsg={""}
      />
      <button
        onClick={handleUpdate}
        className="update-button"
        disabled={loading}
      >
        {loading ? "Updating..." : "Update Status"}
      </button>
    </div>
  );
};

export default UpdateVisaStatus;
