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
        if (!Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'يجب أن تكون مسجلاً الدخول لإضافة رسوم المرافق.',
            ], 401); // 401 تعني Unauthorized
        }

        $validatedData = $request->validate([
            'dinner_id' => 'required|exists:dinner_details,id',
            'speaker_id' => 'required|exists:speakers,id',
            'companion_fee' => 'required|numeric',
        ]);

        $companionFee = DinnerSpeakerCompanionFee::create($validatedData);

        return response()->json($companionFee, 201); // 201 تعني Created

    }  catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'حدث خطأ أثناء إضافة رسوم المرافق: ' . $e->getMessage(),
        ], 500); 
    }
}
public function getDinnerCompanionFees(Request $request, $dinnerId)
{
    try {
        // تحقق من تسجيل الدخول
        if (!Auth::check()) {
            return response()->json([
                'success' => false,
                'message' => 'يجب أن تكون مسجلاً الدخول لرؤية تفاصيل رسوم المرافق.',
            ], 401); // 401 تعني Unauthorized
        }

        // استرجاع رسوم المرافق المرتبطة بـ dinner_id المحدد
        $companionFees = DinnerSpeakerCompanionFee::with('dinnerDetail')
            ->where('dinner_id', $dinnerId)
            ->get();

        // تحقق مما إذا كانت هناك بيانات مستردة
        if ($companionFees->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'لا توجد رسوم مرافق متاحة لهذا العشاء.',
            ], 404); // 404 تعني Not Found
        }

        return response()->json([
            'success' => true,
            'data' => $companionFees,
        ], 200); // 200 تعني OK

    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'حدث خطأ أثناء جلب تفاصيل رسوم المرافق: ' . $e->getMessage(),
        ], 500);
    }
}


}
