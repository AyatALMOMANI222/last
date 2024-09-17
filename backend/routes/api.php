<?php

use Laravel\Sanctum\Sanctum;

use App\Http\Controllers\CommitteeMemberController;
use App\Http\Controllers\ConferenceController;
use App\Http\Controllers\ExhibitionController;
use App\Http\Controllers\PricesController;
use App\Http\Controllers\ScientificPaperController;
use App\Http\Controllers\ScientificTopicController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ConferenceImageController;
use App\Http\Controllers\ExhibitionImagesController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\PaperController;
use App\Http\Controllers\SpeakerController;
use App\Http\Controllers\TouristSiteController;
use App\Http\Controllers\VisaController;
use App\Http\Controllers\WhatsAppController;
use Illuminate\Support\Facades\Route;

// Sanctum::routes();
Route::post('login', [AuthController::class, 'login']);
Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');



Route::post('/users', [UserController::class, 'store']);
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

Route::post('/con/{conference_id}/prices', [PricesController::class, 'store'])->middleware(['auth:sanctum', 'checkAdmin']);
Route::delete('/con/{conference_id}/{price_id}/prices', [PricesController::class, 'deletePriceByConferenceId'])->middleware(['auth:sanctum', 'admin']);
Route::get('/con/{conference_id}/prices', [PricesController::class, 'getPricesByConferenceId']);

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
