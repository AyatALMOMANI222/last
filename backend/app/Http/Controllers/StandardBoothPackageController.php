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
        ]);

        // تخزين الملف
        $path = $request->file('floor_plan')->store('floor_plans', 'public');

        // إنشاء سجل جديد
        $boothPackage = StandardBoothPackage::create([
            'conference_id' => $request->conference_id,
            'floor_plan' => $path,
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
            ], 404);
        }

        // عرض خطط الأرضية لجميع السجلات
        return response()->json([
            'data' => $boothPackages->map(function($boothPackage) {
                return [
                    'id' => $boothPackage->id,
                    'floor_plan' => asset('storage/' . $boothPackage->floor_plan),  // رابط للملف في المجلد العام
                    'conference_id' => $boothPackage->conference_id,
                ];
            }),
        ], 200);
    }
}
