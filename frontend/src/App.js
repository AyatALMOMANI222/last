import React, { useEffect, useState } from "react";
import { Routes, Route, useLocation } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import eventEmitter from "./common/eventEmitter"; 
import LoginPage from "./pages/login";
import RegisterPage from "./pages/register";
import HomePage from "./pages/home";
import "./style.scss";
import NavBar from "./components/Navbar";
import AboutUs from "./pages/aboutUs";
import Dashboard from "./pages/Dashboard";
import ConferencesPage from "./pages/Conferences";
import RegisterType from "./pages/RegisterType";
import FlightForm from "./components/FlightForm";
import FlightFormAdmin from "./components/FlightFormAdmin";
import ConferencesAdmin from "./components/ConferencesAdmin";
import Exhibitions from "./pages/Exhibitions";
import SelectConferences from "./pages/SelectConferences";
import Reservation from "./components/Reservation";
import CreateTrip from "./components/TripComponents/AddTrip";
import ViewTrip from "./components/TripComponents/viewTrips";
import UsersList from "./components/UserList";
import Loader from "./CoreComponent/Loader";

const App = () => {
  const location = useLocation();
  const [showLoader, setShowLoader] = useState(false);

  // Define the routes where the NavBar should be displayed
  const navBarRoutes = [
    "/favorite",
    "/about",
    "/newbook",
    "/dashboard",
    "/",
    "/flight/form",
    "/flights",
    "/conferences",
    "/exhibitions",
    "/reservation/form",
    "/create/trip",
    "/user"
  ];

  useEffect(() => {
    const showLoaderListener = () => setShowLoader(true);
    const hideLoaderListener = () => setShowLoader(false);

    eventEmitter.on('showLoader', showLoaderListener);
    eventEmitter.on('hideLoader', hideLoaderListener);


    return () => {
      eventEmitter.off('showLoader', showLoaderListener);
      eventEmitter.off('hideLoader', hideLoaderListener);
    };
  }, []);

  return (
    <div id="main" className="main">
      <ToastContainer />
      <Loader show={showLoader} />
      {/* Conditionally render the NavBar based on the current route */}
      {navBarRoutes.includes(location.pathname) && <NavBar />}
      <Routes className="main">
        <Route path="/exhibitions" element={<Exhibitions />} />
        <Route path="/reservation/form" element={<Reservation />} />
        <Route path="/conferences" element={<ConferencesAdmin />} />
        <Route path="/flights" element={<FlightFormAdmin />} />
        <Route path="/flight/form" element={<FlightForm />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register/:type/:id" element={<RegisterPage />} />
        <Route path="/register/:type" element={<SelectConferences />} />
        <Route path="/" element={<HomePage />} />
        <Route path="/about" element={<AboutUs />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/registertype" element={<RegisterType />} />
        <Route path="/create/trip" element={<ViewTrip />} />
        <Route path="/user" element={<UsersList />} />
      </Routes>
    </div>
  );
};

export default App;
