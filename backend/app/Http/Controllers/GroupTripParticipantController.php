<?php

namespace App\Http\Controllers;

use App\Models\GroupTripParticipant;
use App\Models\Trip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupTripParticipantController extends Controller
{


    public function store(Request $request)
    {
        // التحقق من صحة البيانات المدخلة
        $request->validate([
            'trip_id' => 'required|exists:trips,id', // التحقق من وجود الرحلة
            'selected_date' => 'nullable|date', // تاريخ الرحلة
            'companions_count' => 'required|integer|min:0', // عدد المرافقين
            'total_price' => 'nullable|numeric|min:0', // السعر الإجمالي (اختياري)
        ]);

        try {
            // التحقق إذا كان المستخدم قد سجل بالفعل في الرحلة المحددة
            $existingParticipant = GroupTripParticipant::where('user_id', Auth::id())
                ->where('trip_id', $request->trip_id)
                ->first();

            // إذا كان يوجد مشارك مع نفس user_id و trip_id
            if ($existingParticipant) {
                return response()->json([
                    'message' => 'Participant already exists for this trip.',
                ], 200);
            }

            // جلب بيانات الرحلة من جدول Trips
            $trip = Trip::findOrFail($request->trip_id);

            // حساب السعر الإجمالي باستخدام group_accompanying_price من الرحلة
            $totalPrice = $trip->group_accompanying_price * $request->companions_count;

            // إذا كانت قيمة total_price قد تم إرسالها من قبل المستخدم، استخدمها
            $totalPrice = $request->total_price ?? $totalPrice;

            // قم بإنشاء مشارك جديد في الرحلة الجماعية
            $participant = GroupTripParticipant::create([
                'user_id' => Auth::id(), // user_id يتم الحصول عليه من التوكن
                'trip_id' => $request->trip_id,
                'selected_date' => $request->selected_date,
                'companions_count' => $request->companions_count,
                'total_price' => $totalPrice, // تخزين السعر الإجمالي المحسوب
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

    public function getAllParticipants(Request $request)
    {
        // Join GroupTripParticipant with users and trips tables
        $participants = GroupTripParticipant::join('users', 'group_trip_participants.user_id', '=', 'users.id')
            ->join('trips', 'group_trip_participants.trip_id', '=', 'trips.id') // Join with trips table
            ->select('group_trip_participants.*', 
                     'users.name as user_name', 'users.email as user_email', // Select user details
                     'trips.name as trip_name', 'trips.trip_type as trip_type') // Select trip details
            ->paginate(10); // Adjust the number per page as needed
    
        // Return the response with pagination details
        return response()->json([
            'message' => 'Participants, invoice details, and trip information retrieved successfully.',
            'participants' => $participants->items(), // Items for the current page
            'currentPage' => $participants->currentPage(),
            'totalPages' => $participants->lastPage(),
            'totalReservations' => $participants->total(),
        ]);
    }
    
    // public function getAllParticipants(Request $request)
    // {
    //     // Join GroupTripParticipant with users table
    //     $participants = GroupTripParticipant::join('users', 'group_trip_participants.user_id', '=', 'users.id')
    //         ->select('group_trip_participants.*', 'users.name as user_name', 'users.email as user_email') // Adjust the fields you need from the users table
    //         ->paginate(10); // Adjust the number per page as needed
    
    //     // Return the response with pagination details
    //     return response()->json([
    //         'message' => 'Participants, and invoice details retrieved successfully.',
    //         'participants' => $participants->items(), // Items for the current page
    //         'currentPage' => $participants->currentPage(),
    //         'totalPages' => $participants->lastPage(),
    //         'totalReservations' => $participants->total(),
    //     ]);
    // }
    
}


