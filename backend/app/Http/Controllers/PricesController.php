<?php

namespace App\Http\Controllers;

use App\Models\ConferencePrice;
use Illuminate\Http\Request;

class PricesController extends Controller
{
    public function store(Request $request, $conferenceId)
    {
        // التحقق من صحة الطلب
        $validatedData = $request->validate([
            'price' => 'required|array', // يجب أن يكون السعر مصفوفة
            'price.*.price' => 'required|numeric', // تحقق من أن كل سعر في المصفوفة هو عدد
            'price.*.priceType' => 'nullable|string|max:255', // تحقق من نوع السعر
            'price.*.priceDescription' => 'nullable|string', // تحقق من وصف السعر
        ]);
    
        // إدخال الأسعار في قاعدة البيانات
        foreach ($validatedData['price'] as $priceData) {
            $conferencePrice = new ConferencePrice();
            $conferencePrice->conference_id = $conferenceId;
            $conferencePrice->price_type = $priceData['priceType'] ?? null; // التأكد من استخدام الاسم الصحيح
            $conferencePrice->price = $priceData['price'];
            $conferencePrice->description = $priceData['priceDescription'] ?? null; // التأكد من وجود وصف
    
            $conferencePrice->save();
        }
    
        return response()->json([
            'message' => 'Prices added successfully!',
        ], 201);
    }
    
public function deletePriceByConferenceId($conferenceId, $priceId)
{
    $conferencePrice = ConferencePrice::where('conference_id', $conferenceId)
                                       ->where('id', $priceId)
                                       ->firstOrFail();

    $conferencePrice->delete();

    return response()->json([
        'message' => 'Price deleted successfully!'
    ], 200);
}
public function getPricesByConferenceId($conferenceId)
{
    $conferencePrices = ConferencePrice::where('conference_id', $conferenceId)->get();

    if ($conferencePrices->isEmpty()) {
        return response()->json([
            'message' => 'No prices found for this conference.'
        ], 404);
    }

    return response()->json([
        'message' => 'Prices retrieved successfully!',
        'data' => $conferencePrices
    ], 200);
}

}


