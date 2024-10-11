<?php

namespace App\Http\Controllers;

use App\Models\DiscountOption;
use Illuminate\Http\Request;

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
}
