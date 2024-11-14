import React, { useState } from "react";
import ReservationForm from "./Reservation";
import SimpleLabelValue from "../../components/SimpleLabelValue";
import RoomForm from "./Room";
import "./style.scss";
import { useNavigate } from "react-router-dom";

const Reservation = () => {
  const [openReservation, setOpenReservation] = useState(false);
  const [openRoom, setOpenRoom] = useState(false);
  const navigate = useNavigate();

  return (
    <div>
      <div className="reservation-form-header-container">
        <div className="title-container">Reservation Information Page</div>
        <div className="reservation-actions">
          <button
            type="button"
            onClick={() => {
              navigate("/stepper");
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

      <div></div>
    </div>
  );
};

export default Reservation;
