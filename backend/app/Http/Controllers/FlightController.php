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
    //             'download_url' => 'nullable|url', // تأكد من إضافة التحقق من صحة رابط التحميل
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

    //         // إرسال إشعار إذا تم إدخال قيمة لـ download_url
    //         if (isset($validatedData['download_url'])) {
    //             // الحصول على user_id مباشرة
    //             $userId = $flight->user_id; // استخدام user_id مباشرة

    //             if ($userId) {
    //                 // إرسال الإشعار للمستخدم
    //                 $message = "You can visit your profile; the requested ticket is now available on the website.";

    //                 // إرسال الإشعار إلى المستخدم
    //                 Notification::create([
    //                     'user_id' => $userId, // المستخدم الذي سيتم الإشعار له
    //                     'message' => $message,
    //                     'is_read' => false,
    //                     'register_id' => null, // بقاء register_id فارغة
    //                 ]);
    //             }
    //         }

    //         return response()->json(['message' => 'Flight updated successfully', 'flight' => $flight], 200);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => 'An error occurred while updating the flight.', 'error' => $e->getMessage()], 500);
    //     }
    // }

    public function updateByAdmin(Request $request)
    {
        try {
            $user = Auth::user();
            $flightsData = $request->input('flights'); // مصفوفة تحتوي على بيانات كل رحلة لتحديثها

            if (!$flightsData || !is_array($flightsData)) {
                return response()->json(['message' => 'Invalid flights data provided.'], 400);
            }

            $updatedFlights = [];

            foreach ($flightsData as $flightData) {
                $flight_id = $flightData['flight_id'] ?? null;
                if (!$flight_id) {
                    continue; // تجاوز هذا العنصر إذا لم يحتوي على flight_id
                }

                // العثور على الرحلة بناءً على ID
                $flight = Flight::find($flight_id);

                if (!$flight) {
                    continue; // تجاوز إذا لم يتم العثور على الرحلة
                }

                // التحقق من صحة الحقول المطلوبة فقط
                $validatedData = Validator::make($flightData, [
                    'business_class_upgrade_cost' => 'nullable|numeric|min:0',
                    'reserved_seat_cost' => 'nullable|numeric|min:0',
                    'other_additional_costs' => 'nullable|numeric|min:0',
                    'admin_update_deadline' => 'nullable|date',
                    'is_free' => 'sometimes|boolean',
                    'is_available_for_download' => 'sometimes|boolean',
                    'download_url' => 'nullable|url',
                    'base_ticket_price' => 'nullable|numeric|min:0',
                ]);

                if ($validatedData->fails()) {
                    return response()->json(['message' => 'Validation failed', 'errors' => $validatedData->errors()], 422);
                }

                // تحديث الحقول بناءً على القيم المدخلة فقط
                foreach ($validatedData->validated() as $key => $value) {
                    if (isset($flightData[$key])) {
                        $flight->{$key} = $value;
                    }
                }

                // تحديث توقيت آخر تعديل من قبل المسؤول
                $flight->last_admin_update_at = now()->setTimezone('Asia/Amman');

                // حفظ التغييرات
                $flight->save();

                // إرسال إشعار إذا تم إدخال قيمة لـ download_url
                if (isset($flightData['download_url'])) {
                    $userId = $flight->user_id;

                    if ($userId) {
                        $message = "You can visit your profile; the requested ticket is now available on the website.";
                        Notification::create([
                            'user_id' => $userId,
                            'message' => $message,
                            'is_read' => false,
                            'register_id' => null,
                        ]);
                    }
                }

                $updatedFlights[] = $flight;
            }

            return response()->json(['message' => 'Flights updated successfully', 'flights' => $updatedFlights], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while updating flights.', 'error' => $e->getMessage()], 500);
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

    // public function getFlightByUserIdForCompanion($userId)
    // {
    //     try {
    //         // تحقق من أن user_id موجود
    //         if (!$userId) {
    //             return response()->json(['message' => 'User ID is required.'], 400);
    //         }

    //         // ابحث عن جميع الرحلات حيث يكون main_user_id مساويًا لـ userId
    //         $flights = Flight::where('main_user_id', $userId)->get();

    //         // تحقق إذا كانت هناك رحلات
    //         if ($flights->isEmpty()) {
    //             return response()->json(['message' => 'No flights found with the given main_user_id.'], 404);
    //         }

    //         // إرجاع الرحلات
    //         return response()->json($flights, 200);
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => $e->getMessage()], 500);
    //     }
    // }
    public function getFlightByUserIdForCompanion($userId)
    {
        try {
            // تحقق من أن user_id موجود
            if (!$userId) {
                return response()->json(['message' => 'User ID is required.'], 400);
            }

            // ابحث عن جميع الرحلات حيث يكون main_user_id أو user_id مساويًا لـ userId
            $flights = Flight::where(function ($query) use ($userId) {
                $query->where('main_user_id', $userId)
                    ->orWhere('user_id', $userId); // إضافة شرط user_id
            })->get();

            // تحقق إذا كانت هناك رحلات
            if ($flights->isEmpty()) {
                return response()->json(['message' => 'No flights found with the given user_id or main_user_id.', 'data' => false], 200);
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






    public function updateFlightByUser(Request $request)
    {
        try {
            // الحصول على معلومات المستخدم الحالي
            $user = Auth::user();
            $mainUserId = $user->id; // معرّف المستخدم الأساسي

            // تحديث بيانات المستخدم الأساسي
            $flight = Flight::where('flight_id', $request->input('flight_id'))
                ->where('user_id', $mainUserId)
                ->first();

            if ($flight) {
                // التحقق من شرط المهلة الزمنية للتحديث
                $currentDateTime = \Carbon\Carbon::now();
                if ($flight->admin_update_deadline && $currentDateTime->greaterThan($flight->admin_update_deadline)) {
                    return response()->json(['error' => 'The update deadline has passed. No further updates are allowed.'], 403);
                }

                // إعداد مصفوفة التحديث
                $updateData = [];

                // تحقق من القيم المدخلة وتحديث فقط ما تم تقديمه
                if ($request->has('departure_airport')) {
                    $updateData['departure_airport'] = $request->input('departure_airport');
                }
                if ($request->has('arrival_airport')) {
                    $updateData['arrival_airport'] = $request->input('arrival_airport');
                }
                if ($request->has('departure_date')) {
                    $updateData['departure_date'] = $request->input('departure_date');
                }
                if ($request->has('arrival_date')) {
                    $updateData['arrival_date'] = $request->input('arrival_date');
                }
                if ($request->has('ticket_count')) {
                    $updateData['ticket_count'] = $request->input('ticket_count');
                }
                if ($request->has('flight_number')) {
                    $updateData['flight_number'] = $request->input('flight_number');
                }
                if ($request->has('seat_preference')) {
                    $updateData['seat_preference'] = $request->input('seat_preference');
                }
                if ($request->has('upgrade_class')) {
                    $updateData['upgrade_class'] = $request->input('upgrade_class');
                }
                if ($request->has('additional_requests')) {
                    $updateData['additional_requests'] = $request->input('additional_requests');
                }
                if ($request->has('specific_flight_time')) {
                    $updateData['specific_flight_time'] = $request->input('specific_flight_time');
                }
                if ($request->has('passport_image')) {
                    $updateData['passport_image'] = $request->input('passport_image');
                }

                // تحديث الرحلة إذا كانت هناك أي بيانات للتحديث
                if (!empty($updateData)) {
                    $flight->update($updateData);

                    // تحديث حقل last_speaker_update_at بعد التحديث
                    $flight->last_speaker_update_at = \Carbon\Carbon::now()->setTimezone('Asia/Amman');
                    $flight->save();
                }
            } else {
                return response()->json(['error' => 'الرحلة الأساسية غير موجودة أو غير مرتبطة بالمستخدم'], 404);
            }

            // تحديث معلومات المرافقين
            foreach ($request->input('companions') as $companionData) {
                $companionFlight = Flight::where('flight_id', $companionData['flight_id'])
                    ->whereNull('user_id') // تحقق من أن user_id فارغ
                    ->first();

                if ($companionFlight) {
                    // إعداد مصفوفة التحديث للمرافق
                    $companionUpdateData = [];

                    // تحقق من القيم المدخلة للمرافق
                    if (isset($companionData['departure_airport'])) {
                        $companionUpdateData['departure_airport'] = $companionData['departure_airport'];
                    }
                    if (isset($companionData['arrival_airport'])) {
                        $companionUpdateData['arrival_airport'] = $companionData['arrival_airport'];
                    }
                    if (isset($companionData['departure_date'])) {
                        $companionUpdateData['departure_date'] = $companionData['departure_date'];
                    }
                    if (isset($companionData['arrival_date'])) {
                        $companionUpdateData['arrival_date'] = $companionData['arrival_date'];
                    }
                    if (isset($companionData['ticket_count'])) {
                        $companionUpdateData['ticket_count'] = $companionData['ticket_count'];
                    }
                    if (isset($companionData['flight_number'])) {
                        $companionUpdateData['flight_number'] = $companionData['flight_number'];
                    }
                    if (isset($companionData['seat_preference'])) {
                        $companionUpdateData['seat_preference'] = $companionData['seat_preference'];
                    }
                    if (isset($companionData['upgrade_class'])) {
                        $companionUpdateData['upgrade_class'] = $companionData['upgrade_class'];
                    }
                    if (isset($companionData['additional_requests'])) {
                        $companionUpdateData['additional_requests'] = $companionData['additional_requests'];
                    }
                    if (isset($companionData['specific_flight_time'])) {
                        $companionUpdateData['specific_flight_time'] = $companionData['specific_flight_time'];
                    }
                    if (isset($companionData['passport_image'])) {
                        $companionUpdateData['passport_image'] = $companionData['passport_image'];
                    }

                    // تحديث الرحلة للمرافق إذا كانت هناك أي بيانات للتحديث
                    if (!empty($companionUpdateData)) {
                        $companionUpdateData['main_user_id'] = $mainUserId; // تعيين معرّف المستخدم الأساسي للمرافق
                        $companionFlight->update($companionUpdateData);
                    }
                } else {
                    return response()->json(['error' => 'رحلة المرافق غير موجودة'], 404);
                }
            }

            return response()->json(['message' => 'Update successful']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'ERROR: ' . $e->getMessage()], 500);
        }
    }






    public function getFlightById($flight_id)
    {
        // البحث عن الرحلة باستخدام معرف الرحلة
        $flight = Flight::where('flight_id', $flight_id)->first();
    
        // التحقق مما إذا كانت الرحلة موجودة
        if (!$flight) {
            // في حال عدم وجود الرحلة، إرجاع رسالة خطأ
            return response()->json([
                'message' => 'Flight not found'
            ], 404);
        }
    
        // في حال وجود الرحلة، إرجاع بياناتها
        return response()->json($flight, 200);
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
