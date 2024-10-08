<?php

use App\Http\Controllers\AcceptedFlightController;
use App\Http\Controllers\AdditionalOptionsController;
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
use App\Http\Controllers\ConferenceImageController;
use App\Http\Controllers\ConferenceTripController;
use App\Http\Controllers\ExhibitionImagesController;
use App\Http\Controllers\FlightController;
use App\Http\Controllers\GroupTripParticipantController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\PaperController;
use App\Http\Controllers\ReservationsController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\SpeakerController;
use App\Http\Controllers\TouristSiteController;
use App\Http\Controllers\TripController;
use App\Http\Controllers\TripParticipantController;
use App\Http\Controllers\VisaController;
use App\Http\Controllers\WhatsAppController;
use App\Models\AvailableFlight;
use App\Models\Flight;
use Illuminate\Support\Facades\Route;

// Sanctum::routes();
Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');



Route::post('/users/{conference_id}', [UserController::class, 'store']);
// فقط الادمن يعدل على ال status   للمتحدث id 
Route::put('/users/{id}/status', [UserController::class, 'updateStatus'])->middleware(['auth:sanctum', 'admin']);

// notification

Route::post('/users/not/email/{id}', [AuthController::class, 'sendNotification'])->middleware('auth:sanctum');
// Route::post('/users/not/database/{id}', [NotificationController::class, 'sendNotification']);
// whatsApp
Route::post('users/whatsapp-not', [WhatsAppController::class, 'sendWhatsAppNotification']);
// conference
Route::post('/con', [ConferenceController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/{status}', [ConferenceController::class, 'getConferenceByStatus']);
Route::get('/con', [ConferenceController::class, 'getAllConferences']);
Route::get('/con/id/{id}', [ConferenceController::class, 'getConferenceById']);


Route::post('/con/img/{conference_id}', [ConferenceImageController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/img/{conference_id}', [ConferenceImageController::class, 'getByConference']);
Route::post('/con/committee', [CommitteeMemberController::class, 'store'])->middleware(['auth:sanctum', 'admin']);


Route::post('/con/topic', [ScientificTopicController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/stopic/{id}', [ScientificTopicController::class, 'show']);
Route::delete('/con/stopic/{id}', [ScientificTopicController::class, 'destroy'])->middleware(['auth:sanctum', 'admin']);

Route::post('/con/{conference_id}/prices', [PricesController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/con/{conference_id}/{price_id}/prices', [PricesController::class, 'deletePriceByConferenceId'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/prices', [PricesController::class, 'getPricesByConferenceId']);

Route::post('/con/scientific-papers/{conferenceId}', [ScientificPaperController::class, 'store']);

// exhibitions
Route::post('/exhibitions', [ExhibitionController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/exhibitions/{status}', [ExhibitionController::class, 'getExhibitionsByStatus']);
Route::get('/exhibitions/id/{id}', [ExhibitionController::class, 'getExhibitionById']);
Route::delete('/exhibitions/{id}', [ExhibitionController::class, 'deleteExhibitionById'])->middleware(['auth:sanctum', 'admin']);
Route::post('/exhibition-images', [ExhibitionImagesController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('exhibition-images/{exhibitionId}', [ExhibitionImagesController::class, 'getImagesByExhibitionId']);
Route::delete('exhibition-images/{exhibitionId}/{imageId}', [ExhibitionImagesController::class, 'deleteImageByExhibitionIdAndImageId'])->middleware(['auth:sanctum', 'admin']);

// tourist-sites
Route::post('/tourist-sites', [TouristSiteController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/tourist-sites/{id}', [TouristSiteController::class, 'destroy'])->middleware(['auth:sanctum', 'admin']);
Route::get('/tourist-sites', [TouristSiteController::class, 'index']);

// For API routes in routes/api.php
Route::post('/papers', [PaperController::class, 'create']);
Route::get('/papers/con/{conference_id}', [PaperController::class, 'getPapersByConferenceId'])->middleware(['auth:sanctum', 'admin']);
Route::get('/papers/{paper_id}', [PaperController::class, 'getPaperById']);

// speakers
Route::post('/speakers', [SpeakerController::class, 'store'])->middleware('auth:sanctum');
Route::put('/speakers/admin/{user_id}', [SpeakerController::class, 'updateByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::put('/speakers/user', [SpeakerController::class, 'updateOnlineParticipation'])->middleware('auth:sanctum');
Route::post('/speakers/certi/{user_id}', [SpeakerController::class, 'updateCertificateFile'])->middleware(['auth:sanctum', 'admin']);



// sendNotification for user and admin  and store it in database
Route::post('/not', [NotificationController::class, 'sendNotification']);
Route::get('/not/{userId}', [NotificationController::class, 'getAllNotificationsByUserId'])->middleware('auth:sanctum');

// visa
Route::post('/visa', [VisaController::class, 'postVisaByUser'])->middleware('auth:sanctum');
Route::post('/admin/update-visa/{userId}', [VisaController::class, 'updateVisaByAdmin'])->name('admin.updateVisa');


// Flight
Route::post('/flights', [FlightController::class, 'createFlight'])->middleware('auth:sanctum');
Route::get('/flight', [FlightController ::class , 'getFlightByUserId'])->middleware('auth:sanctum');
Route::get('/companion-flight', [FlightController ::class , 'getFlightByUserIdForCompanion'])->middleware('auth:sanctum');
Route::get('/user/pag/filter', [FlightController ::class , 'getAllFlightsPaginationAndFilter'])->middleware(['auth:sanctum', 'admin']);

Route::post('/user/update-flight/{flight_id}', [FlightController ::class , 'updateFlightByUser'])->middleware('auth:sanctum');
Route::put('/admin/update-flight/{flight_id}', [FlightController ::class , 'updateByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::delete('/flights/{flight_id}', [FlightController::class, 'deleteFlightByUser'])->middleware('auth:sanctum');

// AvailableFlight
Route::post('/available-flights', [AvailableFlightController::class, 'store'])->middleware(['auth:sanctum', 'admin']);
Route::get('/available-flights/{flight_id}', [AvailableFlightController::class, 'getAvailableFlightByFlightId'])->middleware('auth:sanctum');
// accepted_flight
Route::post('/accepted-flights', [AcceptedFlightController::class, 'store'])->middleware('auth:sanctum');
Route::get('/accepted-flights/{flight_id}', [AcceptedFlightController::class, 'getAcceptedFlightByFlightId']);
Route::post('/accepted-flights/{flight_id}', [AcceptedFlightController::class, 'updateByAdmin'])->middleware(['auth:sanctum', 'admin']);
Route::get('/ticket/download/{id}', [AcceptedFlightController::class, 'downloadTicket']);


Route::post('/reservation', [ReservationsController::class, 'createReservation'])->middleware('auth:sanctum');
Route::delete('/reservation/{id}', [ReservationsController::class, 'deleteReservation'])->middleware('auth:sanctum');
Route::put('/reservation/{id}', [ReservationsController::class, 'updateReservation'])->middleware('auth:sanctum');
Route::get('/reservation', [ReservationsController::class, 'getReservationsByUserId'])->middleware('auth:sanctum');
Route::get('/all_reservation', [ReservationsController::class, 'getAllReservations'])->middleware(['auth:sanctum','admin']);
Route::put('/reservations/{id}/update-deadline', [ReservationsController::class, 'updateDeadlineByAdmin'])->middleware(['auth:sanctum','admin']);


Route::post('/room', [RoomController::class, 'store'])->middleware('auth:sanctum');
Route::post('/update_admin/room/{id}', [RoomController::class, 'updateByAdmin'])->middleware(['auth:sanctum','admin']);
Route::put('/update_user/room/{id}', [RoomController::class, 'updateByUser'])->middleware('auth:sanctum');



// trips
Route::post('/trips', [TripController::class, 'addTrip'])->middleware(['auth:sanctum','admin']);
Route::post('/add_group-trip', [TripController::class, 'addGroupTrip'])->middleware(['auth:sanctum','admin']);
Route::get('/all-trip', [TripController::class, 'getAllTrips'])->middleware(['auth:sanctum','admin']);

// trip-participants
Route::post('/trip-participants', [TripParticipantController::class, 'addParticipant'])->middleware('auth:sanctum');
// group-trip-participants
Route::post('/group-trip-participants', [GroupTripParticipantController::class, 'store'])->middleware('auth:sanctum');

// conference-trips
Route::post('/conference-trips', [ConferenceTripController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('conferences/{conferenceId}/trips/{tripType}', [ConferenceTripController::class, 'getTripsByConferenceId'])->middleware('auth:sanctum');
Route::delete('/conference/{conferenceId}/trip/{tripId}', [ConferenceTripController::class, 'destroy']);
// additional-options
Route::post('/additional-options', [AdditionalOptionsController::class, 'store'])->middleware(['auth:sanctum','admin']);
Route::get('/additional-options/trip/{trip_id}', [AdditionalOptionsController::class, 'getAdditionalOptionsByTripId']);
