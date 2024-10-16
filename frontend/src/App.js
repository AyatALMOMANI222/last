import React, { useEffect, useState } from "react";
import { Routes, Route, useLocation } from "react-router-dom";
import { ToastContainer } from "react-toastify";
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
import ViewUserTrips from "./components/TripComponents/TripsUser/ViewTrips";
import ViewOneTripUser from "./components/TripComponents/TripsUser/ViewOneTripUser";
import AirportTransfer from "./components/last_pages/AirportTransfer";
import AirportTransferPrice from "./components/last_pages/AirportTransfer/AirpotPrice";
import GalaDinner from "./components/last_pages/GalaDinner";
import AddScientificPaper from "./components/SceintificPaper";
import VisaPage from "./components/last_pages/Visa";
import HomeR from "./pages/HomeR";
import AboutUsEvent from "./components/UI/AboutUs";
import OurClients from "./components/UI/OurClients";
import OurTeams from "./components/UI/OurTeam";
import ManagementConsulting from "./components/UI/ManagementConsulting";
import Planning from "./components/UI/EventPlanning";
import SocialEvents from "./components/UI/SocialEvents";
import MediaCampaign from "./components/UI/MediaCampaign";
import LogisticSecretarial from "./components/UI/LogisticSecretarial";
import TourSlider from "./components/UI/TourAndTourism";
import Expositions from "./components/UI/Expositions";
import Workshops from "./components/UI/Workshop";
import Seminars from "./components/UI/Seminars";
import CorporateMeetings from "./components/UI/CorporateMeetings";
import ConceptCreation from "./components/UI/ConceptCreation";
import Conference from "./components/UI/Conference/ConferenceData";
import Navbar from "./components/UI/Navbar";
import ContactUs from "./components/UI/ContactUs";
import TopNavbar from "./components/UI/NavigationBar";
import Audiovisuals from "./components/UI/Audiovisuals";
import Conference3 from "./components/UI/conferece2";
import EditSpeakerData from "./components/Admin/EditSpeakerData";


const App = () => {
  const location = useLocation();
  const [showLoader, setShowLoader] = useState(false);

  // Listen for showLoader and hideLoader events
  useEffect(() => {
    const handleShowLoader = () => setShowLoader(true);
    const handleHideLoader = () => setShowLoader(false);

    // Attach event listeners
    window.addEventListener('showLoader', handleShowLoader);
    window.addEventListener('hideLoader', handleHideLoader);

    // Cleanup event listeners on component unmount
    return () => {
      window.removeEventListener('showLoader', handleShowLoader);
      window.removeEventListener('hideLoader', handleHideLoader);
    };
  }, []);

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
    "/user",
    "/view-user-trips",
    "/view/trip/:id"
  ];

  return (
    <div id="main" className="main">
      <ToastContainer />
      <Loader show={showLoader} />
      {/* Conditionally render the NavBar based on the current route */}
      {navBarRoutes.includes(location.pathname) && <NavBar />}
      {/* <TopNavbar/> */}
      {/* <Navbar/> */}
      <Routes className="main">
      <Route path="/exhibitions" element={<Exhibitions />} />
      <Route path="/edit/speaker/data" element={<EditSpeakerData />} />
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
        <Route path="/view-user-trips" element={<ViewUserTrips />} />  
        {/* //this route for view one trip for user not admin  */}
          <Route path="/view/trip/:id" element={<ViewOneTripUser />} />


          <Route path="/airport/transfer" element={<AirportTransfer />} />
          <Route path="/airport/transfer/price" element={<AirportTransferPrice />} />
          <Route path="/GalaDinner" element={<GalaDinner />} />
          <Route path="/paper" element={<AddScientificPaper/>} />
          <Route path="/visa" element={< VisaPage/>} />
          <Route path="/home" element={<HomeR/>} />
          <Route path="/about_us" element={<AboutUsEvent/>} />
          <Route path="/our_clients" element={<OurClients/>} />
          <Route path="/our_team" element={<OurTeams/>} />
          <Route path="/management_consulting" element={<ManagementConsulting/>} />
          <Route path="/planning" element={<Planning/>} />
          <Route path="/social_events" element={<SocialEvents/>} />
          <Route path="/media_campaign" element={<MediaCampaign />} />
          <Route path="/logistic_secretarial" element={<LogisticSecretarial/>} />
          <Route path="/tour_slider" element={<TourSlider/>} />
          <Route path="/expositions" element={<Expositions/>} />
          <Route path="/workshops" element={<Workshops/>} />
          <Route path="/seminars" element={<Seminars/>} />
          <Route path="/corporate_meetings" element={<CorporateMeetings/>} />
          <Route path="/concept_creation" element={< ConceptCreation/>} />
          <Route path="/ser" element={< Conference/>} />
          <Route path="/contact_us" element={< ContactUs/>} />
          <Route path="/top_navbar" element={<TopNavbar/>} />
          <Route path="/audiovisuals" element={<Audiovisuals/>} />

          <Route path="/conf" element={<Conference3/>} />

      </Routes>
    </div>
  );
};

export default App;
