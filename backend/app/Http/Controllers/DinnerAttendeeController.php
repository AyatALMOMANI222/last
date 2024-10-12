<?php

namespace App\Http\Controllers;

use App\Models\DinnerAttendee;
use App\Models\Speaker;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DinnerAttendeeController extends Controller
{
  
    
    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'speaker_id' => 'required|exists:speakers,id',
                'companion_name' => 'nullable|string|max:255',
                'notes' => 'nullable|string',
                'paid' => 'boolean',
                'is_companion_fee_applicable' => 'boolean',
            ]);
    
            // ابحث عن السجل في جدول Speaker باستخدام speaker_id
            $speaker = Speaker::findOrFail($validatedData['speaker_id']);
    
            // تحقق مما إذا كان user_id الخاص بالـ Speaker يتطابق مع المستخدم الحالي
            if ($speaker->user_id !== Auth::id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'ليس لديك الإذن لإضافة هذا المشارك.',
                ], 403); // 403 تعني Forbidden
            }
    
            // إنشاء سجل جديد في جدول DinnerAttendee
            DinnerAttendee::create($validatedData);
    
            // استجابة عند النجاح
            return response()->json([
                'success' => true,
                'message' => 'تم إضافة المشارك بنجاح.',
            ], 201); // 201 تعني Created
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            // استجابة عند حدوث خطأ في التحقق
            return response()->json([
                'success' => false,
                'message' => 'خطأ في التحقق من البيانات: ' . implode(', ', $e->errors()),
            ], 422); // 422 تعني Unprocessable Entity
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'success' => false,
                'message' => 'حدث خطأ أثناء إضافة المشارك: ' . $e->getMessage(),
            ], 500); // 500 تعني Internal Server Error
        }
    }
    
    public function destroy($id)
    {
        try {
            // البحث عن سجل DinnerAttendee باستخدام المعرف المحدد
            $dinnerAttendee = DinnerAttendee::findOrFail($id);
    
        // استخرج speaker_id
        $speakerId = $dinnerAttendee->speaker_id;

        // ابحث عن سجل Speaker المرتبط واحصل على user_id
        $speaker = Speaker::where('id', $speakerId)->firstOrFail();
        $userId = $speaker->user_id;

        // تحقق مما إذا كان المستخدم الحالي هو مالك الـ user_id
        if ($userId !== Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'ليس لديك الإذن لحذف هذا المشارك.',
            ], 403); // 403 تعني Forbidden
        }
    
            // حذف السجل
            $dinnerAttendee->delete();
    
            // استجابة عند النجاح
            return response()->json([
                'success' => true,
                'message' => 'تم حذف المشارك بنجاح.',
            ], 200); // 200 تعني OK
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'success' => false,
                'message' => 'حدث خطأ أثناء حذف المشارك: ' . $e->getMessage(),
            ], 500); // 500 تعني Internal Server Error
        }
    }
    
    public function getAllAttendees()
{
    try {
        // تحقق مما إذا كان المستخدم مسجل الدخول
        if (!Auth::id()) {
            return response()->json([
                'success' => false,
                'message' => 'يجب عليك تسجيل الدخول لرؤية المشاركين.',
            ], 401); // 401 تعني Unauthorized
        }

        // جلب جميع سجلات المشاركين
        $attendees = DinnerAttendee::all();

        // استجابة عند النجاح
        return response()->json([
            'success' => true,
            'data' => $attendees,
        ], 200); // 200 تعني OK

    } catch (\Exception $e) {
        // استجابة عند حدوث خطأ
        return response()->json([
            'success' => false,
            'message' => 'حدث خطأ أثناء جلب المشاركين: ' . $e->getMessage(),
        ], 500); // 500 تعني Internal Server Error
    }
}

    
}
