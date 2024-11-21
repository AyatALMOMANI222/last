<?php

use App\Http\Controllers\AcceptedFlightController;
use App\Http\Controllers\AdditionalOptionsController;
use App\Http\Controllers\AirportTransferBookingController;
use App\Http\Controllers\AirportTransferPriceController;
use App\Http\Controllers\ApplicantController;
use App\Http\Controllers\ApplicantJobController;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\PrivateInvoiceTripController;
use Laravel\Sanctum\Sanctum;

use App\Http\Controllers\CommitteeMemberController;
use App\Http\Controllers\ConferenceController;
use App\Http\Controllers\ExhibitionController;
use App\Http\Controllers\PricesController;
use App\Http\Controllers\ScientificPaperController;
use App\Http\Controllers\ScientificTopicController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\AvailableFlightController;
use App\Http\Controllers\AvailableJobController;
use App\Http\Controllers\BoothCostController;
use App\Http\Controllers\ConferenceImageController;
use App\Http\Controllers\ConferenceSponsorshipOptionController;
use App\Http\Controllers\ConferenceTripController;
use App\Http\Controllers\ConferenceUserController;
use App\Http\Controllers\DinnerAttendeeController;
use App\Http\Controllers\DinnerDetailController;
use App\Http\Controllers\DinnerSpeakerCompanionFeeController;
use App\Http\Controllers\DiscountOptionController;
use App\Http\Controllers\ExhibitionImagesController;
use App\Http\Controllers\FlightController;
use App\Http\Controllers\GroupRegistrationController;
use App\Http\Controllers\GroupTripParticipantController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\OurClientController;
use App\Http\Controllers\PaperController;
use App\Http\Controllers\ReservationsController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\RoomPriceController;
use App\Http\Controllers\SpeakerController;
use App\Http\Controllers\SponsorController;
use App\Http\Controllers\SponsorshipController;
use App\Http\Controllers\SponsorshipOptionController;
use App\Http\Controllers\TicketBookingController;
use App\Http\Controllers\TourismTripController;
use App\Http\Controllers\TouristSiteController;
use App\Http\Controllers\TransportationRequestController;
use App\Http\Controllers\TravelFormController;
use App\Http\Controllers\TripController;
use App\Http\Controllers\TripParticipantController;
use App\Http\Controllers\VisaController;
use App\Http\Controllers\WhatsAppController;
use App\Models\AvailableFlight;
use App\Models\DinnerDetail;
use App\Models\Flight;
use App\Models\Sponsor;
use Illuminate\Support\Facades\Route;

// Sanctum::routes();
Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');



Route::post('/users/{conference_id}', [UserController::class, 'store']);
// فقط الادمن يعدل على ال status   للمتحدث id 
Route::put('/users/{id}/status', [UserController::class, 'updateStatus'])->middleware(['auth:sanctum', 'admin']);
Route::get('/users', [UserController::class, 'getAllUsers'])->middleware(['auth:sanctum', 'admin']);
Route::get('/user', [UserController::class, 'getUserById'])->middleware(['auth:sanctum']);

// notification

Route::post('/users/not/email/{id}', [AuthController::class, 'sendNotification'])->middleware('auth:sanctum');
// Route::post('/users/not/database/{id}', [NotificationController::class, 'sendNotification']);
// whatsApp
Route::post('/notifications/{notificationId}/read', [NotificationController::class, 'markNotificationAsRead']);

Route::post('users/whatsapp-not', [WhatsAppController::class, 'sendWhatsAppNotification']);
// conference
Route::post('/con', [ConferenceController::class, 'store']);
Route::get('/con/status/{status}', [ConferenceController::class, 'getConferenceByStatus']);
Route::get('/con', [ConferenceController::class, 'getAllConferences']);
Route::get('/con/id/{id}', [ConferenceController::class, 'getConferenceById']);
Route::post('/conferences/{id}', [ConferenceController::class, 'update'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/upcoming', [ConferenceController::class, 'getAllConferencesUpcoming']);


Route::post('/con/img/{conference_id}', [ConferenceImageController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/img/{conference_id}', [ConferenceImageController::class, 'getByConference']);
Route::post('/con/committee', [CommitteeMemberController::class, 'store'])->middleware(['auth:sanctum', 'admin']);


Route::post('/con/topic', [ScientificTopicController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/stopic/{id}', [ScientificTopicController::class, 'show']);
Route::delete('/con/stopic/{id}', [ScientificTopicController::class, 'destroy'])->middleware(['auth:sanctum', 'admin']);

Route::post('/con/{conference_id}/prices', [PricesController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/con/{conference_id}/{price_id}/prices', [PricesController::class, 'deletePriceByConferenceId'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/prices', [PricesController::class, 'getPricesByConferenceId']);

// Route::post('/con/scientific-papers', [ScientificPaperController::class, 'store']);

// exhibitions
Route::post('/exhibitions', [ExhibitionController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/exhibitions', [ExhibitionController::class, 'getAllExhibitions']);
Route::get('/exhibitions/id/{id}', [ExhibitionController::class, 'getExhibitionById']);
Route::delete('/exhibitions/{id}', [ExhibitionController::class, 'deleteExhibitionById'])->middleware(['auth:sanctum', 'admin']);
Route::post('/exhibition-images', [ExhibitionImagesController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('exhibition-images/{exhibitionId}', [ExhibitionImagesController::class, 'getImagesByExhibitionId']);
Route::delete('exhibition-images/{exhibitionId}/{imageId}', [ExhibitionImagesController::class, 'deleteImageByExhibitionIdAndImageId'])->middleware(['auth:sanctum', 'admin']);
Route::post('/exhibitions/update/{id}', [ExhibitionController::class, 'update'])->middleware(['auth:sanctum', 'admin']);

// tourist-sites
Route::post('/tourist-sites', [TouristSiteController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/tourist-sites/{id}', [TouristSiteController::class, 'destroy'])->middleware(['auth:sanctum', 'admin']);
Route::get('/tourist-sites', [TouristSiteController::class, 'index']);

// For API routes in routes/api.php
Route::post('/abstract', [PaperController::class, 'store']);
Route::put('/abstract/con/{conference_id}/user/{user_id}', [PaperController::class, 'updateByAdmin']);
// ->middleware(['auth:sanctum', 'admin']);


Route::get('/papers/con/{conference_id}', [PaperController::class, 'getPapersByConferenceId'])->middleware(['auth:sanctum', 'admin']);
Route::get('/papers/{paper_id}', [PaperController::class, 'getPaperById']);

// speakers
Route::post('/admin/speakers/{user_id}/{conference_id}', [SpeakerController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::post('/speakers/user/update', [SpeakerController::class, 'updateByUser'])->middleware('auth:sanctum');
Route::put('/speakers/user', [SpeakerController::class, 'updateOnlineParticipation'])->middleware('auth:sanctum');
Route::post('/speakers/certi/{user_id}', [SpeakerController::class, 'updateCertificateFile'])->middleware(['auth:sanctum', 'admin']);
Route::get('/speakers/info', [SpeakerController::class, 'getSpeakerInfoByToken'])->middleware('auth:sanctum');



// sendNotification for user and admin  and store it in database
Route::post('/not', [NotificationController::class, 'sendNotification']);
Route::get('/not', [NotificationController::class, 'getAllNotificationsByUserId'])->middleware('auth:sanctum');

// visa
Route::post('/visa', [VisaController::class, 'postVisaByUser'])->middleware('auth:sanctum');
Route::post('/admin/update-visa/{userId}', [VisaController::class, 'updateVisaByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::get('/visa', [VisaController::class, 'getVisaByAuthUser'])->middleware('auth:sanctum');
// Route::put('/admin/update-visa/{userId}', [VisaController::class, 'updateVisaByAdmin']);


// Flight
Route::post('/flights', [FlightController::class, 'createFlight'])->middleware('auth:sanctum');
Route::get('/flight', [FlightController ::class , 'getFlightByUserId'])->middleware('auth:sanctum');
Route::get('/companion-flight/{user_id}', [FlightController ::class , 'getFlightByUserIdForCompanion'])->middleware('auth:sanctum');
Route::get('/user/pag/filter', [FlightController ::class , 'getAllFlightsPaginationAndFilter'])->middleware(['auth:sanctum', 'admin']);
Route::get('/flight/id/{flight_id}', [FlightController ::class , 'getFlightById']);

Route::post('/user/update-flight', [FlightController ::class , 'updateFlightByUser'])->middleware('auth:sanctum');
Route::post('/admin/update-flight', [FlightController ::class , 'updateByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/flights/{flight_id}', [FlightController::class, 'deleteFlightByUser'])->middleware('auth:sanctum');

// AvailableFlight
Route::post('/available-flights', [AvailableFlightController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::post('/available-flights/all', [AvailableFlightController::class, 'storeAll'])->middleware(['auth:sanctum', 'admin']);

Route::get('/available-flights/{flight_id}', [AvailableFlightController::class, 'getAvailableFlightByFlightId'])->middleware('auth:sanctum');
// accepted_flight
Route::post('/accepted-flights', [AcceptedFlightController::class, 'store'])->middleware('auth:sanctum');
Route::get('/accepted-flights/{flight_id}', [AcceptedFlightController::class, 'getAcceptedFlightByFlightId']);
Route::post('/accepted-flights/{flight_id}', [AcceptedFlightController::class, 'updateByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::get('/ticket/download/{id}', [AcceptedFlightController::class, 'downloadTicket']);
Route::post('/accepted-flights/user/all', [AcceptedFlightController::class, 'storeAll'])->middleware('auth:sanctum');
Route::get('/other/accepted-flights', [AcceptedFlightController::class, 'getFlightsWhereIsOther'])->middleware('auth:sanctum', 'admin');


Route::post('/reservation', [ReservationsController::class, 'createReservation'])->middleware('auth:sanctum');
Route::delete('/reservation/{id}', [ReservationsController::class, 'deleteReservation'])->middleware('auth:sanctum');
Route::put('/reservation/{id}', [ReservationsController::class, 'updateReservation'])->middleware('auth:sanctum');
Route::get('/reservation', [ReservationsController::class, 'getReservationsByUserId'])->middleware('auth:sanctum');
Route::get('/all_reservation', [ReservationsController::class, 'getAllReservations'])->middleware(['auth:sanctum','admin']);
Route::put('/reservations/{id}/update-deadline', [ReservationsController::class, 'updateDeadlineByAdmin'])->middleware(['auth:sanctum','admin']);


Route::post('/room', [RoomController::class, 'store'])->middleware('auth:sanctum');
Route::post('/update_admin/room/{id}', [RoomController::class, 'updateByAdmin'])->middleware(['auth:sanctum','admin']);
Route::put('/update_user/room/{id}', [RoomController::class, 'updateByUser'])->middleware('auth:sanctum');
Route::post('/room-prices', [RoomPriceController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/room-prices/{conferenceId}', [RoomPriceController::class, 'getPricesByConferenceId'])->middleware('auth:sanctum');


// trips
Route::post('/trips', [TripController::class, 'addTrip'])->middleware(['auth:sanctum','admin']);
Route::post('/add_group-trip', [TripController::class, 'addGroupTrip'])->middleware(['auth:sanctum','admin']);
Route::get('/all-trip', [TripController::class, 'getAllTrips'])->middleware(['auth:sanctum']);
Route::get('/trip/{id}', [TripController::class, 'getTripById'])->middleware(['auth:sanctum','admin']);
Route::post('/update/trips/{id}', [TripController::class, 'updateTripById'])->middleware(['auth:sanctum','admin']);
Route::post('/trips_option/{id}', [TripController::class, 'updateTripAndOptions'])->middleware(['auth:sanctum','admin']);
Route::get('/trip_option/{id}', [TripController::class, 'getTripByIdWithOptions']);


// trip-participants
Route::post('/trip-participants', [TripParticipantController::class, 'addParticipant'])->middleware('auth:sanctum');
Route::post('/group-trip-participants', [GroupTripParticipantController::class, 'store'])->middleware('auth:sanctum');
// Route::post('/trip-participants_user_companion', [TripParticipantController::class, 'storeUserAndParticipant'])->middleware('auth:sanctum');
Route::put('/trip-participants/update', [TripParticipantController::class, 'updateParticipant'])->middleware('auth:sanctum');

// conference-trips
Route::post('/conference-trips', [ConferenceTripController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('conferences/{conferenceId}/trips/{tripType}', [ConferenceTripController::class, 'getTripsByConferenceId'])->middleware('auth:sanctum');
Route::delete('/conference/{conferenceId}/trip/{tripId}', [ConferenceTripController::class, 'destroy']);
Route::get('/conference-trips', [ConferenceTripController::class, 'index'])->middleware(['auth:sanctum','admin']);


// additional-options
Route::post('/additional-options', [AdditionalOptionsController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/additional-options/trip/{trip_id}', [AdditionalOptionsController::class, 'getAdditionalOptionsByTripId']);
Route::put('/additional-options/update-selected-prices/{trip_id}', [AdditionalOptionsController::class, 'updateSelectedOptionsPrices'])->middleware(['auth:sanctum','admin']);


// conference-user
Route::post('/conference-user', [ConferenceUserController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/user/{id}/conferences', [ConferenceUserController::class, 'getConferencesByUser'])->middleware(['auth:sanctum','admin']);
Route::get('/con/up/', [ConferenceUserController::class, 'getUpcomingConferencesByUserId'])->middleware('auth:sanctum');

// DinnerDetail
Route::post('/dinner-details', [DinnerDetailController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/dinners/conference/{conferenceId}', [DinnerDetailController::class, 'getDinnerByConferenceId'])->middleware('auth:sanctum');
Route::put('/dinners/{id}', [DinnerDetailController::class, 'update'])->middleware(['auth:sanctum','admin'])->middleware(['auth:sanctum','admin']);
Route::delete('/dinner-details/{id}', [DinnerDetailController::class, 'destroy'])->middleware(['auth:sanctum','admin']);



// dinner-attendees
Route::post('/dinner/attendees', [DinnerAttendeeController::class, 'store'])->middleware('auth:sanctum');
Route::delete('/dinner-attendees/{id}', [DinnerAttendeeController::class, 'destroy'])->middleware('auth:sanctum');
Route::get('/dinner-attendees', [DinnerAttendeeController::class, 'getAllAttendees'])->middleware(['auth:sanctum','admin']);
Route::get('/dinner/attendees/{conferenceId}', [DinnerAttendeeController::class, 'getAttendeesByConferenceId'])->middleware(['auth:sanctum','admin']);



// discounts
Route::post('/discounts', [DiscountOptionController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/discount-options/{tripId}', [DiscountOptionController::class, 'getDiscountOptions'])->middleware('auth:sanctum');


Route::post('/dinner-speaker-companion-fee', [DinnerSpeakerCompanionFeeController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/dinner-speaker-companion-fees/{dinnerId}', [DinnerSpeakerCompanionFeeController::class, 'getDinnerCompanionFees'])->middleware('auth:sanctum');
// airport-transfer-bookings
Route::post('/airport-transfer-bookings', [AirportTransferBookingController::class, 'store'])->middleware('auth:sanctum');
Route::get('/user/airport-transfer-bookings', [AirportTransferBookingController::class, 'index'])->middleware('auth:sanctum');
Route::get('/admin/all_airport-transfer-bookings', [AirportTransferBookingController::class, 'getAllBooking'])->middleware('auth:sanctum');
Route::put('/airport-transfer-bookings/{id}', [AirportTransferBookingController::class, 'update'])->middleware('auth:sanctum');
Route::get('/admin/airport/{conferenceId}', [AirportTransferBookingController::class, 'getBookingByConferenceId'])->middleware(['auth:sanctum','admin']);

// airport-transfer-prices
Route::post('/airport-transfer-prices', [AirportTransferPriceController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/airport-transfer-prices/conference/{conferenceId}', [AirportTransferPriceController::class, 'getPricesByConferenceId'])->middleware('auth:sanctum');
// Sponsor
Route::post('/sponsor', [SponsorController::class, 'store']);
Route::post('/approve/sponsor', [SponsorController::class, 'approveSponsor'])->middleware(['auth:sanctum','admin']);



// attendance
Route::post('/attendances', [AttendanceController::class, 'storeAttendance']);
Route::get('/attendances', [AttendanceController::class, 'getAttendanceInfoByToken'])->middleware(['auth:sanctum']);
// group
Route::post('/register/group', [GroupRegistrationController::class, 'store']);
Route::put('/group/update/admin/{user_id}', [GroupRegistrationController::class, 'updateGroupByAdminByUserId'])->middleware(['auth:sanctum','admin']);
Route::post('/update/user', [GroupRegistrationController::class, 'updateByUser'])->middleware('auth:sanctum');

Route::get('/group', [GroupRegistrationController::class, 'getRegistrationGroupDataByToken'])->middleware('auth:sanctum');

// ourClients
Route::post('/clients', [OurClientController::class, 'store']);
Route::get('/clients', [OurClientController::class, 'index']);
Route::delete('/clients/{id}', [OurClientController::class, 'destroy']);

Route::post('/job2', [AvailableJobController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/all/job', [AvailableJobController::class, 'getAllJob']);
Route::delete('/job/{id}', [AvailableJobController::class, 'destroy']);
Route::put('/job/{id}', [AvailableJobController::class, 'update'])->middleware(['auth:sanctum','admin']);

// applicants
Route::post('/applicants', [ApplicantController::class, 'store']);
Route::get('/applicants/{jobId}', [ApplicantJobController::class, 'getApplicantsByJobId']);


// msg 
Route::post('/messages', [MessageController::class, 'store']);
Route::get('/messages', [MessageController::class, 'getAllMsg'])->middleware(['auth:sanctum','admin']);

// sponsorship-options
Route::post('/sponsorship-options/{conferenceId}', [SponsorshipOptionController::class, 'store'])->middleware(['auth:sanctum','admin']);

Route::get('/sponsorship-options/{conferenceId}', [SponsorshipOptionController::class, 'getOptionsByConferenceId'])->middleware('auth:sanctum');


// table option
Route::post('/sponsorship-options/table/add', [SponsorshipController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/sponsorship-options/table/get/{conferenceId}', [SponsorshipController::class, 'getByConferenceId']);
Route::post('/size/table/admin', [BoothCostController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/size/table/admin/get/{conferenceId}', [BoothCostController::class, 'getByConferenceId']);



Route::post('/invoice', [InvoiceController::class, 'createInvoice'])->middleware('auth:sanctum');
Route::get('/invoice/{conferenceId}', [InvoiceController::class, 'getInvoiceByUserIdAndConferenceId'])->middleware('auth:sanctum');


Route::post('/private-invoice-trips', action: [PrivateInvoiceTripController::class, 'store'])->middleware(['auth:sanctum']);
Route::get('/invoice/trip/{id}', [PrivateInvoiceTripController::class, 'getInvoiceByParticipantId'])->middleware(['auth:sanctum']);
// TourismTrip
Route::post('/submit-tourism-trip', [TourismTripController::class, 'create']);


// transportation request
Route::post('/trans/req', [TransportationRequestController::class, 'store']);

Route::post('/ticket/booking', [TicketBookingController::class, 'store']);
Route::post('/travel/booking', [TravelFormController::class, 'store']);




Route::get('/trip/participant/get/{userId}', [TripController::class, 'getUserTripOptions']);
