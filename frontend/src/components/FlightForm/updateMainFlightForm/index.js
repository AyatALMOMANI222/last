import React, { Fragment, useEffect, useState } from "react";
import { toast } from "react-toastify";
import axios from "axios";
import "./style.scss";
import DateInput from "../../../CoreComponent/Date";
import ImageUpload from "../../../CoreComponent/ImageUpload";
import Input from "../../../CoreComponent/Input";
import Checkbox from "../../../CoreComponent/Checkbox";
import { useParams } from "react-router-dom";
import { useAuth } from "../../../common/AuthContext";

const MainFlightFormUpdate = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const { id } = useParams();
  const { userId } = useAuth();
  const [arrivalDate, setArrivalDate] = useState("");
  const [departureDate, setDepartureDate] = useState("");
  const [passportImage, setPassportImage] = useState(null);
  const [departureAirport, setDepartureAirport] = useState("");
  const [returnAirport, setReturnAirport] = useState("");
  const [specificFlightTime, setSpecificFlightTime] = useState(false);
  const [flightTime, setFlightTime] = useState("");
  const [flightNumber, setFlightNumber] = useState("");
  const [otherRequests, setOtherRequests] = useState("");
  const [seatNumber, setSeatNumber] = useState("");
  const [upgradeClass, setUpgradeClass] = useState(false);
  const [ticketCount, setTicketCount] = useState(1);
  const [updateDeadLine, setUpdateDeadLine] = useState(null);
  const token = localStorage.getItem("token");

  const handleMainFlightSubmit = (e) => {
    e.preventDefault();

    // التحقق من الموعد النهائي للتحديث
    const currentDate = new Date();
    const deadlineDate = new Date(updateDeadLine);

    if (currentDate > deadlineDate) {
      toast.error(
        "You cannot update the flight information after the deadline."
      );
      return; // منع الإرسال إذا كان الموعد النهائي قد تجاوز
    }

    const formData = new FormData();

    // Append Main Flight Form Fields
    formData.append("arrival_date", arrivalDate);
    formData.append("departure_date", departureDate);
    formData.append("passport_image", passportImage);
    formData.append("departure_airport", departureAirport);
    formData.append("arrival_airport", returnAirport);
    formData.append("specific_flight_time", flightTime);
    formData.append("flight_number", flightNumber ? flightNumber : 0);
    formData.append(
      "additional_requests",
      otherRequests ? otherRequests : "none"
    );
    formData.append("seat_preference", seatNumber ? seatNumber : 0);
    formData.append("upgrade_class", upgradeClass ? 1 : 0);
    formData.append("ticket_count", ticketCount);
    formData.append("is_companion", 0);
    formData.append("user_id", userId);

    axios
      .post(`${BaseUrl}/user/update-flight/${id}`, formData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      })
      .then((response) => {
        toast.success(response?.data?.message);
      })
      .catch((error) => {
        console.error(
          "There was an error creating the flight:",
          error.response.data
        );
      });
  };

  const getFlightData = () => {
    axios
      .get(`${BaseUrl}/flight`, {
        headers: {
          Authorization: `Bearer ${token}`, // تمرير التوكن باستخدام Bearer
        },
      })
      .then((response) => {
        setUpdateDeadLine(response.data[0].admin_update_deadline);
      })
      .catch((error) => {
        console.error("Error fetching flight data:", error.response);
      });
  };
  useEffect(() => {
    getFlightData();
  });
  return (
    <Fragment>
      <form className="main-flight-form" onSubmit={handleMainFlightSubmit}>
        <div className="flight-information-header">Flight Information</div>
        <div className="form-section">
          <DateInput
            label="Arrival Date"
            inputValue={arrivalDate}
            setInputValue={setArrivalDate}
            required={true}
          />
          <DateInput
            label="Departure Date"
            inputValue={departureDate}
            setInputValue={setDepartureDate}
            required={true}
          />
          <ImageUpload
            label="Passport Image"
            required={true}
            allowedExtensions={["jpg", "jpeg", "png", "gif"]}
            inputValue={passportImage}
            setInputValue={setPassportImage}
          />
          <Input
            label="Departure Airport"
            inputValue={departureAirport}
            setInputValue={setDepartureAirport}
            required={true}
          />
          <Input
            label="Return Airport"
            inputValue={returnAirport}
            setInputValue={setReturnAirport}
            required={true}
          />
          <Checkbox
            label="Do you have specific flight time?"
            checked={specificFlightTime}
            onChange={(e) => setSpecificFlightTime(e.target.checked)}
          />
          <Input
            label="Flight Time"
            type="time"
            inputValue={flightTime}
            setInputValue={setFlightTime}
            required={true}
          />
          <Input
            label="Flight Number"
            inputValue={flightNumber}
            setInputValue={setFlightNumber}
          />
          <Input
            label="Other Requests"
            inputValue={otherRequests}
            setInputValue={setOtherRequests}
          />
          <Input
            label="Seat Number"
            inputValue={seatNumber}
            setInputValue={setSeatNumber}
          />

          <Checkbox
            label="Do you want to upgrade to business class?"
            checkboxValue={upgradeClass}
            setCheckboxValue={setUpgradeClass}
            icon={""}
            errorMsg={""}
            className="form-checkbox"
          />
          <Input
            label="Number of Tickets to Book"
            type="number"
            inputValue={ticketCount}
            setInputValue={setTicketCount}
            placeholder="Number of Tickets to Book"
            required={true}
          />
          {/* <Input
          label="Number of Tickets to Book"
          type="number"
          inputValue={ticketCount}
          setInputValue={(value) => setTicketCount(Number(value))}
          placeholder="Number of Tickets to Book"
          required={true}
        /> */}
        </div>

        <div className="actions-section-container">
          <button className="submit-btn" type="submit">
            Submit
          </button>
        </div>
      </form>
    </Fragment>
  );
};

export default MainFlightFormUpdate;
