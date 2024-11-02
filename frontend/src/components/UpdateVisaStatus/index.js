import React, { useState } from 'react';
import './style.scss'; // تأكد من أن لديك تنسيق CSS مناسب
import Select from "../../CoreComponent/Select";
import httpService from '../../common/httpService';

const UpdateVisaStatus = () => {
    const [status, setStatus] = useState('pending'); // الحالة الافتراضية
    const [error, setError] = useState(null);
    const [success, setSuccess] = useState(null);
    const [loading, setLoading] = useState(false); // متغير لتحميل الحالة

    const handleUpdate = async () => {
        setLoading(true); // بدء التحميل
        const token = localStorage.getItem('token'); // الحصول على التوكن من التخزين المحلي

        try {
            const response = await httpService({
                method: "POST",
                url: `http://localhost:8000/api/admin/update-visa/13`, // استبدل 13 بالمعرف المناسب إذا كان لديك متغير له
                headers: {
                    Authorization: `Bearer ${token}`, // تمرير التوكن في الهيدر
                },
                data: {
                    status:status.value, // قيمة الحالة المدخلة
                },
                showLoader: true, // إذا كان لديك loader
                withToast: true, // إذا كنت تستخدم Toast
            });

            setSuccess(response.data.success); // تخزين الرسالة الناجحة
            setError(null); // إعادة تعيين أي خطأ
        } catch (err) {
            setError(err.response?.data?.error || 'Something went wrong!'); // التعامل مع الخطأ
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
                    { value: 'pending', label: 'Pending' },
                    { value: 'approved', label: 'Approved' },
                    { value: 'rejected', label: 'Rejected' },
                ]}
                value={status}
                setValue={setStatus}
                label="Status"
                errorMsg={""}
            />
            <button onClick={handleUpdate} className="update-button" disabled={loading}>
                {loading ? 'Updating...' : 'Update Status'}
            </button>
        </div>
    );
};

export default UpdateVisaStatus;
