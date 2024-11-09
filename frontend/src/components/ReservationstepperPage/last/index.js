import React, { useEffect, useState } from "react";
import httpService from "../../../common/httpService";

const Lastt = () => {
  const [error, setError] = useState(null); // Error message state
  const [message, setMessage] = useState(""); // Success or info message state
  const [showRoomForm, setShowRoomForm] = useState(true); // Form visibility state
  const fetchRoomPrices = async () => {
    const token = localStorage.getItem("token"); // Retrieve the token
    const BaseUrl = process.env.REACT_APP_BASE_URL;;

    try {
      const response = await httpService({
        method: "GET",
        url: `${BaseUrl}/room-prices/1`, // Endpoint to get room prices by conference ID
        headers: {
          Authorization: `Bearer ${token}`, // Pass the token
        },
        onSuccess: (response) => {
          if (response.success) {
            // setRoomPrices(response.data); // Store room prices data
            console.log(response.data.single_base_price);

            setMessage("Room prices fetched successfully!"); // Display success message

            // Set room price fields based on the response data
            // setSingleBasePrice(response.data.single_base_price);
            // setSingleCompanionPrice(response.data.single_companion_price);
            // setSingleEarlyCheckInPrice(response.data.single_early_check_in_price);
            // setSingleLateCheckOutPrice(response.data.single_late_check_out_price);

            // setDoubleBasePrice(response.data.double_base_price);
            // setDoubleCompanionPrice(response.data.double_companion_price);
            // setDoubleEarlyCheckInPrice(response.data.double_early_check_in_price);
            // setDoubleLateCheckOutPrice(response.data.double_late_check_out_price);

            // setTripleBasePrice(response.data.triple_base_price);
            // setTripleCompanionPrice(response.data.triple_companion_price);
            // setTripleEarlyCheckInPrice(response.data.triple_early_check_in_price);
            // setTripleLateCheckOutPrice(response.data.triple_late_check_out_price);
          } else {
            setMessage("No room prices found for this conference."); // Display not found message
            setShowRoomForm(false); // Hide the form if no data is present
          }
        },
        onError: (err) => {
          setError(err);
          setMessage("An error occurred while fetching room prices."); // Display error message
        },
        withToast: true, // Show toast
      });
    } catch (error) {
      setError("Error fetching room prices.");
      setMessage("An error occurred while fetching room prices."); // Display error message in case of failure
    }
  };
  useEffect(() => {
    fetchRoomPrices();
  });
  return <div>hii</div>;
};

export default Lastt;
