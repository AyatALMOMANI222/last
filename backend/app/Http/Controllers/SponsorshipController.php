<?php

namespace App\Http\Controllers;

use App\Models\Sponsorship;
use Illuminate\Http\Request;

    class SponsorshipController extends Controller
    {
        // تخزين رعاية جديدة
        public function store(Request $request)
        {
            try {
                // التحقق من صحة البيانات
                $request->validate([
                    'item' => 'required|string|max:255',  // اسم العنصر (مثل "أو الباقة")
                    'price' => 'required|string|max:255', // السعر
                    'max_sponsors' => 'required|integer', // العدد الأقصى للراعين
                    'booth_size' => 'required|string', // حجم الكشك
                    'booklet_ad' => 'nullable|string', // الإعلان في الكتيب
                    'website_ad' => 'nullable|string', // الإعلان على الموقع
                    'bags_inserts' => 'nullable|string', // محتويات الحقائب
                    'backdrop_logo' => 'nullable|string', // شعار الخلفية
                    'non_residential_reg' => 'required|integer', // عدد التسجيلات غير السكنية
                    'residential_reg' => 'required|integer', // عدد التسجيلات السكنية
                    'conference_id' => 'required|exists:conferences,id', // التأكد من وجود المؤتمر
                ]);
    
                // إنشاء الرعاية
                $sponsorship = Sponsorship::create([
                    'item' => $request->item,
                    'price' => $request->price,
                    'max_sponsors' => $request->max_sponsors,
                    'booth_size' => $request->booth_size,
                    'booklet_ad' => $request->booklet_ad,
                    'website_ad' => $request->website_ad,
                    'bags_inserts' => $request->bags_inserts,
                    'backdrop_logo' => $request->backdrop_logo,
                    'non_residential_reg' => $request->non_residential_reg,
                    'residential_reg' => $request->residential_reg,
                    'conference_id' => $request->conference_id, // إرفاق الـ conference_id
                ]);
    
                // إرجاع الرد عند النجاح
                return response()->json([
                    'message' => 'Sponsorship created successfully',
                    'data' => $sponsorship
                ], 201); // حالة HTTP 201 تعني أن السجل تم إنشاؤه بنجاح
    
            }  catch (\Exception $e) {
                // إذا حدث خطأ غير متوقع
                return response()->json([
                    'error' => 'Unexpected Error',
                    'message' => $e->getMessage()
                ], 500); // رمز الحالة 500 يعني "خطأ في الخادم"
            }
        }
    }
    

