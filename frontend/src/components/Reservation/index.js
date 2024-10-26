import React, { useState } from "react";
import ReservationForm from "./Reservation";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import RoomForm from "./Room";
import "./style.scss";
import { useNavigate } from "react-router-dom";

const Reservation = () => {
  const [openReservation, setOpenReservation] = useState(false);
  const [openRoom, setOpenRoom] = useState(false);
  const navigate = useNavigate()
  const data = {
    checkInDate: "2024-10-10",
    checkOutDate: "2024-10-15",
    lateCheckOut: true,
    earlyCheckIn: false,
    totalNights: 5,
    roomCount: 2,
  };

  return (
    <div>
      <div className="reservation-form-header-container">
        <div className="title-container">Reservation Information Page</div>
        <div className="reservation-actions">
          {/* <button
            type="button"
            onClick={() => {
              setOpenRoom(true);
            }}
            className={`add-companion-btn`}
          >
            Add Room
          </button> */}
          <button
            type="button"
            onClick={() => {
              // setOpenReservation(true);
              navigate("/stepper")
            }}
          >
            Add Reservation Information
          </button>
        </div>
      </div>
      <ReservationForm
        openReservation={openReservation}
        setOpenReservation={setOpenReservation}
      />
      <RoomForm openRoom={openRoom} setOpenRoom={setOpenRoom} />

      <div>
        <div className="view-reservation-info">
          <SimpleLabelValue label="Check-In Date" value={data.checkInDate} />
          <SimpleLabelValue label="Check-Out Date" value={data.checkOutDate} />
          <SimpleLabelValue
            label="Late Check-Out"
            value={data.lateCheckOut ? "Yes" : "No"}
          />
          <SimpleLabelValue
            label="Early Check-In"
            value={data.earlyCheckIn ? "Yes" : "No"}
          />
          <SimpleLabelValue label="Total Nights" value={data.totalNights} />
          <SimpleLabelValue label="Room Count" value={data.roomCount} />
        </div>
      </div>
    </div>
  );
};

export default Reservation;
