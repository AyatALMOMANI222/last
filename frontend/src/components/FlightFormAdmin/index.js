import React, { useEffect, useState } from "react";
import Table from "../../CoreComponent/Table";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import AddTripForm from "./tripForm";
import SeatCostForm from "./costForm";
import FlightDetails from "./viewForm";
import Input from "../../CoreComponent/Input";
import "./style.scss";
import axios from "axios";

const FlightFormAdmin = () => {
 const[flights,setFlights]=useState([])
  const headers = [
    // { key: "flight_id", label: "Flight ID" },
    { key: "user_name", label: "Passenger Name" },
    { key: "departure_airport", label: "Departure Airport" },
    { key: "arrival_airport", label: "Arrival Airport" },
    { key: "departure_date", label: "Departure Date" },
    { key: "arrival_date", label: "Arrival Date" },
    // { key: "flight_number", label: "Flight Number" },
    // { key: "seat_preference", label: "Seat Preference" },
    // { key: "additional_requests", label: "Additional Requests" },
    { key: "actions", label: "Actions" },
  ];

  const [openView, setOpenView] = useState(false);
  const [openTripForm, setOpenTripForm] = useState(false);
  const [openPriceForm, setOpenPriceForm] = useState(false);
  const [selectedItem, setSelectedItem] = useState({});
  const [travelerName, setTravelerName] = useState("");
  const getFlight = () => {
    const token = localStorage.getItem('token'); // الحصول على التوكن من localStorage
    
    axios.get("http://127.0.0.1:8000/api/user/pag/filter", {
      headers: {
        'Authorization': `Bearer ${token}` // تضمين التوكن في الهيدر
      }
    })
    .then(response => {
      console.log("Flight data fetched successfully:", response.data.data);
      setFlights(response.data.data)
  
      
      // يمكنك تنفيذ أي عملية أخرى تحتاجها عند الحصول على البيانات بنجاح
    })
    .catch(error => {
      console.error("Error fetching flight data:", error.response ? error.response.data : error.message);
      // يمكنك معالجة الخطأ أو عرض رسالة توضح السبب للمستخدم
    });
  };
  useEffect(()=>{
    getFlight()
  },[])
  const handleTableData = () => {
    return flights?.map((item) => {
      return {
        ...item,
        actions: (
          <div className="table-actions-container">
            <button
              className="trip-btn"
              onClick={() => {
                setOpenTripForm(true);
                setSelectedItem(item);
              }}
            >
              Add Trip
            </button>
            <button
              className="price-btn"
              onClick={() => {
                setOpenPriceForm(true);
                setSelectedItem(item);
              }}
            >
              Add Price
            </button>
            <button
              onClick={() => {
                setOpenView(true);
                setSelectedItem(item);
              }}
            >
              View
            </button>
          </div>
        ),
      };
    });
  };

  return (
    <div className="flight-form">
      <div className="flight-form-admin-header">
        <div className="header">
          <Input
            placeholder="Search"
            inputValue={travelerName}
            setInputValue={setTravelerName}
            type="text"
          />
        </div>
      </div>
      <div className="flight-table-container">
        <Table headers={headers} data={handleTableData()} />
      </div>
      <MySideDrawer isOpen={openView} setIsOpen={setOpenView} >
        <FlightDetails data={selectedItem} />
      </MySideDrawer>
      <MySideDrawer isOpen={openTripForm} setIsOpen={setOpenTripForm}>
        <AddTripForm data={selectedItem} setOpen={setOpenTripForm} />
      </MySideDrawer>
      <MySideDrawer isOpen={openPriceForm} setIsOpen={setOpenPriceForm}>
        <SeatCostForm data={selectedItem} setOpen={setOpenPriceForm} />
      </MySideDrawer>
    </div>
  );
};

export default FlightFormAdmin;
