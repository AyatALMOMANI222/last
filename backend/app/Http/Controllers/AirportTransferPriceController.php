<?php

namespace App\Http\Controllers;

use App\Models\AirportTransferPrice;
use Dotenv\Validator;
use Illuminate\Http\Request;

class AirportTransferPriceController extends Controller
{

    public function store(Request $request)
    {
        try {
            $request->validate([
                'conference_id' => 'required|exists:conferences,id', // يجب أن يكون موجودًا في جدول المؤتمرات
                'from_airport_price' => 'nullable|numeric',
                'to_airport_price' => 'nullable|numeric',
                'round_trip_price' => 'nullable|numeric',
            ]);
    
            $price = AirportTransferPrice::create([
                'conference_id' => $request->conference_id,
                'from_airport_price' => $request->from_airport_price,
                'to_airport_price' => $request->to_airport_price,
                'round_trip_price' => $request->round_trip_price,
            ]);
    
            return response()->json([
                'success' => true,
                'data' => $price
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'حدث خطأ أثناء إنشاء السعر. ' . $e->getMessage()
            ], 500); 
        }
    }
    public function getPricesByConferenceId($conferenceId)
{
    try {
        // استرجاع الأسعار الخاصة بالمؤتمر المحدد
        $prices = AirportTransferPrice::where('conference_id', $conferenceId)->get();

        // التحقق من وجود أسعار
        if ($prices->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'لا توجد أسعار متاحة لهذا المؤتمر.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $prices
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'message' => 'حدث خطأ أثناء جلب الأسعار. ' . $e->getMessage()
        ], 500);
    }
}

}


