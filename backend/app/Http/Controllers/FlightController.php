<?php

namespace App\Http\Controllers;

use App\Models\Flight;
use App\Models\Notification;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FlightController extends Controller
{
    public function createFlight(Request $request)
    {
        try {
            // التحقق من البيانات المدخلة
            $request->validate([
                'departure_airport' => 'required|string|max:100',
                'arrival_airport' => 'required|string|max:100',
                'departure_date' => 'required|date',
                'arrival_date' => 'required|date',
                'ticket_count' => 'integer|min:1',
                'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'is_companion' => 'required|boolean',
                // إضافة الحقول الجديدة هنا
                'flight_number' => 'sometimes|string',
                'seat_preference' => 'sometimes|string',
                'upgrade_class' => 'sometimes|boolean',
                'additional_requests' => 'sometimes|string',
                'passenger_name' => 'sometimes|string',
'specific_flight_time' => 'sometimes',
            ]);
    
            // احصل على المستخدم الحالي
            $user = Auth::user();
    
            $existingFlight = Flight::where('user_id', $user->id)->first();
            $existingFlightId = $existingFlight ? $existingFlight->flight_id : null;
    
            $flight = new Flight();
    
            // تحقق من حالة is_companion
            if ($request->is_companion) {
                $flight->user_id = null; // ضع user_id كـ null إذا كان is_companion true
                $flight->ticket_count = 1; // ضع عدد التذاكر 1 إذا كان is_companion true
    
                // تعيين main_user_id إلى flight_id من الرحلة السابقة إذا وجدت
                if ($existingFlightId) {
                    $flight->main_user_id = $existingFlightId; // تعيين main_user_id إلى flight_id من الرحلة السابقة
                }
            } else {
                $flight->user_id = $user->id; // استخدم user_id من التوكن
                $flight->ticket_count = $request->ticket_count; // استخدم عدد التذاكر من الطلب
                $flight->main_user_id = null; // ضع main_user_id كـ null إذا كان is_companion false
            }
    
            // باقي الحقول
            $flight->departure_airport = $request->departure_airport;
            $flight->arrival_airport = $request->arrival_airport;
            $flight->departure_date = $request->departure_date;
            $flight->arrival_date = $request->arrival_date;
            $flight->is_companion = $request->is_companion;
    
            // إذا كانت هناك صورة لجواز السفر
            if ($request->hasFile('passport_image')) {
                $image = $request->file('passport_image');
                $imagePath = $image->store('public/passport_images');
                $flight->passport_image = basename($imagePath);
            }
    
            // تعيين الحقول الإضافية
            $flight->flight_number = $request->flight_number;
            $flight->seat_preference = $request->seat_preference;
            $flight->upgrade_class = $request->upgrade_class;
            $flight->additional_requests = $request->additional_requests;
            $flight->passenger_name = $request->passenger_name;
    
            // تعيين specific_flight_time
            $flight->specific_flight_time = $request->specific_flight_time;
    
            // حفظ بيانات الطيران في قاعدة البيانات
            $flight->created_at = Carbon::now('Asia/Baghdad'); // أو أي منطقة زمنية تريدها

            $flight->save();
    
            return response()->json(['message' => 'Flight created successfully'], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    




    public function updateByAdmin(Request $request, $flight_id)
    {
        try {
            $user = Auth::user();

            // العثور على الرحلة بناءً على ID
            $flight = Flight::find($flight_id);

            if (!$flight) {
                return response()->json(['message' => 'Flight not found'], 404);
            }

            // التحقق من صحة البيانات المدخلة فقط إذا كانت موجودة في الطلب
            $validatedData = $request->validate([
                'user_id' => 'sometimes|exists:users,id',
                'departure_airport' => 'sometimes|string|max:100',
                'arrival_airport' => 'sometimes|string|max:100',
                'departure_date' => 'sometimes|date',
                'arrival_date' => 'sometimes|date',
                'ticket_count' => 'sometimes|integer',

                'business_class_upgrade_cost' => 'nullable|numeric|min:0',
                'reserved_seat_cost' => 'nullable|numeric|min:0',
                'additional_baggage_cost' => 'nullable|numeric|min:0',
                'other_additional_costs' => 'nullable|numeric|min:0',
                'admin_update_deadline' => 'nullable|date_format:Y-m-d H:i:s',
                'is_free' => 'sometimes|boolean',



                'ticket_number' => 'nullable|string',


                'is_available_for_download' => 'sometimes|boolean',

                'valid_from' => 'nullable|date',
                'valid_until' => 'nullable|date',
                'download_url' => 'nullable|string',


                'is_deleted' => 'sometimes|boolean',

            ]);

            // تحديث الخصائص بناءً على القيم المدخلة
            $flight->fill(array_filter($validatedData));

            // تحديث توقيت آخر تعديل من قبل المسؤول
            $flight->last_admin_update_at = now()->setTimezone('Asia/Amman');

            // حفظ التغييرات
            $flight->save();
            return response()->json(['message' => 'Flight updated successfully', 'flight' => $flight], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'An error occurred while updating the flight.'], 500);
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
    public function getFlightByUserIdForCompanion(Request $request)
    {
        try {
            // احصل على المستخدم الحالي
            $user = Auth::user();

            // ابحث عن الرحلة الأولى التي تخص المستخدم
            $existingFlight = Flight::where('user_id', $user->id)->first();

            // تحقق من وجود الرحلة
            if (!$existingFlight) {
                return response()->json(['message' => 'No flights found for this user.'], 404);
            }

            // الحصول على flight_id
            $flightId = $existingFlight->flight_id; // استخدم id للرحلة الأولى

            // ابحث عن جميع الرحلات حيث يكون main_user_id مساويًا لـ flight_id
            $flights = Flight::where('main_user_id', $flightId)->get();

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
                    'message' => 'تم تعديل الرحلة رقم ' . $flight->flight_id . ' من قبل المستخدم ' . $user->name,
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
            }

            return response()->json(['message' => 'Flight and companions marked as deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
