<?php

namespace App\Http\Controllers;

use App\Models\GroupTripParticipant;
use App\Models\Trip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupTripParticipantController extends Controller
{
    // public function store(Request $request)
    // {
    //     // التحقق من صحة البيانات المدخلة
    //     $request->validate([
    //         'trip_id' => 'required|exists:trips,id', // التحقق من وجود الرحلة
    //         'selected_date' => 'nullable|date', // تاريخ الرحلة
    //         'companions_count' => 'required|integer|min:0', // عدد المرافقين
    //         'total_price' => 'nullable|numeric|min:0', // السعر الإجمالي (اختياري)
    //     ]);

    //     try {
    //         // جلب بيانات الرحلة من جدول Trips
    //         $trip = Trip::findOrFail($request->trip_id);

    //         // حساب السعر الإجمالي باستخدام group_accompanying_price من الرحلة
    //         $totalPrice = $trip->group_accompanying_price * $request->companions_count;

    //         // إذا كانت قيمة total_price قد تم إرسالها من قبل المستخدم، استخدمها
    //         $totalPrice = $request->total_price ?? $totalPrice;

    //         // قم بإنشاء مشارك جديد في الرحلة الجماعية
    //         $participant = GroupTripParticipant::create([
    //             'user_id' => Auth::id(), // user_id يتم الحصول عليه من التوكن
    //             'trip_id' => $request->trip_id,
    //             'selected_date' => $request->selected_date,
    //             'companions_count' => $request->companions_count,
    //             'total_price' => $totalPrice, // تخزين السعر الإجمالي المحسوب
    //         ]);

    //         return response()->json([
    //             'message' => 'Participant added successfully',
    //             'participant' => $participant,
    //         ], 201);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Error adding participant: ' . $e->getMessage(),
    //         ], 500);
    //     }
    // }

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
            ], 400);
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

}


