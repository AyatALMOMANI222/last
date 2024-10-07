<?php

namespace App\Http\Controllers;

use App\Models\GroupTripParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupTripParticipantController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'trip_id' => 'required|exists:trips,id',
            'selected_date' => 'required|date',
            'companions_count' => 'required|integer|min:0',
            'total_price' => 'nullable|numeric|min:0', // إدخال السعر ليس إلزاميًا
        ]);

        try {
            // قم بإنشاء مشارك جديد في الرحلة الجماعية
            $participant = GroupTripParticipant::create([
                'user_id' => Auth::id(), 
                'trip_id' => $request->trip_id,
                'selected_date' => $request->selected_date,
                'companions_count' => $request->companions_count,
                'total_price' => $request->total_price ?? 0, 
            ]);

            return response()->json([
                'message' => 'Participant added successfully',
                'participant' => $participant,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error adding participant: ' . $e->getMessage(),
            ], 500);
        }
    }
}


