// // GetCompanions.js
// import React, { useState } from "react";
// import axios from "axios";
// import CompanionModal from "./CompanionModal ";

// const GetCompanions = ({ userId, isOpen, setIsOpen }) => {
//   const [companions, setCompanions] = useState([]);
  
//   const getCompanionFlights = () => {
//     const token = localStorage.getItem("token");
//     axios
//       .get(`http://127.0.0.1:8000/api/companion-flight/${userId}`, {
//         headers: { Authorization: `Bearer ${token}` },
//       })
//       .then((response) => {
//         setCompanions(response.data);
//         console.log(response.data);
//         setIsOpen(true); // فتح النافذة المنبثقة بعد استرجاع البيانات
//       })
//       .catch((error) => {
//         console.error(
//           "Error fetching companion flight data:",
//           error.response ? error.response.data : error.message
//         );
//       });
//   };

//   // استدعاء الدالة عند تحميل المكون
//   React.useEffect(() => {
//     getCompanionFlights();
//   }, [userId]);

//   return (
//     <CompanionModal
//       isOpen={isOpen}
//       setIsOpen={setIsOpen}
//       companions={companions}
//       headers={[ /* رؤوس الأعمدة الخاصة بك */ ]}
//     />
//   );
// };

// export default GetCompanions;
