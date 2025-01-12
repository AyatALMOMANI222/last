<?php


namespace App\Http\Controllers;

use App\Events\NotificationSent;
use Illuminate\Http\Request;
use App\Models\AvailableFlight;
use App\Models\Flight;
use App\Models\Notification;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;

class AvailableFlightController extends Controller
{
    public function storeAll(Request $request)
    {
        try {
            // Validate incoming request data
            $validatedData = $request->validate([
                'flights' => 'required|array',
                'flights.*.flight_id' => 'required|exists:flights,flight_id',
                'flights.*.data' => 'nullable|array', // جعل data غير إجباري
                'flights..data..departure_date' => 'required_if:flights.*.data,!=,null|date', // جعل departure_date إجباري إذا كان هناك data
                'flights..data..departure_time' => 'required_if:flights.*.data,!=,null',
                'flights..data..departure_flight_number' => 'nullable|string', // Optional
                'flights..data..departure_airport' => 'nullable|string', // Optional
                'flights..data..arrival_flight_number' => 'nullable|string', // Optional
                'flights..data..arrival_date' => 'nullable|date', // Optional
                'flights..data..arrival_time' => 'nullable', // Optional
                'flights..data..arrival_airport' => 'nullable|string', // Optional    
                'flights..data..price' => 'required_if:flights.*.data,!=,null|numeric|min:0',
                'flights..data..is_free' => 'nullable|boolean',
                'flights.*.main_user_id' => 'nullable|exists:users,id', // Optional main_user_id validation
            ]);

            $availableFlights = [];
            $notifications = [];

            foreach ($validatedData['flights'] as $flightData) {
                $flight = Flight::where('flight_id', $flightData['flight_id'])->first();

                if ($flight) {
                    if (isset($flightData['data'])) { // تحقق إذا كانت data موجودة
                        foreach ($flightData['data'] as $tripData) {
                            date_default_timezone_set('Asia/Amman');

                            // Create an available flight entry
                            $availableFlight = AvailableFlight::create([
                                'flight_id' => $flightData['flight_id'],
                                'departure_date' => $tripData['departure_date'] ?? null,
                                'departure_time' => $tripData['departure_time'] ?? null,
                                'departure_flight_number' => $tripData['departure_flight_number'] ?? null,
                                'departure_airport' => $tripData['departure_airport'] ?? null,
                                'arrival_flight_number' => $tripData['arrival_flight_number'] ?? null,
                                'arrival_date' => $tripData['arrival_date'] ?? null,
                                'arrival_time' => $tripData['arrival_time'] ?? null,
                                'arrival_airport' => $tripData['arrival_airport'] ?? null,
                                'price' => $tripData['price'] ?? null,
                                'is_free' => $tripData['is_free'] ?? false,
                                'created_at' => now(),
                            ]);

                            $availableFlights[] = $availableFlight;
                        }
                    }

                    // Check if main_user_id is provided for sending notification
                    foreach ($validatedData['flights'] as $flightData) {
                        $flight = Flight::where('flight_id', $flightData['flight_id'])->first();

                        if ($flight) {
                            // ابحث عن user_id المرتبط بـ flight_id (مثال باستخدام علاقة بين الطائرات والمستخدمين)
                            $user = $flight->user; // أو استخدم الكود المناسب للعثور على الـ user_id المرتبط بالـ flight

                            if ($user && !empty($user->id)) {
                                // إرسال إشعار للمستخدم إذا كان user_id موجودًا
                                $message = 'Check available flights on the website and select your option to proceed.';
                                $userNotification = Notification::create([
                                    'user_id' => $user->id,  // استخدم id من الـ user الذي تم العثور عليه
                                    'message' => $message,
                                    'is_read' => false,
                                    'register_id' => $user->id,
                                ]);

                                $notifications[] = $userNotification;
                                broadcast(new NotificationSent($userNotification)); // Notify user
                            }
                        }
                    }
                }
            }

            return response()->json([
                'message' => 'Available flights created successfully.',
                'available_flights' => $availableFlights,
                'notifications' => $notifications,
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'error' => 'Validation failed',
                'messages' => $e->errors(),
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }


    public function getAvailableFlightByFlightId($flight_id)
    {
        try {
            // التحقق من وجود التوكن
            if (!Auth::check()) {
                return response()->json([
                    'error' => 'Unauthorized. Please log in.',
                ], 401);
            }

            // جلب الرحلات المتاحة المتعلقة بالـ flight_id
            $availableFlights = AvailableFlight::where('available_flights.flight_id', $flight_id) // تحديد الجدول
                ->join('flights', 'available_flights.flight_id', '=', 'flights.flight_id')  // عمل جوين مع جدول الرحلات
                ->select('available_flights.*')  // جلب الحقول المطلوبة من available_flights و flights
                ->get();

            // إذا لم يتم العثور على أي رحلة متاحة
            if ($availableFlights->isEmpty()) {
                return response()->json([
                    'error' => 'No available flights found for the given flight ID.',
                    'data' => []
                ], 200);
            }

            return response()->json([
                'message' => 'Available flights retrieved successfully',
                'available_flights' => $availableFlights,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'An error occurred',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
