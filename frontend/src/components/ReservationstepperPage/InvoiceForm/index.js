import React, { useEffect, useState } from "react";
import { getFromLocalStorage } from "..";
import SimpleLabelValue from "../../SimpleLabelValue";
import { toast } from "react-toastify";
import "./style.scss";
import httpService from "../../../common/httpService";

const DISCOUNT = {
  roomType: "single",
  nights: 5,
};

const calculateRoomCost = (room, isMainRoom, prices) => {
  const roomType = room?.roomType?.value.toLowerCase();
  const basePrice = prices[`${roomType}_base_price`] || 0;

  const earlyCheckInPrice = room?.earlyCheckIn
    ? prices[`${roomType}_early_check_in_price`] || 0
    : 0;
  const lateCheckOutPrice = room?.lateCheckOut
    ? prices[`${roomType}_late_check_out_price`] || 0
    : 0;
  const totalNights = Number(room?.totalNights);

  let totalCost =
    basePrice * totalNights + earlyCheckInPrice + lateCheckOutPrice;

  if (!isMainRoom) {
    const companionPrice = prices[`${roomType}_companion_price`] || 0;
    return companionPrice * totalNights + earlyCheckInPrice + lateCheckOutPrice;
  }

  // Log the totalCost before returning it
  console.log("Total Cost:", totalCost);
  
  return totalCost;
};



const theDiscountAmount = (prices) => {
  const basePrice = `${prices?.roomType}_base_price`;
  return prices[basePrice] * Number(prices.nights);
};

const InvoiceForm = () => {
  const [data, setData] = useState({ mainRoom: {}, otherRooms: [] });
  const [totalCost, setTotalCost] = useState(0);
  const [prices, setPrices] = useState({});

  const [error, setError] = useState(null); // Error message state
  const [message, setMessage] = useState("");
  const BaseUrl = process.env.REACT_APP_BASE_URL;;

  const fetchRoomPrices = async () => {
    const token = localStorage.getItem("token"); // Retrieve the token

    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/room-prices/1`, // Endpoint to get room prices by conference ID
        headers: {
          Authorization: `Bearer ${token}`, // Pass the token
        },

        withToast: true, // Show toast
      });

      setPrices(response.data);
    } catch (error) {
      setError("Error fetching room prices.");
      setMessage("An error occurred while fetching room prices."); // Display error message in case of failure
    }
  };

  useEffect(() => {
    const mainRoom = getFromLocalStorage("mainRoom") || {};
    const otherRooms = getFromLocalStorage("otherRooms") || [];
    setData({ mainRoom, otherRooms });
    fetchRoomPrices();
  }, []);

  useEffect(() => {
    const { mainRoom, otherRooms } = data;

    // Calculate total cost for main room and other rooms
    const mainRoomCost =
      calculateRoomCost(mainRoom, true, prices) - theDiscountAmount(prices);
    const otherRoomsCost = otherRooms.reduce(
      (total, room) => total + calculateRoomCost(room, false, prices),
      0
    );

    setTotalCost(mainRoomCost + otherRoomsCost);
  }, [data]);

  const { mainRoom, otherRooms } = data;

  return (
    <div className="invoice-container-section">
      <h3>Main Room</h3>
      <div className="main-room-section">
        <SimpleLabelValue label="Room Type" value={mainRoom.roomType?.label} />
        <SimpleLabelValue
          label="Check-in Date"
          value={new Date(mainRoom.checkInDate).toLocaleDateString()}
        />
        <SimpleLabelValue
          label="Check-out Date"
          value={new Date(mainRoom.checkOutDate).toLocaleDateString()}
        />
        <SimpleLabelValue label="Total Nights" value={mainRoom.totalNights} />
        <SimpleLabelValue
          label="Early Check-in"
          value={mainRoom.earlyCheckIn ? "Yes" : "No"}
        />
        <SimpleLabelValue
          label="Late Check-out"
          value={mainRoom.lateCheckOut ? "Yes" : "No"}
        />
        <SimpleLabelValue
          label="Cost"
          value={`${(
            calculateRoomCost(mainRoom, true, prices) -
            theDiscountAmount(prices)
          )} JOD`}
        />
      </div>

      <div className="other-rooms-section">
        {otherRooms.map((room, index) => (
          <div>
            <h3>Room {index + 1}</h3>

            <div key={`${index}_${room.occupantName}`} className="room-info">
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
              <SimpleLabelValue
                label="Cost"
                value={`${calculateRoomCost(room, false, prices)} JOD`}
              />
            </div>
          </div>
        ))}
      </div>

      <div className="total-cost-section">
        <h3>Total Cost</h3>
        <SimpleLabelValue
          label="Total Cost"
          value={`${totalCost} JOD`}
        />
      </div>

      <div className="actions-section">
        <button
          className="next-button"
          onClick={() => {
            toast.success("The data was updated successfully!");
            fetchRoomPrices();
          }}
        >
          Submit
        </button>
      </div>
    </div>
  );
};

export default InvoiceForm;
