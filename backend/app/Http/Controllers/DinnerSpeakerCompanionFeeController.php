<?php

namespace App\Http\Controllers;

use App\Models\DinnerSpeakerCompanionFee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DinnerSpeakerCompanionFeeController extends Controller
{

public function store(Request $request)
{
    try {
        // تحقق من تسجيل دخول المستخدم
        if (!Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'يجب أن تكون مسجلاً الدخول لإضافة رسوم المرافق.',
            ], 401); // 401 تعني Unauthorized
        }

        // تحقق من صحة البيانات
        $validatedData = $request->validate([
            'dinner_id' => 'required|exists:dinner_details,id',
            'speaker_id' => 'required|exists:speakers,id',
            'companion_fee' => 'required|numeric',
        ]);

        // إنشاء سجل جديد في DinnerSpeakerCompanionFee
        $companionFee = DinnerSpeakerCompanionFee::create($validatedData);

        return response()->json($companionFee, 201); // 201 تعني Created

    }  catch (\Exception $e) {
        // استجابة عند حدوث خطأ عام
        return response()->json([
            'success' => false,
            'message' => 'حدث خطأ أثناء إضافة رسوم المرافق: ' . $e->getMessage(),
        ], 500); // 500 تعني Internal Server Error
    }
}

}
