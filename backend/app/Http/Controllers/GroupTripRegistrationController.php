<?php

namespace App\Http\Controllers;

use App\Models\GroupTripRegistration;
use App\Models\Trip;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupTripRegistrationController extends Controller
{
    public function store(Request $request)
    {
        // التحقق من صحة البيانات المدخلة
        $validatedData = $request->validate([
            'trip_id' => 'required|exists:trips,id', // التحقق من وجود الرحلة
            'number_of_companion' => 'nullable|integer', // التحقق من عدد المرافقين
        ]);

        // استخراج user_id من التوكن
        $user_id = Auth::id();

        // جلب بيانات الرحلة لحساب السعر الإجمالي
        $trip = Trip::findOrFail($validatedData['trip_id']);

        // حساب السعر الإجمالي بناءً على group_accompanying_price
        $totalPrice = $trip->group_accompanying_price * $validatedData['number_of_companion'];

        // إنشاء تسجيل جديد
        $registration = GroupTripRegistration::create([
            'user_id' => $user_id, // استخدام user_id من التوكن
            'trip_id' => $validatedData['trip_id'],
            'number_of_companion' => $validatedData['number_of_companion'],
            'total_price' => $totalPrice,
        ]);

        // استجابة النجاح
        return response()->json([
            'message' => 'Trip registration created successfully!',
            'data' => $registration,
        ], 201);
    }
    
}
