<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\DinnerAttendee;
use App\Models\Notification;
use App\Models\Speaker;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DinnerAttendeeController extends Controller
{
    public function store(Request $request)
    {
        try {
            // استخراج user_id من التوكن
            $userId = Auth::id(); // على افتراض أنك تستخدم Laravel Passport أو Sanctum للمصادقة
    
            // البحث عن المتحدث المرتبط بالمستخدم
            $speaker = Speaker::where('user_id', $userId)->firstOrFail();
    
            // إعداد البيانات للتحقق
            $validatedData = $request->validate([
                'companion_name' => 'nullable|string|max:255',
                'notes' => 'nullable|string',
                'paid' => 'boolean',
                'is_companion_fee_applicable' => 'nullable|boolean',
                'companion_price' => 'nullable|numeric',
                'conference_id' => 'required|numeric|exists:conferences,id', // التحقق من وجود conference_id المدخل في جدول conferences
            ]);
    
            // إضافة speaker_id إلى البيانات المدخلة
            $validatedData['speaker_id'] = $speaker->id;
    
            // إنشاء سجل جديد في جدول DinnerAttendee
            DinnerAttendee::create($validatedData);
    
            // إرسال الإشعار
            $message = 'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.';
            $userNotification = Notification::create([
                'user_id' => $speaker->user_id,  // إرسال الإشعار إلى user_id الخاص بالـ speaker
                'message' => $message,
                'is_read' => false,
                'register_id' => $speaker->user_id,  // وضع register_id كـ user_id
            ]);
            broadcast(new NotificationSent($userNotification));
    
            // استجابة عند النجاح
            return response()->json([
                'success' => true,
                'message' => 'The participant has been added successfully.',
            ], 201); // 201 تعني Created
    
        } catch (\Illuminate\Validation\ValidationException $e) {
            // استجابة عند حدوث خطأ في التحقق
            return response()->json([
                'success' => false,
                'message' => 'Validation error: ' . implode(', ', $e->errors()),
            ], 422); // 422 تعني Unprocessable Entity
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while adding the participant: ' . $e->getMessage(),
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


    public function getAttendeesByConferenceId($conferenceId)
    {
        try {
            // التحقق من وجود conference_id المدخل في جدول conferences
            if (!Conference::find($conferenceId)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid conference ID.',
                ], 422); // 422 تعني Unprocessable Entity
            }
    
            // الحصول على الحضور المرتبط بالـ conference_id
            $attendees = DinnerAttendee::with('speaker') // تحميل بيانات السبيكر
                ->where('conference_id', $conferenceId)
                ->get(['speaker_id', 'conference_id', 'companion_name', 'companion_price']); // جلب speaker_id و companion_name و companion_price
    
            // استجابة عند النجاح
            return response()->json([
                'success' => true,
                'data' => $attendees,
            ], 200); // 200 تعني OK
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while fetching attendees: ' . $e->getMessage(),
            ], 500); // 500 تعني Internal Server Error
        }
    }
    

    public function getAllAttendees()
    {
        try {
            // Check if the user is authenticated
            if (!Auth::id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'يجب عليك تسجيل الدخول لرؤية المشاركين.',
                ], 401); // 401 means Unauthorized
            }
    
            // Fetch all attendees with their associated speaker data
            $attendees = DinnerAttendee::with('speaker')->get();
    
            // Successful response
            return response()->json([
                'success' => true,
                'data' => $attendees,
            ], 200); // 200 means OK
    
        } catch (\Exception $e) {
            // Error response with a specific message
            return response()->json([
                'success' => false,
                'message' => 'حدث خطأ أثناء جلب المشاركين: ' . $e->getMessage(),
                'error_code' => $e->getCode(), // Optional: Include the error code
            ], 500); // 500 means Internal Server Error
        }
    }
    
    

    
}
