import React, { useState } from "react";
import Checkbox from "../../../CoreComponent/Checkbox";
import { useParams } from "react-router-dom";
import httpService from "../../../../src/common/httpService";
import { toast } from "react-toastify";
import "./style.scss";

const EditAttendanceData = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const { conferenceId, userId } = useParams();
  const [registrationFee, setRegistrationFee] = useState(false);
  const [includesConferenceBag, setIncludesConferenceBag] = useState(true);
  const [includesConferenceBadge, setIncludesConferenceBadge] = useState(true);
  const [includesConferenceBook, setIncludesConferenceBook] = useState(true);
  const [includesCertificate, setIncludesCertificate] = useState(true);
  const [includesLectureAttendance, setIncludesLectureAttendance] =
    useState(true);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const getAuthToken = () => localStorage.getItem("token");

    try {
      await httpService({
        method: "POST",
        url: `${BaseUrl}/attendances`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: {
          conference_id: conferenceId,
          user_id: userId,
          registration_fee: registrationFee ? 1 : 0,
          includes_conference_bag: includesConferenceBag ? 1 : 0,
          includes_conference_badge: includesConferenceBadge ? 1 : 0,
          includes_conference_book: includesConferenceBook ? 1 : 0,
          includes_certificate: includesCertificate ? 1 : 0,
          includes_lecture_attendance: includesLectureAttendance ? 1 : 0,
        },
        withToast: true,
        onError: (error) => {
          toast.error("Failed to submit the form: " + error);
        },
      });
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="edit-attendance-form">
      <h2 className="form-title">Edit Attendance Data</h2>
      <div className="checkbox-group">
        <Checkbox
          label="Registration Fee Paid?"
          checkboxValue={registrationFee}
          setCheckboxValue={setRegistrationFee}
          className="form-checkbox"
        />

        <Checkbox
          label="Includes Conference Bag?"
          checkboxValue={includesConferenceBag}
          setCheckboxValue={setIncludesConferenceBag}
          className="form-checkbox"
        />

        <Checkbox
          label="Includes Conference Badge?"
          checkboxValue={includesConferenceBadge}
          setCheckboxValue={setIncludesConferenceBadge}
          className="form-checkbox"
        />

        <Checkbox
          label="Includes Conference Book?"
          checkboxValue={includesConferenceBook}
          setCheckboxValue={setIncludesConferenceBook}
          className="form-checkbox"
        />

        <Checkbox
          label="Includes Certificate?"
          checkboxValue={includesCertificate}
          setCheckboxValue={setIncludesCertificate}
          className="form-checkbox"
        />

        <Checkbox
          label="Includes Lecture Attendance?"
          checkboxValue={includesLectureAttendance}
          setCheckboxValue={setIncludesLectureAttendance}
          className="form-checkbox"
        />
      </div>

      <button type="submit" className="submit-btn">
        Submit
      </button>
    </form>
  );
};

export default EditAttendanceData;
