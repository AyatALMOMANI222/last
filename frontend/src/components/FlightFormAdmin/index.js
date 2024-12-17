import React, { useEffect, useState } from "react";
import Table from "../../CoreComponent/Table";
import MySideDrawer from "../../CoreComponent/SideDrawer";
import AddTripForm from "./tripForm";
import SeatCostForm from "./costForm";
import FlightDetails from "./viewForm";
import CompanionModal from "./CompanionModal "; // تأكد من عدم وجود مسافة إضافية في اسم المكون
import Input from "../../CoreComponent/Input";
import "./style.scss";
import axios from "axios";
import UpdateDeadline from "./SetUpdateDeadline";
import UpdateTicket from "./SetTicket";
import { useNavigate } from "react-router-dom";
import Pagination from "../../CoreComponent/Pagination";

const FlightFormAdmin = () => {
  const BaseUrl = process.env.REACT_APP_BASE_URL;

  const navigate = useNavigate();
  const [flights, setFlights] = useState([]);
  const [companions, setCompanions] = useState([]);
  const headers = [
    { key: "user_name", label: "Passenger Name" },
    { key: "departure_airport", label: "Departure Airport" },
    { key: "arrival_airport", label: "Arrival Airport" },
    // { key: "departure_date", label: "Departure Date" },
    // { key: "arrival_date", label: "Arrival Date" },
    { key: "actions", label: "Actions" },
  ];

  const [openView, setOpenView] = useState(false);
  const [openTripForm, setOpenTripForm] = useState(false);
  const [openPriceForm, setOpenPriceForm] = useState(false);
  const [openCompanionModal, setOpenCompanionModal] = useState(false); // حالة لفتح المودال
  const [selectedItem, setSelectedItem] = useState({});
  const [travelerName, setTravelerName] = useState("");
  const [openUpdateForm, setOpenUpdateForm] = useState(false);
  const [openTicketForm, setOpenTicketForm] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const getFlight = () => {
    const token = localStorage.getItem("token");
    const url = `${BaseUrl}/user/pag/filter?page=${currentPage}`;
    axios
      .get(url, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((response) => {
        console.log({response});
        
        setFlights(response.data.data);
        setTotalPages(response.data.pagination?.total_pages);
        setCurrentPage(response.data.pagination?.current_page);
      })
      .catch((error) => {
        console.error(
          "Error fetching flight data:",
          error.response ? error.response.data : error.message
        );
      });
  };
  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const getCompanionFlights = (userId) => {
    const token = localStorage.getItem("token");
    axios
      .get(`${BaseUrl}/companion-flight/${userId}`, {
        headers: { Authorization: `Bearer ${token}` },
      })
      .then((response) => {
        setCompanions(response.data);
        console.log(response.data);

        setOpenCompanionModal(true); // فتح المودال بعد جلب البيانات
      })
      .catch((error) => {
        console.error(
          "Error fetching companion flight data:",
          error.response ? error.response.data : error.message
        );
      });
  };

  useEffect(() => {
    getFlight();
  }, [currentPage]);

  const handleTableData = () => {
    return flights?.map((item) => {
      return {
        ...item,
        actions: (
          <div className="table-actions-container">
            <button
              onClick={() => {
                navigate(`/flights/admins/${item?.flight_id}`);
              }}
            >
              Add Trips
            </button>
            <button
              onClick={() => {
                setOpenView(true);
                setSelectedItem(item);
              }}
            >
              View
            </button>
            <button
              className="get-companion-btn"
              onClick={() => getCompanionFlights(item.flight_id)}
            >
              View Companion
            </button>
            <button
              onClick={() => {
                setOpenUpdateForm(true);
                setSelectedItem(item);
              }}
            >
              Set Update Deadline
            </button>

            <button
              onClick={() => {
                setOpenTicketForm(true);
                setSelectedItem(item);
              }}
            >
              Set Ticket
            </button>
          </div>
        ),
      };
    });
  };

  return (
    <div className="flight-form2">
    <div className="flight-form">
    <div className="flight-form-admin-header">
        <div className="header">
          <Input
            label="Passenger Name	"
            placeholder="Search"
            inputValue={travelerName}
            setInputValue={setTravelerName}
            type="text"
          />
        </div>
      </div>

      <div className="flight-table-container">
        <Table headers={headers} data={handleTableData()} />
        <Pagination
          currentPage={currentPage}
          totalPages={totalPages}
          onPageChange={handlePageChange}
        />
      </div>

      <CompanionModal
        isOpen={openCompanionModal}
        setIsOpen={setOpenCompanionModal}
        companions={companions}
        headers={headers}
      />

      <MySideDrawer isOpen={openView} setIsOpen={setOpenView}>
        <FlightDetails data={selectedItem} />
      </MySideDrawer>
      <MySideDrawer isOpen={openTripForm} setIsOpen={setOpenTripForm}>
        <AddTripForm data={selectedItem} setOpen={setOpenTripForm} />
      </MySideDrawer>
      <MySideDrawer isOpen={openPriceForm} setIsOpen={setOpenPriceForm}>
        <SeatCostForm data={selectedItem} setOpen={setOpenPriceForm} />
      </MySideDrawer>

      <MySideDrawer isOpen={openUpdateForm} setIsOpen={setOpenUpdateForm}>
        <UpdateDeadline data={selectedItem} setOpen={setOpenUpdateForm} />
      </MySideDrawer>
      <MySideDrawer isOpen={openTicketForm} setIsOpen={setOpenTicketForm}>
        <UpdateTicket data={selectedItem} setOpen={setOpenTicketForm} />
      </MySideDrawer>
      </div>
      </div>
    );
};

export default FlightFormAdmin;
