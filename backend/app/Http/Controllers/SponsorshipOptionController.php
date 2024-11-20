<?php

namespace App\Http\Controllers;

use App\Models\Conference;
use Illuminate\Http\Request;

class SponsorshipOptionController extends Controller
{
    public function store(Request $request, $conferenceId)
    {
        $conference = Conference::findOrFail($conferenceId);

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|max:50',
        ]);

        $sponsorshipOption = $conference->sponsorshipOptions()->create([
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
        ]);

        return response()->json($sponsorshipOption, 201);
    } 
 
    public function getOptionsByConferenceId($conferenceId)
{
    try {
        // العثور على المؤتمر باستخدام الـ conferenceId
        $conference = Conference::findOrFail($conferenceId);

        // جلب خيارات الرعاية المرتبطة بهذا المؤتمر
        $sponsorshipOptions = $conference->sponsorshipOptions;

        // إرجاع البيانات على شكل JSON
        return response()->json($sponsorshipOptions);
    } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
        // إذا لم يتم العثور على المؤتمر، سيتم رمي استثناء
        return response()->json(['message' => 'Conference not found'], 404);
    } catch (\Exception $e) {
        // معالجة أي أخطاء أخرى
        return response()->json(['message' => 'An error occurred while fetching the sponsorship options. Please try again later.'], 500);
    }
}
}
