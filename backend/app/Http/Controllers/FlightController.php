<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Flight;
use App\Models\Notification;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator; // تأكد من إضافة هذا السطر

class FlightController extends Controller
{
    // public function createFlight(Request $request)
    // {
    //     try {
    //         // Validate input data
    //         $this->validateFlightData($request);

    //         // Get the current user
    //         $user = Auth::user();

    //         // Check for an existing flight
    //         $existingFlightId = Flight::where('user_id', $user->id)->value('flight_id');

    //         // Create a new Flight instance
    //         $flight = new Flight();

    //         // Set user_id and ticket_count based on is_companion
    //         $this->setFlightDetails($flight, $request, $user, $existingFlightId);

    //         // Save the passport image if present
    //         $this->handlePassportImage($request, $flight);

    //         // Set additional fields
    //         $this->setAdditionalFields($request, $flight);

    //         // Save the flight data in the database
    //         $flight->created_at = Carbon::now('Asia/Amman'); // Specify the timezone
    //         $flight->save();
    //         $message = 'The ticket will be available shortly, and you will be notified on the website once it becomes available.';
    //         Notification::create([
    //             'user_id' => $user->id, // المتحدث نفسه
    //             'message' => $message,
    //             'is_read' => false,
    //             'register_id' => null, // بقاء register_id فارغة
    //         ]);
    //         $admins = User::where('isAdmin', true)->get();
    //         foreach ($admins as $admin) {
    //             $notification =    Notification::create([
    //                 'user_id' => $admin->id,
    //                 'message' => 'New flight registered by ' . $user->name . '. Log in to adjust the price.',
    //                 'is_read' => false,
    //                 'register_id' => $user->id, // استخدام user_id كمفتاح تسجيل
    //             ]);
    //             broadcast(new NotificationSent($notification))->toOthers();

    //         }

    //         return response()->json(['message' => 'Flight created successfully'], 201);
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'An error occurred while creating the flight. Please try again later.'], 500);
    //     }
    // }

    // private function validateFlightData(Request $request)
    // {
    //     $request->validate([
    //         'departure_airport' => 'required|string|max:100',
    //         'arrival_airport' => 'required|string|max:100',
    //         'departure_date' => 'required|date',
    //         'arrival_date' => 'required|date',
    //         'ticket_count' => 'integer|min:1',
    //         'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
    //         'is_companion' => 'required|boolean',
    //         'flight_number' => 'sometimes|string',
    //         'seat_preference' => 'sometimes|string',
    //         'upgrade_class' => 'sometimes|boolean',
    //         'additional_requests' => 'sometimes|string',
    //         'passenger_name' => 'sometimes|string',
    //         'specific_flight_time' => 'sometimes',
    //     ]);
    // }

    // private function setFlightDetails(Flight $flight, Request $request, $user, $existingFlightId)
    // {
    //     if ($request->is_companion) {
    //         $flight->user_id = null;
    //         $flight->ticket_count = 1;

    //         if ($existingFlightId) {
    //             $flight->main_user_id = $existingFlightId;
    //         }
    //     } else {
    //         $flight->user_id = $user->id;
    //         $flight->ticket_count = $request->ticket_count;
    //         $flight->main_user_id = null;

    //         // Set passenger name
    //         $userDetails = User::find($flight->user_id);
    //         if ($userDetails) {
    //             $flight->passenger_name = $userDetails->name;
    //         }
    //     }

    //     // Set mandatory fields
    //     $flight->departure_airport = $request->departure_airport;
    //     $flight->arrival_airport = $request->arrival_airport;
    //     $flight->departure_date = $request->departure_date;
    //     $flight->arrival_date = $request->arrival_date;
    //     $flight->is_companion = $request->is_companion;
    // }

    // private function handlePassportImage(Request $request, Flight $flight)
    // {
    //     if ($request->hasFile('passport_image')) {
    //         $image = $request->file('passport_image');
    //         $imagePath = $image->store('public/passport_images');
    //         $flight->passport_image = basename($imagePath);
    //     }
    // }

    // private function setAdditionalFields(Request $request, Flight $flight)
    // {
    //     $flight->flight_number = $request->flight_number;
    //     $flight->seat_preference = $request->seat_preference;
    //     $flight->upgrade_class = $request->upgrade_class;
    //     $flight->additional_requests = $request->additional_requests;
    //     $flight->passenger_name = $request->passenger_name;
    //     $flight->specific_flight_time = $request->specific_flight_time;
    // }


    // public function createFlight(Request $request)
    // {
    //     try {
    //         // Validate input data
    //         $this->validateFlightData($request);

    //         // Get the current user
    //         $user = Auth::user();

    //         // Iterate through the provided flight data
    //         foreach ($request->all() as $flightData) {
    //             // Create a new Flight instance
    //             $flight = new Flight();

    //             // Set mandatory fields from the flight data
    //             $flight->departure_airport = $flightData['departureAirport'];
    //             $flight->arrival_airport = $flightData['returnAirport'];
    //             $flight->departure_date = $flightData['departureDate'];
    //             $flight->arrival_date = $flightData['arrivalDate'];
    //             $flight->specific_flight_time = $flightData['specificFlightTime'];

    //             // Handle passenger information
    //             if ($flightData['name'] === $user->name) {
    //                 // This is the main user
    //                 $flight->user_id = $user->id; // Set the user ID
    //                 $flight->ticket_count = 1; // Assuming one ticket for the main user
    //                 $flight->main_user_id = null; // No main user ID for the main user
    //                 $flight->passenger_name = $user->name; // Set the passenger name
    //             } else {
    //                 // This is a companion
    //                 $flight->user_id = null; // Companions don't have a user ID
    //                 $flight->ticket_count = 1; // Assuming one ticket for the companion
    //                 $flight->main_user_id = $user->id; // Set the main user ID
    //                 $flight->passenger_name = $flightData['name']; // Set the companion's name
    //             }

    //             // Set additional fields
    //             $flight->flight_number = $flightData['flightNumber'];
    //             $flight->seat_preference = $flightData['seatNumber'];
    //             $flight->upgrade_class = $flightData['upgradeClass'];
    //             $flight->additional_requests = $flightData['otherRequests'];

    //             // Save the passport image if present
    //             if (isset($flightData['passportImage']) && $flightData['passportImage']) {
    //                 // Handle the passport image as necessary
    //                 $flight->passport_image = $flightData['passportImage']; // Modify as needed
    //             }

    //             // Save the flight data in the database
    //             $flight->created_at = Carbon::now('Asia/Amman'); // Specify the timezone
    //             $flight->save();

    //             // Notify the user about the created flight
    //             $message = 'The ticket will be available shortly, and you will be notified on the website once it becomes available.';
    //             Notification::create([
    //                 'user_id' => $user->id,
    //                 'message' => $message,
    //                 'is_read' => false,
    //                 'register_id' => null,
    //             ]);

    //             // Notify the admins about the new flight registration
    //             $admins = User::where('isAdmin', true)->get();
    //             foreach ($admins as $admin) {
    //                 $notification = Notification::create([
    //                     'user_id' => $admin->id,
    //                     'message' => 'New flight registered by ' . $user->name . '. Log in to adjust the price.',
    //                     'is_read' => false,
    //                     'register_id' => $user->id,
    //                 ]);
    //                 broadcast(new NotificationSent($notification))->toOthers();
    //             }
    //         }

    //         return response()->json(['message' => 'Flights created successfully'], 201);
    //     } catch (\Illuminate\Validation\ValidationException $e) {
    //         // Return the validation errors
    //         return response()->json(['errors' => $e->validator->errors()], 422);
    //     } catch (\Exception $e) {
    //         // Return the error message from the exception
    //         return response()->json(['error' => 'An error occurred while creating the flights: ' . $e->getMessage()], 500);
    //     }
    // }
    public function createFlight(Request $request)
    {
        try {
            // Validate input data
            $flights = $request->input('flights'); // تأكد من استدعاء 'flights' هنا
            foreach ($flights as $flightData) {
                Validator::make($flightData, [
                    'departureAirport' => 'required|string|max:100',
                    'returnAirport' => 'required|string|max:100',
                    'departureDate' => 'required|date',
                    'arrivalDate' => 'required|date',
                    'ticket_count' => 'integer|min:1',
                    'passportImage' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                    'flightNumber' => 'sometimes|string',
                    'seatNumber' => 'sometimes|string',
                    'upgradeClass' => 'sometimes|boolean',
                    'otherRequests' => 'sometimes|string',
                    'name' => 'sometimes|string',
                    'specificFlightTime' => 'sometimes|string',
                ])->validate();
            }
    
            // Get the current user
            $user = Auth::user();
    
            // Iterate through the provided flight data
            foreach ($flights as $index => $flightData) {
                // Create a new Flight instance
                $flight = new Flight();
    
                // Set mandatory fields from the flight data
                $flight->departure_airport = $flightData['departureAirport'];
                $flight->arrival_airport = $flightData['returnAirport'];
                $flight->departure_date = $flightData['departureDate'];
                $flight->arrival_date = $flightData['arrivalDate'];
                $flight->specific_flight_time = $flightData['specificFlightTime'];
    
                // Handle passenger information
                if ($index === 0) { // Assuming the first entry is the main user
                    $flight->user_id = $user->id; // Set the user ID
                    $flight->ticket_count = 1; // Assuming one ticket for the main user
                    $flight->main_user_id = null; // No main user ID for the main user
                    $flight->passenger_name = $user->name; // Set the passenger name
                    $flight->is_companion = false; // Main user is not a companion
                } else { // For companions
                    $flight->user_id = null; // Companions don't have a user ID
                    $flight->ticket_count = 1; // Assuming one ticket for the companion
                    $flight->main_user_id = $user->id; // Set the main user ID
                    $flight->passenger_name = $flightData['name']; // Set the companion's name
                    $flight->is_companion = true; // Companion flag
                }
    
                // Set additional fields
                $flight->flight_number = $flightData['flightNumber'];
                $flight->seat_preference = $flightData['seatNumber'];
                $flight->upgrade_class = $flightData['upgradeClass'];
                $flight->additional_requests = $flightData['otherRequests'];
    
                // Save the passport image if present
                if ($request->hasFile('passportImage')) {
                    $imagePath = $request->file('passportImage')->store('images', 'public');
                    $flight->passport_image = $imagePath; // قم بتحديث مسار الصورة
                }
    
                // Save the flight data in the database
                $flight->created_at = Carbon::now('Asia/Amman'); // Specify the timezone
                $flight->save();
    
                // Notify the user about the created flight
                $message = 'The ticket will be available shortly, and you will be notified on the website once it becomes available.';
                Notification::create([
                    'user_id' => $user->id,
                    'message' => $message,
                    'is_read' => false,
                    'register_id' => null,
                ]);
    
                // Notify the admins about the new flight registration
                $admins = User::where('isAdmin', true)->get();
                foreach ($admins as $admin) {
                    $notification = Notification::create([
                        'user_id' => $admin->id,
                        'message' => 'New flight registered by ' . $user->name . '. Log in to adjust the price.',
                        'is_read' => false,
                        'register_id' => $user->id,
                    ]);
                    broadcast(new NotificationSent($notification))->toOthers();
                }
            }
    
            return response()->json(['message' => 'Flights created successfully'], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            // Return the validation errors
            return response()->json(['errors' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            // Return the error message from the exception
            return response()->json(['error' => 'An error occurred while creating the flights: ' . $e->getMessage()], 500);
        }
    }
    






    // public function updateByAdmin(Request $request, $flight_id)
    // {
    //     try {
    //         $user = Auth::user();

    //         // العثور على الرحلة بناءً على ID
    //         $flight = Flight::find($flight_id);

    //         if (!$flight) {
    //             return response()->json(['message' => 'Flight not found'], 404);
    //         }

    //         // التحقق من صحة الحقول المطلوبة فقط
    //         $validatedData = $request->validate([
    //             'business_class_upgrade_cost' => 'nullable|numeric|min:0',
    //             'reserved_seat_cost' => 'nullable|numeric|min:0',
    //             'additional_baggage_cost' => 'nullable|numeric|min:0',
    //             'other_additional_costs' => 'nullable|numeric|min:0',
    //             'admin_update_deadline' => 'nullable|date',
    //             'is_free' => 'sometimes|boolean',
    //             'is_available_for_download' => 'sometimes|boolean',
    //             'download_url',
    //             'base_ticket_price' => 'nullable|numeric|min:0', // تم إضافة هذا الحقل
    //         ]);

    //         // تحديث الحقول بناءً على القيم المدخلة فقط
    //         foreach ($validatedData as $key => $value) {
    //             if ($request->has($key)) {
    //                 $flight->{$key} = $value;
    //             }
    //         }

    //         // تحديث توقيت آخر تعديل من قبل المسؤول
    //         $flight->last_admin_update_at = now()->setTimezone('Asia/Amman');

    //         // حفظ التغييرات
    //         $flight->save();

    //         return response()->json(['message' => 'Flight updated successfully', 'flight' => $flight], 200);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => 'An error occurred while updating the flight.', 'error' => $e->getMessage()], 500);
    //     }
    // }


    public function updateByAdmin(Request $request, $flight_id)
    {
        try {
            $user = Auth::user();

            // العثور على الرحلة بناءً على ID
            $flight = Flight::find($flight_id);

            if (!$flight) {
                return response()->json(['message' => 'Flight not found'], 404);
            }

            // التحقق من صحة الحقول المطلوبة فقط
            $validatedData = $request->validate([
                'business_class_upgrade_cost' => 'nullable|numeric|min:0',
                'reserved_seat_cost' => 'nullable|numeric|min:0',
                'additional_baggage_cost' => 'nullable|numeric|min:0',
                'other_additional_costs' => 'nullable|numeric|min:0',
                'admin_update_deadline' => 'nullable|date',
                'is_free' => 'sometimes|boolean',
                'is_available_for_download' => 'sometimes|boolean',
                'download_url' => 'nullable|url', // تأكد من إضافة التحقق من صحة رابط التحميل
                'base_ticket_price' => 'nullable|numeric|min:0', // تم إضافة هذا الحقل
            ]);

            // تحديث الحقول بناءً على القيم المدخلة فقط
            foreach ($validatedData as $key => $value) {
                if ($request->has($key)) {
                    $flight->{$key} = $value;
                }
            }

            // تحديث توقيت آخر تعديل من قبل المسؤول
            $flight->last_admin_update_at = now()->setTimezone('Asia/Amman');

            // حفظ التغييرات
            $flight->save();

            // إرسال إشعار إذا تم إدخال قيمة لـ download_url
            if (isset($validatedData['download_url'])) {
                // الحصول على user_id مباشرة
                $userId = $flight->user_id; // استخدام user_id مباشرة

                if ($userId) {
                    // إرسال الإشعار للمستخدم
                    $message = "You can visit your profile; the requested ticket is now available on the website.";

                    // إرسال الإشعار إلى المستخدم
                    Notification::create([
                        'user_id' => $userId, // المستخدم الذي سيتم الإشعار له
                        'message' => $message,
                        'is_read' => false,
                        'register_id' => null, // بقاء register_id فارغة
                    ]);
                }
            }

            return response()->json(['message' => 'Flight updated successfully', 'flight' => $flight], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while updating the flight.', 'error' => $e->getMessage()], 500);
        }
    }




    public function getFlightByUserId(Request $request)
    {
        try {
            // احصل على المستخدم الحالي
            $user = Auth::user();

            // ابحث عن الرحلات المرتبطة بالمستخدم
            $flights = Flight::where('user_id', $user->id)->get();

            // تحقق إذا كانت هناك رحلات
            if ($flights->isEmpty()) {
                return response()->json(['message' => 'No flights found for this user.'], 404);
            }

            // إرجاع الرحلات
            return response()->json($flights, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function getFlightByUserIdForCompanion($userId)
    {
        try {
            // تحقق من أن user_id موجود
            if (!$userId) {
                return response()->json(['message' => 'User ID is required.'], 400);
            }
    
            // ابحث عن جميع الرحلات حيث يكون main_user_id مساويًا لـ userId
            $flights = Flight::where('main_user_id', $userId)->get();
    
            // تحقق إذا كانت هناك رحلات
            if ($flights->isEmpty()) {
                return response()->json(['message' => 'No flights found with the given main_user_id.'], 404);
            }
    
            // إرجاع الرحلات
            return response()->json($flights, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    



    public function getAllFlightsPaginationAndFilter(Request $request)
    {

        try {
            // إعدادات الفلترة والصفحات
            $perPage = $request->get('per_page', 10); // عدد العناصر في الصفحة (افتراضي 10)
            $nameFilter = $request->get('name'); // فلترة بالاسم إذا تم توفيره

            // بناء الاستعلام
            $query = Flight::join('users', 'flights.user_id', '=', 'users.id')
                ->select('flights.*', 'users.name as user_name'); // تحديد الحقول المراد إرجاعها

            // إضافة فلتر للاسم إذا تم توفيره
            if ($nameFilter) {
                $query->where('users.name', 'LIKE', '%' . $nameFilter . '%');
            }

            // تنفيذ الاستعلام مع pagination
            $flights = $query->paginate($perPage);

            // إرجاع النتائج
            return response()->json($flights, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }





    public function updateFlightByUser(Request $request, $flight_id)
    {
        try {
            $request->validate([
                'departure_airport' => 'sometimes|required|string|max:100',
                'arrival_airport' => 'sometimes|required|string|max:100',
                'departure_date' => 'sometimes|required|date',
                'arrival_date' => 'sometimes|required|date',
                'ticket_count' => 'sometimes|required|integer|min:1',
                'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'is_companion' => 'sometimes|required|boolean',
                'flight_number' => 'sometimes|string',
                'seat_preference' => 'sometimes|string',
                'upgrade_class' => 'sometimes|boolean',
                'additional_requests' => 'sometimes|string',
                'passenger_name' => 'sometimes|string',
                'specific_flight_time' => 'sometimes|date_format:H:i', // Add validation for specific_flight_time
            ]);

            // Get the authenticated user
            $user = Auth::user();

            // Find the flight by flight_id and user_id
            $flight = Flight::where('flight_id', $flight_id)->where('user_id', $user->id)->firstOrFail();

            // Check if the current date is before the admin's update deadline
            $currentDateTime = \Carbon\Carbon::now()->setTimezone('Asia/Amman');

            if ($flight->admin_update_deadline && $currentDateTime->greaterThan($flight->admin_update_deadline)) {
                return response()->json(['error' => 'The update deadline has passed. No further updates are allowed.'], 403);
            }

            // Update only the fields present in the request
            if ($request->has('departure_airport')) {
                $flight->departure_airport = $request->input('departure_airport');
            }
            if ($request->has('arrival_airport')) {
                $flight->arrival_airport = $request->input('arrival_airport');
            }
            if ($request->has('departure_date')) {
                $flight->departure_date = $request->input('departure_date');
            }
            if ($request->has('arrival_date')) {
                $flight->arrival_date = $request->input('arrival_date');
            }
            if ($request->has('ticket_count')) {
                $flight->ticket_count = $request->input('ticket_count');
            }
            if ($request->has('is_companion')) {
                $flight->is_companion = $request->input('is_companion');
            }
            if ($request->has('flight_number')) {
                $flight->flight_number = $request->input('flight_number');
            }
            if ($request->has('seat_preference')) {
                $flight->seat_preference = $request->input('seat_preference');
            }
            if ($request->has('upgrade_class')) {
                $flight->upgrade_class = $request->input('upgrade_class');
            }
            if ($request->has('additional_requests')) {
                $flight->additional_requests = $request->input('additional_requests');
            }
            if ($request->has('passenger_name')) {
                $flight->passenger_name = $request->input('passenger_name');
            }

            // Handle the passport image if present
            if ($request->hasFile('passport_image')) {
                $image = $request->file('passport_image');
                $imagePath = $image->store('public/passport_images');
                $flight->passport_image = basename($imagePath);
            }

            // Update the specific_flight_time if present
            if ($request->has('specific_flight_time')) {
                $flight->specific_flight_time = $request->input('specific_flight_time');
            }

            // Update the last speaker update timestamp with local timezone
            $flight->last_speaker_update_at = \Carbon\Carbon::now()->setTimezone('Asia/Amman');

            // Save changes to the flight
            $flight->save();

            // Send notification to all admins
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                Notification::create([
                    'user_id' => $admin->id,
                    'message' => 'Flight number ' . $flight->flight_id . ' has been modified by user ' . $user->name,
                ]);
            }

            return response()->json(['message' => 'Flight updated successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }








    public function deleteFlightByUser($flight_id)
    {
        try {
            // Get the authenticated user
            $user = Auth::user();

            // Find the flight by flight_id and user_id
            $flight = Flight::where('flight_id', $flight_id)
                ->where('user_id', $user->id)
                ->where('is_deleted', false) // تأكد من أن الرحلة لم تُحذف سابقًا
                ->firstOrFail();

            // Mark companions as deleted where main_user_id is equal to the flight_id
            Flight::where('main_user_id', $flight->flight_id)->update(['is_deleted' => true]);

            // Mark the flight as deleted
            $flight->is_deleted = true;
            $flight->save();

            // Send notification to all admins
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification = new Notification();
                $notification->user_id = $admin->id; // Save the admin user_id
                $notification->message = "Flight {$flight->flight_id} has been marked as deleted by user {$user->id}.";
                $notification->save();
                broadcast(new NotificationSent($notification))->toOthers();
            }

            return response()->json(['message' => 'Flight and companions marked as deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
