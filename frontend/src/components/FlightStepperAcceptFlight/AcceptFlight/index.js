// import React, { Fragment, useEffect, useState } from "react";
// import { toast } from "react-toastify";
// import { useFlightStepperAdmin } from "../StepperContext";
// import httpService from "../../../common/httpService";
// import "./style.scss";
// import {
//   getFromLocalStorage,
//   saveToLocalStorage,
// } from "../../../common/localStorage";

// const AcceptFlight = ({ member, index }) => {
//   const { currentStep, completeStep, passportImage, flightMembers } =
//     useFlightStepperAdmin();
//   const otherData = {
//     available_id: 0,
//     flight_id: member?.flight_id,
//   };
//   const [availableFlights, setAvailableFlights] = useState([]);
//   const [selectedFlight, setSelectedFlight] = useState(null);

//   const getAuthToken = () => localStorage.getItem("token");

//   const getAvailableFlights = async () => {
//     try {
//       const response = await httpService({
//         method: "GET",
//         url: `http://127.0.0.1:8000/api/available-flights/${member?.flight_id}`,
//         headers: { Authorization: `Bearer ${getAuthToken()}` },
//         showLoader: true,
//         withToast: true,
//       });
//       setAvailableFlights([otherData, ...response?.available_flights] || []);
//       toast.success("The data was updated successfully!");
//     } catch (error) {
//       toast.error("Failed to fetch available flights");
//     }
//   };

//   const getFlights = () => {
//     const flightTrips = [];
//     for (let i = 0; i < localStorage.length; i++) {
//       const key = localStorage.key(i);
//       if (key.startsWith("Avalible_Trip_ID_")) {
//         const value = localStorage.getItem(key);
//         try {
//           flightTrips.push(JSON.parse(value));
//         } catch {
//           console.error("Error parsing localStorage data", value);
//         }
//       }
//     }
//     return flightTrips;
//   };

//   const submit = () => {
//     const data = getFlights();
//     console.log(data);
//     // Please Ayat connect this data with API
//   };

//   const handleSubmit = () => {
//     const isFinalStep = flightMembers.length === index + 1;

//     if (!isFinalStep) {
//       completeStep(currentStep);
//       toast.success("The data was updated successfully!");
//     } else {
//       submit();
//     }
//   };

//   useEffect(() => {
//     getAvailableFlights();
//     const storedFlight = getFromLocalStorage(`Avalible_Trip_ID_${member?.flight_id}`);
//     if (storedFlight) {
//       setSelectedFlight(storedFlight);
//     }
//   }, []);

//   return (
//     <Fragment>
//       <div className="accept-flight-information">
//         <div className="title">Available Flights</div>
//         <div className="flight-cards-container">
//           {availableFlights.map((flight) => (
//             <div
//               key={flight.available_id}
//               className={`flight-card ${
//                 selectedFlight?.available_id === flight.available_id ? "selected" : ""
//               }`}
//               onClick={() => {
//                 setSelectedFlight(flight);
//                 saveToLocalStorage(
//                   `Avalible_Trip_ID_${member?.flight_id}`,
//                   flight
//                 );
//               }}
//             >
//               {flight.available_id !== 0 ? (
//                 <Fragment>
//                   <div className="flight-card__detail">
//                     <span>Departure Date:</span> {flight.departure_date}
//                   </div>
//                   <div className="flight-card__detail">
//                     <span>Departure Time:</span> {flight.departure_time}
//                   </div>
//                   <div className="flight-card__detail">
//                     <span>Price:</span> {flight.price}$
//                   </div>
//                 </Fragment>
//               ) : (
//                 <div className="other">Other</div>
//               )}
//             </div>
//           ))}
//         </div>

//         <div className="actions-section">
//           <button
//             className="next-button"
//             onClick={handleSubmit}
//             disabled={!selectedFlight}
//           >
//             Submit
//           </button>
//         </div>
//       </div>
//     </Fragment>
//   );
// };

// export default AcceptFlight;
