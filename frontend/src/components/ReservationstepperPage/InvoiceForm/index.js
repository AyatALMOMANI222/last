import React, { useEffect, useState } from "react";
import { getFromLocalStorage } from "..";
import SimpleLabelValue from "../../SimpleLabelValue";
import "./style.scss";
import httpService from "../../../common/httpService";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../../common/AuthContext";
import { useStepper } from "../StepperContext";

const InvoiceForm = () => {
  const { currentStep, completeStep, invoice, setInvoice } = useStepper();
  const navigate = useNavigate();
  const [mainRoom, setMainRoom] = useState(null);
  const [otherRooms, setOtherRooms] = useState([]);
  const [reservationDetails, setReservationDetails] = useState(null); // State for invoice details
  const { userName, myConferenceId } = useAuth();
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  useEffect(() => {
    const mainRoomFromStorage = getFromLocalStorage("mainRoom") || {};
    const otherRoomsFromStorage = getFromLocalStorage("otherRooms") || [];
    setMainRoom(mainRoomFromStorage);
    setOtherRooms(otherRoomsFromStorage);
  }, []);

  function convertObject(obj) {
    const rooms = [];

    const formatDate = (dateStr) => {
      const date = new Date(dateStr);
      return date.toISOString().split("T")[0]; // Formats the date to YYYY-MM-DD
    };

    // Add main room
    rooms.push({
      room_type: obj.mainRoom.roomType.value,
      occupant_name: obj.mainRoom.occupant_name || "",
      check_in_date: formatDate(obj.mainRoom.checkInDate),
      check_out_date: formatDate(obj.mainRoom.checkOutDate),
      total_nights: parseInt(obj.mainRoom.totalNights),
      cost: 0,
      additional_cost: 0,
      late_check_out: obj.mainRoom.lateCheckOut || false,
      early_check_in: obj.mainRoom.earlyCheckIn || false,
    });

    // Add other rooms
    obj.otherRooms.forEach((room) => {
      rooms.push({
        room_type: room.roomType.value,
        occupant_name: room.occupantName,
        check_in_date: formatDate(room.checkInDate),
        check_out_date: formatDate(room.checkOutDate),
        total_nights: parseInt(room.totalNights),
        cost: 0,
        additional_cost: 0,
        late_check_out: room.lateCheckOut || false,
        early_check_in: room.earlyCheckIn || false,
      });
    });

    return { rooms };
  }

  const getAuthToken = () => localStorage.getItem("token");

  const submitReservation = async () => {
    const mainRoom = getFromLocalStorage("mainRoom") || {};
    const otherRooms = getFromLocalStorage("otherRooms") || [];

    const body = convertObject({
      mainRoom: { ...mainRoom, occupant_name: userName },
      otherRooms,
    });

    try {
      const response = await httpService({
        method: "POST",
        url: `${BaseUrl}/reservation`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: { conference_id: myConferenceId, ...body },
        // withToast: true,
      });

      if (response) {
        setInvoice(response);
        setReservationDetails(response);
        completeStep(currentStep);
      }
    } catch (error) {
      console.error("Error submitting form:", error);
    }
  };

  return (
    <div className="invoice-container-section">
      {reservationDetails && (
        <div className="invoice-details-section">
          <h3>Invoice Details</h3>
          <div className="section-1">
            <SimpleLabelValue
              label="Reservation ID"
              value={reservationDetails.reservation_id}
            />
            <SimpleLabelValue
              label="Total Invoice"
              value={`$${reservationDetails.total_invoice}`}
            />{" "}
          </div>
          <h3>Room Invoices</h3>
          {reservationDetails.room_invoices.map((room, index) => (
            <div key={index} className="section-1">
              <SimpleLabelValue label="Room Type" value={room.room_type} />
              <SimpleLabelValue
                label="Base Price"
                value={`$${room.base_price}`}
              />
              <SimpleLabelValue
                label="Total Cost"
                value={`$${room.total_cost}`}
              />
            </div>
          ))}
        </div>
      )}
      <h3>Main Room</h3>
      <div className="main-room-section">
        <SimpleLabelValue label="Room Type" value={mainRoom?.roomType?.label} />
        <SimpleLabelValue
          label="Check-in Date"
          value={new Date(mainRoom?.checkInDate).toLocaleDateString()}
        />
        <SimpleLabelValue
          label="Check-out Date"
          value={new Date(mainRoom?.checkOutDate).toLocaleDateString()}
        />
        <SimpleLabelValue label="Total Nights" value={mainRoom?.totalNights} />
        <SimpleLabelValue
          label="Early Check-in"
          value={mainRoom?.earlyCheckIn ? "Yes" : "No"}
        />
        <SimpleLabelValue
          label="Late Check-out"
          value={mainRoom?.lateCheckOut ? "Yes" : "No"}
        />
      </div>

      <div className="other-rooms-section">
        {otherRooms.map((room, index) => (
          <div key={`${index}_${room.occupantName}`}>
            <h3>Room {index + 1}</h3>

            <div className="room-info">
              <SimpleLabelValue
                label="Occupant Name"
                value={room.occupantName}
              />
              <SimpleLabelValue
                label="Room Type"
                value={room.roomType?.label}
              />
              <SimpleLabelValue
                label="Special Requests"
                value={room.specialRequests}
              />
              <SimpleLabelValue
                label="Check-in Date"
                value={new Date(room.checkInDate).toLocaleDateString()}
              />
              <SimpleLabelValue
                label="Check-out Date"
                value={new Date(room.checkOutDate).toLocaleDateString()}
              />
              <SimpleLabelValue
                label="Total Nights"
                value={room.totalNights || 0}
              />
              <SimpleLabelValue
                label="Early Check-in"
                value={room.earlyCheckIn ? "Yes" : "No"}
              />
              <SimpleLabelValue
                label="Late Check-out"
                value={room.lateCheckOut ? "Yes" : "No"}
              />
            </div>
          </div>
        ))}
      </div>

      <div className="actions-section">
        <button className="next-button" onClick={submitReservation}>
          Submit
        </button>
      </div>
    </div>
  );
};

export default InvoiceForm;
