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
            $user = Auth::user();

            // Check if the user already has a flight registered
            $existingFlight = Flight::where('user_id', $user->id)->first();
            if ($existingFlight) {
                return response()->json(['error' => 'You already have an existing flight. You cannot create another flight.'], 400);
            }
    
            // Validate input data for each flight entry
            $flights = $request->input('flights');
            foreach ($flights as $flightData) {
                Validator::make($flightData, [
                    'departureAirport' => 'required|string|max:100',
                    'returnAirport' => 'required|string|max:100',
                    'departureDate' => 'required|date',
                    'arrivalDate' => 'required|date',
                    'ticket_count' => 'integer|min:1',
                    'passportImage' => 'nullable|image|mimes:jpeg,png,jpg', // تعديل الاسم
                    'flightNumber' => 'nullable|sometimes|string',
                    'seatNumber' => 'nullable|sometimes|string',
                    'upgradeClass' => 'nullable|sometimes|boolean',
                    'otherRequests' => 'nullable|sometimes|string',
                    'name' => 'nullable|sometimes|string',
                    'specificFlightTime' => 'nullable|sometimes|string',
                ])->validate();
            }

            // Get the current user
            $user = Auth::user();
            $mainFlightId = null; // Will store the flight ID for the main user

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
                if ($index === 0) { // Main user flight entry
                    $flight->user_id = $user->id;
                    $flight->ticket_count = 1;
                    $flight->main_user_id = null;
                    $flight->passenger_name = $user->name;
                    $flight->is_companion = false;
                } else { // Companion entries
                    $flight->user_id = null;
                    $flight->ticket_count = 1;
                    $flight->main_user_id = $mainFlightId; // Set the main user's flight ID
                    $flight->passenger_name = $flightData['name'];
                    $flight->is_companion = true;
                }

                // Set additional fields
                $flight->flight_number = $flightData['flightNumber'];
                $flight->seat_preference = $flightData['seatNumber'];
                $flight->upgrade_class = $flightData['upgradeClass'] || false;
                $flight->additional_requests = $flightData['otherRequests'];

                // Save the passport image if present
                // استبدال 'passportImage' بـ 'passport_image'
                // if (isset($flightData['passportImage']) && $request->hasFile("flights.$index.passportImage")) {
                //     // تخزين الصورة في مجلد passport_images
                //     $passportImagePath = $request->file("flights.$index.passportImage")->store('passport_images', 'public');
                //     $flight->passportImage = $passportImagePath;
                // }
                
                if ($request->hasFile("flights.$index.passportImage") && $request->file("flights.$index.passportImage")->isValid()) {
                    // Store image in 'passport_images' folder within public storage
                    $passportImagePath = $request->file("flights.$index.passportImage")->store('passport_images', 'public');
                    $flight->passportImage = $passportImagePath;
                }

                // Save the flight data in the database
                $flight->created_at = Carbon::now('Asia/Amman');
                $flight->save();

                // Store the generated ID for the main user
                if ($index === 0) {
                    $mainFlightId = $flight->flight_id;
                }

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


    public function updateDeadlineSAdmin(Request $request)
    {
        try {
            // التحقق من صحة المدخلات
            $validator = Validator::make($request->all(), [
                'flight_id' => 'required|exists:flights,flight_id',  // التحقق من وجود الـ flight_id في جدول الرحلات
                'admin_update_deadline' => 'required|date',   // التأكد من أن الـ admin_update_deadline هو تاريخ صحيح
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            // العثور على الرحلة بناءً على الـ flight_id
            $flight = Flight::find($request->input('flight_id'));

            if (!$flight) {
                return response()->json([
                    'message' => 'Flight not found'
                ], 404);
            }

            // تحديث الـ admin_update_deadline للرحلة
            $flight->admin_update_deadline = $request->input('admin_update_deadline');
            $flight->updated_at = now();  // تعيين الوقت الحالي كآخر تعديل من قبل المسؤول

            // حفظ التغييرات
            $flight->save();

            // إرجاع استجابة ناجحة
            return response()->json([
                'message' => 'Flight deadline updated successfully',
                'flight' => $flight
            ], 200);

        } catch (\Exception $e) {
            // إرجاع استجابة في حالة حدوث خطأ غير متوقع
            return response()->json([
                'message' => 'An error occurred while updating the deadline.',
                'error' => $e->getMessage()
            ], 500);
        }
    }    public function deleteFlights(Request $request)
    {
        try {
            // الحصول على المستخدم الحالي
            $user = Auth::user();

            // التحقق من وجود رحلة للمستخدم الأساسي
            $mainFlight = Flight::where('user_id', $user->id)->first();

            if (!$mainFlight) {
                return response()->json(['error' => 'No flights found for this user'], 404);
            }

            // حذف جميع الرحلات التابعة بما في ذلك المستخدم الأساسي والمرافقين
            Flight::where('main_user_id', $mainFlight->flight_id)
                ->orWhere('flight_id', $mainFlight->flight_id)
                ->delete();

            // حذف الإشعارات المرتبطة بالمستخدم

            //         // Send notification to all admins
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification = new Notification();
                $notification->user_id = $admin->id; // Save the admin user_id
                $notification->message = "Flight has been marked as deleted by user {$user->email}.";
                $notification->save();
                broadcast(new NotificationSent($notification))->toOthers();
            }
            return response()->json(['message' => 'All flights and associated companions deleted successfully'], 200);
        } catch (\Exception $e) {
            // معالجة الأخطاء العامة
            return response()->json(['error' => 'An error occurred while deleting flights: ' . $e->getMessage()], 500);
        }
    }




    public function editNewFlight(Request $request)
    {
        try {
            // Validate input data for each flight entry
            $flights = $request->input('flights');
            foreach ($flights as $flightData) {
                Validator::make($flightData, [
                    'flight_id' => 'nullable|exists:flights,flight_id', // Ensure the flight_id exists if provided
                    'departureAirport' => 'required|string|max:100',
                    'returnAirport' => 'required|string|max:100',
                    'departureDate' => 'required|date',
                    'arrivalDate' => 'required|date',
                    'ticket_count' => 'integer|min:1',
                    'passportImage' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                    'flightNumber' => 'nullable|sometimes|string',
                    'seatNumber' => 'nullable|sometimes|string',
                    'upgradeClass' => 'nullable|sometimes|boolean',
                    'otherRequests' => 'nullable|sometimes|string',
                    'name' => 'nullable|sometimes|string',
                    'specificFlightTime' => 'nullable|sometimes|string',
                    'main_user_id' => 'nullable|sometimes|string|integer',
                ])->validate();
            }

            $user = Auth::user();
            $mainFlightId = null; // Will store the flight ID for the main user

            foreach ($flights as $index => $flightData) {
                $flight = null;

                // Check if this is an update or a new flight
                if (isset($flightData['flight_id'])) {
                    // Update existing flight
                    $flight = Flight::where('flight_id', $flightData['flight_id'])->firstOrFail();
                    if ($flight->admin_update_deadline && Carbon::parse($flight->admin_update_deadline)->isPast()) {
                        return response()->json([
                            'message' => 'You cannot modify the flight as the admin update deadline has passed.'
                        ], 200);
                    }

                    
                } else {
                    // Create a new flight instance
                    $flight = new Flight();
                }
                

                // Set mandatory fields
                $flight->departure_airport = $flightData['departureAirport'];
                $flight->arrival_airport = $flightData['returnAirport'];
                $flight->departure_date = $flightData['departureDate'];
                $flight->arrival_date = $flightData['arrivalDate'];
                $flight->specific_flight_time = $flightData['specificFlightTime'];

                if ($index === 0) { // Main user flight entry
                    $flight->user_id = $user->id;
                    $flight->ticket_count = 1;
                    $flight->main_user_id = null;
                    $flight->passenger_name = $user->name;
                    $flight->is_companion = false;
                } else { // Companion entries
                    $flight->user_id = null;
                    $flight->ticket_count = 1;
                    $flight->main_user_id = $flightData['main_user_id'];
                    $flight->passenger_name = $flightData['name'];
                    $flight->is_companion = true;
                }

                // Set additional fields
                $flight->flight_number = $flightData['flightNumber'];
                $flight->seat_preference = $flightData['seatNumber'];
                $flight->upgrade_class = $flightData['upgradeClass'] ?? false;
                $flight->additional_requests = $flightData['otherRequests'];

                // Handle passport image upload
                if ($request->hasFile('passportImage')) {
                    $imagePath = $request->file('passportImage')->store('images', 'public');
                    $flight->passport_image = $imagePath;
                }

                // Save or update the flight data in the database
                $flight->updated_at = Carbon::now('Asia/Amman');
                $flight->save();

                if ($index === 0 && !isset($flightData['flight_id'])) {
                    $mainFlightId = $flight->flight_id; // Store flight_id for new main user flights
                }
            }

            return response()->json(['message' => 'Flights updated successfully'], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred while updating the flights: ' . $e->getMessage()], 500);
        }
    }



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

            // إرجاع الرحلات مع رفقاء الرحلة
            $flightsWithCompanions = $flights->map(function ($flight) use ($user) {
                $companions = Flight::where('main_user_id', $flight->flight_id)->get();
                return [
                    'flight' => $flight,
                    'companions' => $companions,
                ];
            });

            return response()->json($flightsWithCompanions, 200);
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

            // ابحث عن جميع الرحلات حيث يكون main_user_id أو user_id مساويًا لـ userId
            $flights = Flight::where(function ($query) use ($userId) {
                $query->where('main_user_id', $userId)
                    ->orWhere('flight_id', $userId); // إضافة شرط user_id
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
            $query->orderBy('flights.created_at', 'desc'); // ترتيب حسب تاريخ الإنشاء بشكل تنازلي

            // تنفيذ الاستعلام مع pagination
            $flights = $query->paginate($perPage);

            // إعداد البيانات لتضمين معلومات التصفح
            $pagination = [
                'total' => $flights->total(),
                'per_page' => $flights->perPage(),
                'current_page' => $flights->currentPage(),
                'total_pages' => $flights->lastPage(),
            ];

            // إرجاع النتائج مع معلومات التصفح
            return response()->json([
                'data' => $flights->items(),
                'pagination' => $pagination
            ], 200);
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

    public function getFlightsWithInvoicesByUserId($userId)
    {
        try {
            // Retrieve the first matching flight for the given user ID
            $firstFlight = Flight::where('user_id', $userId)->first();
    
            if (!$firstFlight) {
                return response()->json(['message' => 'No flights found for the specified user.'], 200);
            }
    
            // Retrieve flights matching user_id
            $userFlights = Flight::with('invoice')
                ->where('user_id', $userId)
                ->get();
    
            // Retrieve flights matching main_user_id with the first flight's ID
            $companionFlights = Flight::with('invoice')
                ->where('main_user_id', $firstFlight->flight_id)
                ->get();
    
            return response()->json([
                'user_flights' => $userFlights,
                'companions' => $companionFlights,
            ], 200);
        } catch (\Exception $e) {
            // Handle exceptions
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    
    


}
