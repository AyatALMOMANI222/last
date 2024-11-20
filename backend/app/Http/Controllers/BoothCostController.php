<?php

namespace App\Http\Controllers;

use App\Models\BoothCost;
use App\Models\Conference;
use Illuminate\Http\Request;

class BoothCostController extends Controller
{
    /**
     * تخزين بيانات BoothCost جديدة
     */
    public function store(Request $request)
    {
        // التحقق من المدخلات
        $validated = $request->validate([
            'conference_id' => 'required|exists:conferences,id',  // التأكد من وجود conference_id في جدول conferences
            'size' => 'required|string',
            'cost' => 'required|numeric',
            'lunch_invitations' => 'required|integer',
            'name_tags' => 'required|integer',
        ]);

        // محاولة إنشاء الكائن وتخزين البيانات
        try {
            $boothCost = BoothCost::create($validated);  // إنشاء وتخزين البيانات

            // رسالة النجاح في حال تم الحفظ بنجاح
            return response()->json(['message' => 'Booth cost information added successfully!'], 200);

        } catch (\Exception $e) {
            // في حالة حدوث خطأ أثناء الحفظ
            return response()->json(['error' => 'An error occurred while saving the booth cost. Please try again later.'], 500);
        }
    }
    public function getByConferenceId($conferenceId)
{
    try {
        // التحقق من وجود المؤتمر
        $conference = Conference::findOrFail($conferenceId);

        // جلب الأكشاك المرتبطة بالمؤتمر
        $boothCosts = $conference->boothCosts;

        // إرجاع البيانات في استجابة JSON
        return response()->json([
            'conference' => $conference->name, // يمكنك تخصيص البيانات حسب الحاجة
            'boothCosts' => $boothCosts,
        ], 200);

    } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
        // في حال لم يتم العثور على المؤتمر
        return response()->json(['error' => 'Conference not found.'], 404);
    } catch (\Exception $e) {
        // في حالة حدوث خطأ عام
        return response()->json(['error' => 'An error occurred while fetching booth costs.'], 500);
    }
}

}
