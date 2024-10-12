<?php

namespace App\Http\Controllers;
use App\Models\GroupTripParticipant;
use App\Models\TripOptionsParticipant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class TripOptionParticipantController extends Controller
{


    public function store(Request $request)
    {
        // تحقق من تسجيل الدخول
        if (!Auth::id()) {
            return response()->json(['success' => false, 'message' => 'يجب تسجيل الدخول.'], 401);
        }

        // استرجاع معرف المستخدم من التوكن
        $userId = Auth::id();

        // تحقق من صحة البيانات
        $validatedData = $request->validate([
            'trip_id' => 'required|exists:trips,id', // تأكد من وجود الرحلة
            'selected_date' => 'required|date', // تأكد من أن التاريخ صحيح
            'companions_count' => 'required|integer|min:0', // عدد المرافقين
            'total_price' => 'required|numeric', // إجمالي السعر
            'trip_options' => 'required|array', // مصفوفة من الخيارات
            'trip_options.*.option_id' => 'required|exists:additional_options,id', // تأكد من وجود الخيار
        ]);

        try {
            // إنشاء سجل في جدول group_trip_participants
            $groupParticipant = GroupTripParticipant::create([
                'user_id' => $userId, // استخدام user_id من التوكن
                'trip_id' => $validatedData['trip_id'],
                'selected_date' => $validatedData['selected_date'],
                'companions_count' => $validatedData['companions_count'],
                'total_price' => $validatedData['total_price'],
            ]);

            // إضافة الخيارات المرتبطة إلى جدول trip_options_participants
            foreach ($validatedData['trip_options'] as $option) {
                TripOptionsParticipant::create([
                    'trip_id' => $validatedData['trip_id'],
                    'option_id' => $option['option_id'],
                    'participant_id' => $groupParticipant->id, // استخدام معرف المشارك الذي تم إنشاؤه
                ]);
            }

            // استجابة عند النجاح
            return response()->json(['success' => true, 'message' => 'تم إضافة المشارك والخيارات بنجاح.'], 201);
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json(['success' => false, 'message' => 'حدث خطأ أثناء إضافة البيانات: ' . $e->getMessage()], 500);
        }
    }
}


