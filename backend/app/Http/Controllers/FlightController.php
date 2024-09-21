<?php

namespace App\Http\Controllers;

use App\Models\Flight;
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
                'ticket_count' => 'required|integer|min:1',
                'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'is_companion' => 'required|boolean',
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
    
            // الحقول الإضافية
            $flight->flight_number = $request->flight_number;
            $flight->seat_preference = $request->seat_preference;
            $flight->upgrade_class = $request->upgrade_class;
            $flight->additional_requests = $request->additional_requests;
            $flight->passenger_name = $request->passenger_name;
    
            // حفظ بيانات الطيران في قاعدة البيانات
            $flight->save();
    
            return response()->json(['message' => 'Flight created successfully'], 201);
    
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    
    
    
    




public function postByAdmin(Request $request)
{
    try {
        $user = Auth::user();
        
       

        $validatedData = $request->validate([
            'user_id' => 'required|exists:users,id',
            'departure_airport' => 'required|string|max:100',
            'arrival_airport' => 'required|string|max:100',
            'departure_date' => 'required|date',
            'arrival_date' => 'required|date',
            'ticket_count' => 'required|integer',
            'business_class_upgrade_cost' => 'nullable|numeric|min:0',
            'reserved_seat_cost' => 'nullable|numeric|min:0',
            'additional_baggage_cost' => 'nullable|numeric|min:0',
            'other_additional_costs' => 'nullable|numeric|min:0',
            'admin_update_deadline' => 'nullable|date',
            'is_deleted' => 'boolean',
            'is_free' => 'boolean',
            'ticket_number' => 'nullable|string',
            'is_available_for_download' => 'boolean',
            'valid_from' => 'nullable|date',
            'valid_until' => 'nullable|date',
            'download_url' => 'nullable|string',
        ]);

        $flight = new Flight();
        $flight->user_id = $validatedData['user_id'];
        $flight->departure_airport = $validatedData['departure_airport'];
        $flight->arrival_airport = $validatedData['arrival_airport'];
        $flight->departure_date = $validatedData['departure_date'];
        $flight->arrival_date = $validatedData['arrival_date'];
        $flight->ticket_count = $validatedData['ticket_count'];
        $flight->business_class_upgrade_cost = $validatedData['business_class_upgrade_cost'] ?? 0.00;
        $flight->reserved_seat_cost = $validatedData['reserved_seat_cost'] ?? 0.00;
        $flight->additional_baggage_cost = $validatedData['additional_baggage_cost'] ?? 0.00;
        $flight->other_additional_costs = $validatedData['other_additional_costs'] ?? 0.00;
        $flight->admin_update_deadline = $validatedData['admin_update_deadline'] ?? null;
        $flight->is_deleted = $validatedData['is_deleted'] ?? false;
        $flight->is_free = $validatedData['is_free'] ?? false;
        $flight->ticket_number = $validatedData['ticket_number'] ?? null;
        $flight->is_available_for_download = $validatedData['is_available_for_download'] ?? false;
        $flight->valid_from = $validatedData['valid_from'] ?? null;
        $flight->valid_until = $validatedData['valid_until'] ?? null;
        $flight->download_url = $validatedData['download_url'] ?? null;

        // حفظ الرحلة
        $flight->save();

        return response()->json(['message' => 'Flight created successfully', 'flight' => $flight], 201);

    } catch (\Exception $e) {
        return response()->json(['message' => $e->getMessage()], 500);
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
        // Validate the incoming request data
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
            'upgrade_class' => 'sometimes|string',
            'additional_requests' => 'sometimes|string',
            'passenger_name' => 'sometimes|string',
        ]);

        // Get the authenticated user
        $user = Auth::user();

        // Find the flight by flight_id
        $flight = Flight::where('flight_id', $flight_id)->firstOrFail();

        // Check if the user is the owner of the flight or an admin
        if ($user->id !== $flight->user_id && !$user->is_admin) {
            return response()->json(['error' => 'Unauthorized access'], 403);
        }

        // Update fields based on the user's request
        if ($user->id === $flight->user_id) {
            // Allow the user to update specific fields
            $flight->fill($request->only([
                'departure_airport',
                'arrival_airport',
                'departure_date',
                'arrival_date',
                'ticket_count',
                'is_companion',
                'flight_number',
                'seat_preference',
                'upgrade_class',
                'additional_requests',
                'passenger_name',
            ]));
        } elseif ($user->is_admin) {
            // Allow the admin to update additional fields
            $flight->fill($request->only([
                'departure_airport',
                'arrival_airport',
                'departure_date',
                'arrival_date',
                'ticket_count',
                'is_companion',
                'flight_number',
                'seat_preference',
                'upgrade_class',
                'additional_requests',
                'passenger_name',
                // Add any admin-only fields here, if needed
            ]));
        }

        // Handle the passport image if present
        if ($request->hasFile('passport_image')) {
            $image = $request->file('passport_image');
            $imagePath = $image->store('public/passport_images');
            $flight->passport_image = basename($imagePath);
        }

        // Save changes to the flight
        $flight->save();

        return response()->json(['message' => 'Flight updated successfully'], 200);

    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}





}
