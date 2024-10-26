import React, { useEffect, useState } from "react";
import { getFromLocalStorage } from "..";
import "./style.scss";
import SimpleLabelValue from "../../SimpleLabelValue";

const PRICES = {
  single_base_price: 100.0,
  single_companion_price: 50.0,
  single_early_check_in_price: 20.0,
  single_late_check_out_price: 30.0,

  double_base_price: 200.0,
  double_companion_price: 100.0,
  double_early_check_in_price: 40.0,
  double_late_check_out_price: 60.0,

  triple_base_price: 300.0,
  triple_companion_price: 150.0,
  triple_early_check_in_price: 60.0,
  triple_late_check_out_price: 90.0,
};

const DISCOUNT = {
  roomType: "Single",
  nights: 5,
  amount: 100,
};

const calculateRoomCost = (room, isMainRoom) => {
  const roomType = room?.roomType?.value.toLowerCase(); // Ensure roomType is correct

  const basePrice = PRICES[`${roomType}_base_price`];
  const earlyCheckInPrice = room?.earlyCheckIn
    ? PRICES[`${roomType}_early_check_in_price`]
    : 0;
  const lateCheckOutPrice = room?.lateCheckOut
    ? PRICES[`${roomType}_late_check_out_price`]
    : 0;
  const totalNights = room?.totalNights;
  // Initialize total cost with the base price
  let totalCost =
    basePrice * Number(totalNights) + earlyCheckInPrice + lateCheckOutPrice;

  // Add companion cost if this is not the main room
  if (!isMainRoom) {
    const companionPrice = PRICES[`${roomType}_companion_price`] || 0;
    totalCost += companionPrice; // Add the companion's cost for non-main rooms

    totalCost =
      companionPrice * Number(totalNights) +
      earlyCheckInPrice +
      lateCheckOutPrice;
  }

  return totalCost;
};

const applyDiscount = (cost, room, nights) => {
  // Discount logic can be applied here if needed
  return cost;
};

const InvoiceForm = () => {
  const [data, setData] = useState(null);
  const [totalCost, setTotalCost] = useState(0);

  useEffect(() => {
    const otherRooms = getFromLocalStorage("otherRooms") || [];
    const mainRoom = getFromLocalStorage("mainRoom") || {};
    setData({ otherRooms, mainRoom });
  }, []);

  const { mainRoom, otherRooms } = data;

  return (
    <div className="invoice-container">
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
          label="Estimated Cost"
          value={calculateRoomCost(mainRoom, true)}
        />
      </div>

      <div className="other-rooms-section">
        {otherRooms.map((room, index) => {
          const roomTotalCost =
            calculateRoomCost(room, false) *
            parseInt(room?.totalNights || 0, 10);
          return (
            <div key={index}>
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
                  value={parseInt(room.totalNights || 0, 10)}
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
                  label="Total Cost"
                  value={calculateRoomCost(room, false)}
                />
              </div>
            </div>
          );
        })}
      </div>

      <div className="total-cost-section">
        <h3>Total Cost</h3>
        <SimpleLabelValue
          label="Total Booking Cost"
          value={totalCost ? totalCost.toFixed(2) : "0.00"}
        />
      </div>

      <div className="actions-section">
        <button className="next-button">Next</button>
      </div>
    </div>
  );
};

export default InvoiceForm;
