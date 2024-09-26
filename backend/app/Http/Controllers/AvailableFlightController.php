<?php


namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AvailableFlight;
use App\Models\Flight;
use Illuminate\Support\Facades\Auth;

class AvailableFlightController extends Controller
{
    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'flight_id' => 'required|exists:flights,flight_id',  // تأكد من أن الرحلة موجودة
                'departure_date' => 'required|date',
                'departure_time' => 'required',
                'price' => 'required|numeric|min:0',
                'is_free' => 'boolean',
            ]);
    
            $availableFlight = AvailableFlight::create([
                'flight_id' => $validatedData['flight_id'],
                'departure_date' => $validatedData['departure_date'],
                'departure_time' => $validatedData['departure_time'],
                'price' => $validatedData['price'],
                'is_free' => $validatedData['is_free'] ?? false,  
            ]);
    
            return response()->json([
                'message' => 'Available flight created successfully',
                'available_flight' => $availableFlight,
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
                ], 404);
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

