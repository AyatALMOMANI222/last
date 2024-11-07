import React, { useEffect, useState } from "react";
import { Routes, Route, useLocation } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import LoginPage from "./pages/login";
import RegisterPage from "./pages/register";
import HomePage from "./pages/home";
import "./style.scss";
import NavBar from "./components/Navbar";
import AboutUs from "./pages/aboutUs";
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
import Packages from "./components/UI/Packages";
import Welcome from "./components/UI/Welcome";
import AdventureSection from "./components/UI/individuals";
import TicketBooking from "./components/UI/TicketBooking";
import HotelBooking from "./components/UI/HotelBooking";
import Transportation from "./components/UI/Transportation";
import SpeakerProfileForm from "./components/SpeakerProfileEditForm";
import RegisterSponsorPage from "./components/Registeration/Sponsor";
import RegisterAttendancePage from "./components/Registeration/attendance";
import AdminVisa from "./components/AdminVisa";
import FAQ from "./components/UI/FAQ";
import Dashboard from "./components/dashboard";
import Footer from "./components/UI/Footer";
import ExcelUpload from "./components/Registeration/Group-Registeration/AddExelFile";
import AdminGroupComponent from "./components/Registeration/Group-Registeration/AdminUpdate";
import RegisterGroupPage from "./components/Registeration/Group-Registeration";
import MainFlightFormUpdate from "./components/FlightForm/updateMainFlightForm";
import GetCompanion from "./components/FlightForm/GetCompanion";
import Stepper from "./CoreComponent/stepper";
import ParentComponent from "./components/ReservationstepperPage";
import TripsStepperPage from "./components/TripsStepperPage/index";
import Lastt from "./components/ReservationstepperPage/last";
import FlightStepperPage from "./components/FlightStepperPage";
import FlightStepperPageAdmin from "./components/FlightStepperPageAdmin";
import DinnerDetails from "./components/GalaDinner";
import SponsorSection from "./components/Sponsor/SponsorshipOption";
import UpdateVisaStatus from "./components/UpdateVisaStatus";
import AcceptFlight from "./components/FlightStepperAcceptFlight/AcceptFlight";
import StepperAcceptFlight from "./components/FlightStepperAcceptFlight";
import NotificationMessage from "./components/GroupNotificationMessage";
import SpeakerTable from "./components/GalaDinner/AdminDinnerView";
import BookingsTable2 from "./components/BookingsTable";
import UpcomingConferences from "./components/UpcomingConferences";
import CreateJob from "./components/Jobs/CreateJob";
import JobList from "./components/Jobs/GetJobs";
import JobApplicants from "./components/Jobs/AdminApplicantList";
import ApplicantsList from "./components/Jobs/AdminApplicantList/applicants/applicants";
import Messages from "./components/Msg";
import EditAttendanceData from "./components/Admin/EditAttendanceData";
import PendingUsersTable from "./components/Admin/PendingUsers";
// import SponsorshipForm from "./components/Sponsor/AdminSponsorOption";
// import Echo from "laravel-echo";
// import Pusher from 'pusher-js';
const App = () => {
  const location = useLocation();
  const [showLoader, setShowLoader] = useState(false);

  // Listen for showLoader and hideLoader events
  useEffect(() => {
    const handleShowLoader = () => setShowLoader(true);
    const handleHideLoader = () => setShowLoader(false);

    // Attach event listeners
    window.addEventListener("showLoader", handleShowLoader);
    window.addEventListener("hideLoader", handleHideLoader);

    // Cleanup event listeners on component unmount
    return () => {
      window.removeEventListener("showLoader", handleShowLoader);
      window.removeEventListener("hideLoader", handleHideLoader);
    };
  }, []);

  // const echo = new Echo({
  //   broadcaster: "pusher",
  //   key: "743171d2766ff157a71a",
  //   cluster: "ap2",
  //   forceTLS: true,
  // });
  const noNavRoute = [
    "/registertype",
    "/register/speaker",
    "/registerPage",
    "/login",
  ];
  useEffect(() => {
    console.log(location.pathname);
    console.log("/registerPage/speaker/1".includes("registerPage"));
  });
  return (
    <div id="main" className="main">
      <ToastContainer />
      <Loader show={showLoader} />
      {!noNavRoute.includes(location.pathname) &&
        !location.pathname.includes("/registerPage") && <NavBar />}

      <Routes className="main">
        <Route path="/exhibitions" element={<Exhibitions />} />
        <Route path="/trip/user/:tripId" element={<TripsStepperPage />} />
        <Route path="/" element={<Dashboard />} />
        <Route
          path="/edit/speaker/data/:conferenceId/:userId"
          element={<EditSpeakerData />}
        />{" "}
        <Route
          path="/edit/attendance/data/:conferenceId/:userId"
          element={<EditAttendanceData />}
        />
        <Route path="/reservation/form" element={<Reservation />} />
        <Route path="/conferences" element={<ConferencesAdmin />} />
        <Route path="/flights" element={<FlightFormAdmin />} />
        <Route path="/flight/form" element={<FlightForm />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register/speaker/:id" element={<RegisterPage />} />
        <Route path="/registerPage/:type" element={<SelectConferences />} />
        <Route path="/conferences/page" element={<HomePage />} />
        <Route path="/about" element={<AboutUs />} />
        <Route path="/registertype" element={<RegisterType />} />
        <Route
          path="register/attendance/:conferenceId"
          element={<RegisterAttendancePage />}
        />
        <Route
          path="/register/group/:conferenceId"
          element={<RegisterGroupPage />}
        />
        <Route path="/stepper" element={<ParentComponent />} />
        <Route path="register/sponsor" element={<RegisterSponsorPage />} />
        <Route path="/create/trip" element={<ViewTrip />} />
        <Route path="/user" element={<UsersList />} />
        <Route path="/view-user-trips" element={<ViewUserTrips />} />
        {/* //this route for view one trip for user not admin  */}
        <Route path="/view/trip/:id" element={<ViewOneTripUser />} />
        <Route path="/airport/transfer" element={<AirportTransfer />} />
        <Route
          path="/airport/transfer/price"
          element={<AirportTransferPrice />}
        />
        <Route path="/gala" element={<GalaDinner />} />
        <Route path="/gala/dinner" element={<DinnerDetails />} />
        <Route path="/paper" element={<AddScientificPaper />} />
        <Route path="/visa" element={<VisaPage />} />
        <Route path="/home" element={<HomeR />} />
        <Route path="/about_us" element={<AboutUsEvent />} />
        <Route path="/our_clients" element={<OurClients />} />
        <Route path="/our_team" element={<OurTeams />} />
        <Route
          path="/management_consulting"
          element={<ManagementConsulting />}
        />
        <Route path="/planning" element={<Planning />} />
        <Route path="/social_events" element={<SocialEvents />} />
        <Route path="/media_campaign" element={<MediaCampaign />} />
        <Route path="/logistic_secretarial" element={<LogisticSecretarial />} />
        <Route path="/tour_slider" element={<TourSlider />} />
        <Route path="/expositions" element={<Expositions />} />
        <Route path="/workshops" element={<Workshops />} />
        <Route path="/seminars" element={<Seminars />} />
        <Route path="/corporate_meetings" element={<CorporateMeetings />} />
        <Route path="/concept_creation" element={<ConceptCreation />} />
        <Route path="/ser" element={<Conference />} />
        <Route path="/contact_us" element={<ContactUs />} />
        <Route path="/top_navbar" element={<TopNavbar />} />
        <Route path="/audiovisuals" element={<Audiovisuals />} />
        <Route path="/conf" element={<Conference3 />} />
        <Route path="/packages" element={<Packages />} />
        <Route path="/welcome" element={<Welcome />} />
        <Route path="/adventureSection" element={<AdventureSection />} />
        <Route path="/ticket/booking" element={<TicketBooking />} />
        <Route path="/hotel/booking" element={<HotelBooking />} />
        <Route path="/transportation" element={<Transportation />} />
        <Route path="/speaker/profile" element={<SpeakerProfileForm />} />
        <Route path="/admin/visa" element={<AdminVisa />} />
        <Route path="/add/excel" element={<ExcelUpload />} />
        <Route
          path="/group/update/admin/:register_id"
          element={<AdminGroupComponent />}
        />
        <Route path="/flights/users" element={<FlightStepperPage />} />
        <Route
          path="/flights/admins/:user_id"
          element={<FlightStepperPageAdmin />}
        />
        <Route
          path="/user/flight/update/:id"
          element={<MainFlightFormUpdate />}
        />
        <Route path="/companion" element={<GetCompanion />} />
        <Route path="/admin/visa2/:registerId" element={<UpdateVisaStatus />} />
        <Route path="/faq" element={<FAQ />} />
        <Route path="/sponsor/section" element={<SponsorSection />} />
        <Route
          path={`/accept/flight/:user_id`}
          element={<StepperAcceptFlight />}
        />
        <Route path="/group/msg" element={<NotificationMessage />} />
        {/* admin table view */}
        <Route
          path="/table/dinner/speaker/:conferenceId"
          element={<SpeakerTable />}
        />
        <Route
          path="/table/booking/airport/:conferenceId"
          element={<BookingsTable2 />}
        />
        <Route path="/upcoming/conferences" element={<UpcomingConferences />} />
        <Route path="/job/list" element={<JobList />} />
        <Route path="/job" element={<CreateJob />} />
        <Route path="/job/admin" element={<JobApplicants />} />
        <Route path="/pending/users" element={<PendingUsersTable />} />
        <Route
          path="/job/admin/Applicants/:jobId"
          element={<ApplicantsList />}
        />
        <Route path="/msgs" element={<Messages />} />
        {/* <Route path="/sponsor/option/form" element={<SponsorshipForm/>} /> */}
      </Routes>
      {/* <Footer/> */}
    </div>
  );
};

export default App;
