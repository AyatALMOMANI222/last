<?php

namespace App\Http\Controllers;

use App\Models\StandardBoothPackage;
use Illuminate\Http\Request;

class StandardBoothPackageController extends Controller
{
    public function store(Request $request)
    {
        // التحقق من صحة المدخلات
        $request->validate([
            'conference_id' => 'required|exists:conferences,id',  // التأكد من وجود conference_id في جدول conferences
            'floor_plan' => 'required|mimes:pdf|max:10240',  // التأكد من أن الملف PDF
            'shell_scheme_price_per_sqm' => 'required|numeric|min:0', // التحقق من أن التكلفة رقمية وغير سالبة
            'space_only_stand_depth' => 'required|numeric|min:0', // التحقق من أن العمق رقم غير سالب
            'space_only_stand_price_usd' => 'required|numeric|min:0', // التحقق من أن السعر رقم غير سالب
        ]);
        $existingPackage = StandardBoothPackage::where('conference_id', $request->conference_id)->first();
    
    if ($existingPackage) {
        return response()->json([
            'error' => 'A booth package already exists for this conference.'
        ], 400); // استجابة مع رسالة خطأ
    }
        // تخزين الملف
        $path = $request->file('floor_plan')->store('floor_plans', 'public');
    
        // إنشاء سجل جديد
        $boothPackage = StandardBoothPackage::create([
            'conference_id' => $request->conference_id,
            'floor_plan' => $path,
            'shell_scheme_price_per_sqm' => $request->shell_scheme_price_per_sqm, // الحقل الجديد
            'space_only_stand_depth' => $request->space_only_stand_depth,         // الحقل الجديد
            'space_only_stand_price_usd' => $request->space_only_stand_price_usd, // الحقل الجديد
        ]);
    
        return response()->json([
            'message' => 'Standard Booth Package created successfully.',
            'data' => $boothPackage,
        ], 201);
    }
    public function getFloorByConferenceId($conferenceId)
    {
        // جلب السجلات المرتبطة بـ conference_id
        $boothPackages = StandardBoothPackage::where('conference_id', $conferenceId)->get();
    
        // التحقق إذا كانت هناك سجلات موجودة
        if ($boothPackages->isEmpty()) {
            return response()->json([
                'message' => 'No booth packages found for this conference.',
                'data' => [] // إرجاع مصفوفة فارغة
            ], 200); // استجابة ناجحة
        }
    
        // عرض البيانات بما في ذلك الحقول الجديدة
        return response()->json([
            'data' => $boothPackages->map(function($boothPackage) {
                return [
                    'id' => $boothPackage->id,
                    'floor_plan' => asset('storage/' . $boothPackage->floor_plan), // رابط للملف في المجلد العام
                    'conference_id' => $boothPackage->conference_id,
                    'shell_scheme_price_per_sqm' => $boothPackage->shell_scheme_price_per_sqm,
                    'space_only_stand_depth' => $boothPackage->space_only_stand_depth,
                    'space_only_stand_price_usd' => $boothPackage->space_only_stand_price_usd,
                ];
            }),
        ], 200);
    }
    

}
