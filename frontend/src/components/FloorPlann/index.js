import React, { useEffect, useState } from "react";
import axios from "axios";
import ImageUpload from "../../CoreComponent/ImageUpload";
import "./style.scss";
import Select from "../../CoreComponent/Select";
import { toast } from "react-toastify";

const FloorPlanUploader = () => {
  const [file, setFile] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");
  const [allConference, setAllConference] = useState([]);
  const [conferenceId, setConferenceId] = useState(null);

  const BaseUrl = process.env.REACT_APP_BASE_URL;

  // جلب قائمة المؤتمرات
  const getConference = () => {
    const url = `${BaseUrl}/con`;

    axios
      .get(url)
      .then((response) => {
        setAllConference([
          { label: "None", value: null },
          ...response.data.data?.map((item) => {
            return { label: item?.title, value: item?.id };
          }),
        ]);
      })
      .catch((error) => {
        console.error("Error fetching conferences:", error);
      });
  };

  useEffect(() => {
    getConference();
  }, []);

  // رفع البيانات إلى الخادم
  const handleSubmit = async () => {
    if (!file || !conferenceId) {
      setMessage("Please select both a conference and a file.");
      return;
    }

    const token = localStorage.getItem("token");
    const url = "http://127.0.0.1:8000/api/floor/plan";
    const formData = new FormData();

    formData.append("floor_plan", file);
    formData.append("conference_id", conferenceId.value);

    try {
      setLoading(true);
      setMessage("");

      const response = await axios.post(url, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      toast.success("File uploaded successfully!");


    //   setMessage("File uploaded successfully!");
    } catch (error) {
      setMessage(
        error.response?.data?.message || "An error occurred during upload."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container555">
      <h3>Upload Floor Plan PDF</h3>
      {/* اختيار المؤتمر */}
      <Select
        options={allConference}
        value={conferenceId}
        setValue={setConferenceId}
        label="Conference Id"
        errorMsg={""}
      />

      {/* رفع الملف */}
      <ImageUpload
        label="Floor Plan Upload"
        inputValue={file}
        setInputValue={setFile}
        allowedExtensions={["pdf"]}
      />

      {/* رسالة الحالة */}
      {message && <p>{message}</p>}

      {/* زر إرسال */}
      <button onClick={handleSubmit} disabled={loading} className="submit-button">
        {loading ? "Uploading..." : "Submit"}
      </button>
    </div>
  );
};

export default FloorPlanUploader;
