<?php

namespace App\Http\Controllers;

use App\Models\Reservation;
use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ReservationController extends Controller
{
    public function create(Request $request)
    {
        $validatedData = $request->validate([
            'check_in_date' => 'required|date',
            'check_out_date' => 'required|date|after:check_in_date',
            'late_check_out' => 'nullable|boolean',
            'early_check_in' => 'nullable|boolean',
            'total_nights' => 'required|integer|min:1',
            'room_count' => 'required|integer|min:1',
            'companions' => 'nullable|string',
            'special_requests' => 'nullable|string',
            'room_type' => 'required|in:Single,Double,Triple', // إضافة نوع الغرفة
        ]);

        // إنشاء حجز جديد
        $reservation = Reservation::create([
            'user_id' => Auth::id(),
            'check_in_date' => $validatedData['check_in_date'],
            'check_out_date' => $validatedData['check_out_date'],
            'late_check_out' => $validatedData['late_check_out'],
            'early_check_in' => $validatedData['early_check_in'],
            'total_nights' => $validatedData['total_nights'],
            'room_count' => $validatedData['room_count'],
            'companions' => $validatedData['companions'],
        ]);

        // إنشاء الغرف المطلوبة
        for ($i = 0; $i < $validatedData['room_count']; $i++) {
            Room::create([
                'reservation_id' => $reservation->id,
                'room_type' => $validatedData['room_type'],
                'occupant_name' => $request->input("occupant_name_$i"),
                'special_requests' => $validatedData['special_requests'],
                'cost' => 0, // أو يمكن حساب التكلفة بناءً على نوع الغرفة
                'is_confirmed' => false,
            ]);
        }

        return response()->json(['message' => 'Reservation created successfully'], 201);
    }
}

