import React, { useEffect, useState } from "react";
import { getFromLocalStorage } from "..";
import SimpleLabelValue from "../../SimpleLabelValue";
import { toast } from "react-toastify";
import "./style.scss";
import httpService from "../../../common/httpService";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../../common/AuthContext";

const InvoiceForm = () => {
  const navigate = useNavigate();
  const [mainRoom, setMainRoom] = useState(null);
  const [otherRooms, setOtherRooms] = useState([]);
  const { userName } = useAuth();

  const BaseUrl = process.env.REACT_APP_BASE_URL;

  useEffect(() => {
    const mainRoomFromStorage = getFromLocalStorage("mainRoom") || {};
    const otherRoomsFromStorage = getFromLocalStorage("otherRooms") || [];
    setMainRoom(mainRoomFromStorage);
    setOtherRooms(otherRoomsFromStorage);
  }, []);

  function convertObject(obj) {
    const rooms = [];
  
    // Helper function to format date to "YYYY-MM-DD"
    const formatDate = (dateStr) => {
      const date = new Date(dateStr);
      return date.toISOString().split("T")[0]; // Formats the date to YYYY-MM-DD
    };
  
    // Push the mainRoom into the rooms array
    rooms.push({
      room_type: obj.mainRoom.roomType.value, // roomType as string
      occupant_name: "", // Assuming the main room doesn't have an occupant name
      check_in_date: formatDate(obj.mainRoom.checkInDate),
      check_out_date: formatDate(obj.mainRoom.checkOutDate),
      total_nights: parseInt(obj.mainRoom.totalNights), // Convert totalNights to number
      cost: 0, // Assuming a static cost for the main room
      additional_cost: 0, // Assuming a static additional cost
      late_check_out: obj.lateCheckOut || false, // Use passed in lateCheckOut value or default to false
      early_check_in: obj.earlyCheckIn || false, // Use passed in earlyCheckIn value or default to false
    });
  
    // Loop through otherRooms and push them into the rooms array
    obj.otherRooms.forEach((room) => {
      rooms.push({
        room_type: room.roomType.value,
        occupant_name: room.occupantName,
        check_in_date: formatDate(room.checkInDate),
        check_out_date: formatDate(room.checkOutDate),
        total_nights: parseInt(room.totalNights),
        cost: 0,
        additional_cost: 0,
        late_check_out: obj.lateCheckOut || false, // Use passed in lateCheckOut value or default to false
        early_check_in: obj.earlyCheckIn || false, // Use passed in earlyCheckIn value or default to false
      });
    });
  
    return { rooms };
  }
  
  const getAuthToken = () => localStorage.getItem("token");
  const { myConferenceId} = useAuth();
  console.log(myConferenceId);


  const submitReservation = async () => {
    const mainRoom = getFromLocalStorage("mainRoom") || {};
    const otherRooms = getFromLocalStorage("otherRooms") || [];
    console.log({
      mainRoom: { ...mainRoom, occupant_name: userName },
      otherRooms,
    });
    console.log(convertObject({
      mainRoom: { ...mainRoom, occupant_name: userName },
      otherRooms,
    }));
    
    
    try {
      await httpService({
        method: "POST",
        url: `${BaseUrl}/reservation`,
        headers: { Authorization: `Bearer ${getAuthToken()}` },
        showLoader: true,
        data: convertObject({
          mainRoom: { ...mainRoom, occupant_name: userName },
          otherRooms,
        }),
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
    <div className="invoice-container-section">
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
        <button
          className="next-button"
          onClick={() => {
            toast.success("The data was updated successfully!");
            submitReservation();
          }}
        >
          Submit
        </button>
      </div>
    </div>
  );
};

export default InvoiceForm;
