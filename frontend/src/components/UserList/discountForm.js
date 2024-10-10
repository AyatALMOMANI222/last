// import React, { useEffect, useState } from "react";
// import Input from "../../CoreComponent/Input";
// import Select from "../../CoreComponent/Select";
// import axios from "axios";
// import "./style.scss";
// import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
// import MySideDrawer from "../../CoreComponent/SideDrawer";

// const AddDiscountForm = ({ isOpen, setIsOpen }) => {
//   // State for discount fields
//   const [tripParticipantId, setTripParticipantId] = useState("");
//   const [optionId, setOptionId] = useState("");
//   const [discountValue, setDiscountValue] = useState(0);
//   const [showDiscount, setShowDiscount] = useState(false);
//   const [conferences, setConferences] = useState();
//   const [trips, setTrips] = useState();
//   const [tripId, setTripId] = useState();
//   const [conferenceId, setConferenceId] = useState();
//   const getConferencesByUserId = () => {
//     const token = localStorage.getItem("token");

//     axios
//       .get(`http://127.0.0.1:8000/api/user/39/conferences`, {
//         headers: {
//           Authorization: `Bearer ${token}`,
//         },
//       })
//       .then((response) => {
//         const conferencesList = response.data.map((item) => {
//           return { label: item.title, value: item.id };
//         });
//         console.log(conferencesList);

//         setConferences(conferencesList);
//       })
//       .catch((error) => {});
//   };
//   const getAllTrips = (conference_id) => {
//     const token = localStorage.getItem("token");

//     axios
//       .get(`http://127.0.0.1:8000/api/conference-trips`, {
//         headers: {
//           Authorization: `Bearer ${token}`,
//         },
//       })
//       .then((response) => {
//         console.log(
//           response?.data?.data
//             ?.filter((item) => item?.conference_id)
//             ?.trip?.map((item) => {
//               return { label: item?.name, value: item?.id };
//             })
//         );
//         const tripList = response?.data?.data
//           ?.filter((item) => item?.conference_id)
//           ?.trip?.map((item) => {
//             return { label: item?.name, value: item?.id };
//           });
//         setTrips(tripList);
//       })
//       .catch((error) => {});
//   };
//   const handleSubmit = async (e) => {
//     e.preventDefault();
//     const token = localStorage.getItem("token");

//     const formData = {
//       trip_participant_id: tripParticipantId,
//       option_id: optionId,
//       discount_value: discountValue,
//       show_discount: showDiscount,
//     };

//     try {
//       const response = await axios.post(
//         "http://127.0.0.1:8000/api/discounts",
//         formData,
//         {
//           headers: {
//             Authorization: `Bearer ${token}`,
//           },
//         }
//       );

//       console.log("Discount added successfully", response.data);
//     } catch (error) {
//       console.error(
//         "Error adding discount:",
//         error.response ? error.response.data : error
//       );
//     }
//   };
//   useEffect(() => {
//     getConferencesByUserId();
//   }, [isOpen]);
//   useEffect(() => {
//     getAllTrips(conferenceId?.value);
//   }, [conferenceId]);
//   return (
//     <div>
//       <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
//         <CustomFormWrapper
//           title="Add Discount for User"
//           handleSubmit={handleSubmit}
//           setOpenForm={setIsOpen}
//         >
//           <form className="discount-form-container">
//             <Select
//               options={conferences}
//               value={conferenceId}
//               setValue={setConferenceId}
//               label="Conference"
//               errorMsg={""}
//             />

//             <Select
//               options={trips}
//               value={tripId}
//               setValue={setTripId}
//               label="Trip"
//               errorMsg={""}
//             />
//             <Input
//               label="Trip Participant ID"
//               inputValue={tripParticipantId}
//               setInputValue={setTripParticipantId}
//               placeholder="Enter trip participant ID"
//             />
//             <Input
//               label="Option ID"
//               inputValue={optionId}
//               setInputValue={setOptionId}
//               placeholder="Enter option ID"
//             />
//             <Input
//               label="Discount Value"
//               inputValue={discountValue}
//               setInputValue={(value) =>
//                 setDiscountValue(parseFloat(value) || 0)
//               }
//               placeholder="Enter discount value"
//               type="number"
//             />
//             <Select
//               options={[
//                 { value: true, label: "Show Discount" },
//                 { value: false, label: "Hide Discount" },
//               ]}
//               value={{
//                 value: showDiscount,
//                 label: showDiscount ? "Show" : "Hide",
//               }}
//               setValue={(option) => setShowDiscount(option.value)}
//               label="Show Discount"
//               errorMsg={""}
//             />
//           </form>
//         </CustomFormWrapper>
//       </MySideDrawer>
//     </div>
//   );
// };

// export default AddDiscountForm;
import React, { useEffect, useState } from "react";
import Input from "../../CoreComponent/Input";
import Select from "../../CoreComponent/Select";
import axios from "axios";
import "./style.scss";
import CustomFormWrapper from "../../CoreComponent/CustomFormWrapper";
import MySideDrawer from "../../CoreComponent/SideDrawer";

const AddDiscountForm = ({ isOpen, setIsOpen }) => {
  const [tripParticipantId, setTripParticipantId] = useState("");
  const [optionId, setOptionId] = useState("");
  const [discountValue, setDiscountValue] = useState(0);
  const [showDiscount, setShowDiscount] = useState(false);
  const [conferences, setConferences] = useState([]);
  const [trips, setTrips] = useState([]);
  const [tripId, setTripId] = useState(null);
  const [conferenceId, setConferenceId] = useState(null);

  const fetchToken = () => localStorage.getItem("token");

  const fetchConferencesByUserId = async () => {
    try {
      const token = fetchToken();
      const response = await axios.get(`http://127.0.0.1:8000/api/user/39/conferences`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      const conferencesList = response.data.map(({ title, id }) => ({ label: title, value: id }));
      setConferences(conferencesList);
    } catch (error) {
      console.error("Error fetching conferences", error);
    }
  };

  const fetchAllTrips = async (conferenceId) => {
    console.log({conferenceId});
    
    if (!conferenceId) return;
    try {
      const token = fetchToken();
      const response = await axios.get(`http://127.0.0.1:8000/api/conference-trips`, {
        headers: { Authorization: `Bearer ${token}` },
      });
console.log(response.data?.data
  ?.filter(({ conference_id }) => conference_id == 19));

      const tripList = response.data?.data
        ?.filter(({ conference_id }) => conference_id === conferenceId.value)
        .map(({ trip }) => trip?.map(({ name, id }) => ({ label: name, value: id })))
        .flat();

      setTrips(tripList || []);
    } catch (error) {
      console.error("Error fetching trips", error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const token = fetchToken();
      const formData = {
        trip_participant_id: tripParticipantId,
        option_id: optionId,
        discount_value: discountValue,
        show_discount: showDiscount,
      };

      const response = await axios.post("http://127.0.0.1:8000/api/discounts", formData, {
        headers: { Authorization: `Bearer ${token}` },
      });

    } catch (error) {
    }
  };

  useEffect(() => {
    if (isOpen) fetchConferencesByUserId();
  }, [isOpen]);

  useEffect(() => {
    if (conferenceId) fetchAllTrips(conferenceId.value);
  }, [conferenceId]);

  return (
    <MySideDrawer isOpen={isOpen} setIsOpen={setIsOpen}>
      <CustomFormWrapper
        title="Add Discount for User"
        handleSubmit={handleSubmit}
        setOpenForm={setIsOpen}
      >
        <form className="discount-form-container" onSubmit={handleSubmit}>
          <Select
            options={conferences}
            value={conferenceId}
            setValue={setConferenceId}
            label="Conference"
            errorMsg=""
          />
          <Select
            options={trips}
            value={tripId}
            setValue={setTripId}
            label="Trip"
            errorMsg=""
          />
          <Input
            label="Trip Participant ID"
            inputValue={tripParticipantId}
            setInputValue={setTripParticipantId}
            placeholder="Enter trip participant ID"
          />
          <Input
            label="Option ID"
            inputValue={optionId}
            setInputValue={setOptionId}
            placeholder="Enter option ID"
          />
          <Input
            label="Discount Value"
            inputValue={discountValue}
            setInputValue={(value) => setDiscountValue(parseFloat(value) || 0)}
            placeholder="Enter discount value"
            type="number"
          />
          <Select
            options={[
              { value: true, label: "Show Discount" },
              { value: false, label: "Hide Discount" },
            ]}
            value={{
              value: showDiscount,
              label: showDiscount ? "Show" : "Hide",
            }}
            setValue={(option) => setShowDiscount(option.value)}
            label="Show Discount"
            errorMsg=""
          />
        </form>
      </CustomFormWrapper>
    </MySideDrawer>
  );
};

export default AddDiscountForm;
