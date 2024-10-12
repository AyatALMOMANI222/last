<?php

namespace App\Http\Controllers;

use App\Models\DiscountOption;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DiscountOptionController extends Controller
{
    public function store(Request $request)
    {
        // التحقق من صحة البيانات المدخلة
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'trip_id' => 'required|exists:trips,id',
            'option_id' => 'required|exists:additional_options,id',
            'price' => 'required|numeric',
            'show_price' => 'boolean',
        ]);

        // إنشاء Discount Option جديدة
        $discountOption = DiscountOption::create([
            'user_id' => $request->user_id,
            'trip_id' => $request->trip_id,
            'option_id' => $request->option_id,
            'price' => $request->price,
            'show_price' => $request->show_price ?? false, // تعيين القيمة الافتراضية إذا لم يتم تمريرها
        ]);

        // إرجاع استجابة تفيد بنجاح العملية
        return response()->json([
            'message' => 'Discount Option created successfully.',
            'data' => $discountOption,
        ], 201);
    }

    public function getDiscountOptions($tripId)
    {
        // الحصول على user_id من التوكن
        $userId = Auth::id();
    
        // الحصول على خيارات الخصم بناءً على user_id و trip_id
        $discountOptions = DiscountOption::where('user_id', $userId)
                                          ->where('trip_id', $tripId)
                                          ->get();
    
        // التحقق مما إذا كانت هناك خيارات خصم
        if ($discountOptions->isEmpty()) {
            return response()->json([
                'message' => 'No discount options found for the provided user and trip.',
            ], 404);
        }
    
        // إرجاع الخيارات بنجاح
        return response()->json([
            'message' => 'Discount options retrieved successfully.',
            'data' => $discountOptions,
        ], 200);
    }
    

}
