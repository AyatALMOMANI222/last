<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\DinnerAttendee;
use App\Models\DinnerAttendeesInvoice;
use App\Models\Notification;
use App\Models\Speaker;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DinnerAttendeeController extends Controller
{
    // public function store(Request $request)
    // {
    //     try {
    //         // استخراج user_id من التوكن
    //         $userId = Auth::id(); // على افتراض أنك تستخدم Laravel Passport أو Sanctum للمصادقة
    
    //         // البحث عن المتحدث المرتبط بالمستخدم
    //         $speaker = Speaker::where('user_id', $userId)->firstOrFail();
    
    //         // إعداد البيانات للتحقق
    //         $validatedData = $request->validate([
    //             'companion_name' => 'nullable|string|max:255',
    //             'notes' => 'nullable|string',
    //             'paid' => 'boolean',
    //             'is_companion_fee_applicable' => 'nullable|boolean',
    //             'companion_price' => 'nullable|numeric',
    //             'conference_id' => 'required|numeric|exists:conferences,id', // التحقق من وجود conference_id المدخل في جدول conferences
    //         ]);
    
    //         // إضافة speaker_id إلى البيانات المدخلة
    //         $validatedData['speaker_id'] = $speaker->id;
    
    //         // الحصول على companion_dinner_price من جدول conferences باستخدام conference_id
    //         $conference = Conference::findOrFail($validatedData['conference_id']);
    //         $companionDinnerPrice = $conference->companion_dinner_price;
    
    //         // إضافة companion_dinner_price إلى البيانات المدخلة
    //         $validatedData['companion_dinner_price'] = $companionDinnerPrice;
    
    //         // إنشاء سجل جديد في جدول DinnerAttendee
    //         $dinnerAttendee = DinnerAttendee::create($validatedData);
    
    //         // إنشاء سجل جديد في جدول DinnerAttendeesInvoice
    //         $invoiceData = [
    //             'price' => $companionDinnerPrice,
    //             'status' => 'pending',  // يمكنك تعديل حالة الفاتورة هنا بناءً على الحاجة
    //             'dinner_attendees_id' => $dinnerAttendee->id,  // ربط الفاتورة بحضور العشاء
    //         ];
    
    //         DinnerAttendeesInvoice::create($invoiceData);
    
    //         // إرسال الإشعار
    //         $message = 'All information related to the dinner will be confirmed through a message sent by the organizing company to your WhatsApp.';
    //         $userNotification = Notification::create([
    //             'user_id' => $speaker->user_id,  // إرسال الإشعار إلى user_id الخاص بالـ speaker
    //             'message' => $message,
    //             'is_read' => false,
    //             'register_id' => $speaker->user_id,  // وضع register_id كـ user_id
    //         ]);
    //         broadcast(new NotificationSent($userNotification));
    
    //         // استجابة عند النجاح
    //         return response()->json([
    //             'success' => true,
    //             'message' => 'The participant has been added successfully.',
    //             'companion_dinner_price' => $companionDinnerPrice, // إرسال companion_dinner_price في الاستجابة
    //         ], 201); // 201 تعني Created
    
    //     } catch (\Illuminate\Validation\ValidationException $e) {
    //         // استجابة عند حدوث خطأ في التحقق
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'Validation error: ' . implode(', ', $e->errors()),
    //         ], 422); // 422 تعني Unprocessable Entity
    
    //     } catch (\Exception $e) {
    //         // استجابة عند حدوث خطأ
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'An error occurred while adding the participant: ' . $e->getMessage(),
    //         ], 500); // 500 تعني Internal Server Error
    //     }
    // }

    public function store(Request $request)
{
    try {
        // استخراج user_id من التوكن
        $userId = Auth::id(); // على افتراض أنك تستخدم Laravel Passport أو Sanctum للمصادقة

        // البحث عن المتحدث المرتبط بالمستخدم
        $speaker = Speaker::where('user_id', $userId)->firstOrFail();

        // التحقق مما إذا كان المتحدث مسجلاً بالفعل في DinnerAttendee
        $existingDinnerAttendee = DinnerAttendee::where('speaker_id', $speaker->id)->first();
        if ($existingDinnerAttendee) {
            return response()->json([
                'success' => false,
                'message' => 'The speaker has already been registered for the dinner.',
            ], 400); // 400 تعني Bad Request
        }

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

        // الحصول على companion_dinner_price من جدول conferences باستخدام conference_id
        $conference = Conference::findOrFail($validatedData['conference_id']);
        $companionDinnerPrice = $conference->companion_dinner_price;

        // إضافة companion_dinner_price إلى البيانات المدخلة
        $validatedData['companion_dinner_price'] = $companionDinnerPrice;

        // إنشاء سجل جديد في جدول DinnerAttendee
        $dinnerAttendee = DinnerAttendee::create($validatedData);

        // إنشاء سجل جديد في جدول DinnerAttendeesInvoice
        $invoiceData = [
            'price' => $companionDinnerPrice,
            'status' => 'pending',  // يمكنك تعديل حالة الفاتورة هنا بناءً على الحاجة
            'dinner_attendees_id' => $dinnerAttendee->id,  // ربط الفاتورة بحضور العشاء
        ];

        DinnerAttendeesInvoice::create($invoiceData);

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
            'companion_dinner_price' => $companionDinnerPrice, // إرسال companion_dinner_price في الاستجابة
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

    public function getDinnerInfoFromToken()
    {
        try {
            // استرجاع userId من التوكن
            $userId = Auth::id(); // أو يمكنك استخراج userId من التوكن مباشرة
    
            // 1. الحصول على speaker_id من جدول 'speakers' بناءً على user_id
            $speaker = Speaker::where('user_id', $userId)->first();
    
            if (!$speaker) {
                // إذا لم يتم العثور على المتحدث
                return response()->json(['error' => 'Speaker not found for this user. Please make sure the user is registered as a speaker.'], 404);
            }
    
            // 2. الحصول على بيانات DinnerAttendee باستخدام speaker_id
            $dinnerAttendee = DinnerAttendee::where('speaker_id', $speaker->id)->first();
    
            if (!$dinnerAttendee) {
                // إذا لم يتم العثور على بيانات الحضور للعشاء
                return response()->json(['error' => 'No dinner attendee record found for this speaker.'], 404);
            }
    
            // 3. الحصول على بيانات الفاتورة من جدول 'dinner_attendees_invoice' باستخدام dinner_attendees_id
            $invoice =DinnerAttendeesInvoice::where('dinner_attendees_id', $dinnerAttendee->id)->first();
    
            if (!$invoice) {
                // إذا لم يتم العثور على الفاتورة
                return response()->json(['error' => 'No invoice found for this dinner attendee.'], 404);
            }
    
            // إذا تم العثور على جميع البيانات، إرجاع النتائج
            return response()->json([
                'speaker' => $speaker,
                'dinner_attendee' => $dinnerAttendee,
                'invoice' => $invoice
            ]);
    
        } catch (\Exception $e) {
            // إذا حدث خطأ غير متوقع، إرجاع رسالة خطأ مع تفاصيل الاستثناء
            return response()->json(['error' => 'An unexpected error occurred: ' . $e->getMessage()], 500);
        }
    }
    

    public function getDinnerAttendeesBySpeakerId($speakerId)
    {
        try {
            // جلب الحضور مع بيانات الفاتورة المرتبطة
            $dinnerAttendees = DinnerAttendee::where('speaker_id', $speakerId)
                ->with(['dinnerAttendeesInvoice']) // جلب العلاقة المرتبطة
                ->get();
    
            // التحقق إذا كانت هناك سجلات أم لا
            if ($dinnerAttendees->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No dinner attendees found for this speaker.',
                ], 404); // 404 تعني Not Found
            }
    
            // إرسال الاستجابة مع قائمة الحضور والفواتير المرتبطة
            return response()->json([
                'success' => true,
                'data' => $dinnerAttendees,
            ], 200); // 200 تعني OK
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'success' => false,
                'message' => 'An error occurred: ' . $e->getMessage(),
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


    // public function getAttendeesByConferenceId($conferenceId)
    // {
    //     try {
    //         // التحقق من وجود conference_id المدخل في جدول conferences
    //         if (!Conference::find($conferenceId)) {
    //             return response()->json([
    //                 'success' => false,
    //                 'message' => 'Invalid conference ID.',
    //             ], 422); // 422 تعني Unprocessable Entity
    //         }
    
    //         // الحصول على الحضور المرتبط بالـ conference_id
    //         $attendees = DinnerAttendee::with('speaker') // تحميل بيانات السبيكر
    //             ->where('conference_id', $conferenceId)
    //             ->get(['speaker_id', 'conference_id', 'companion_name', 'companion_price']); // جلب speaker_id و companion_name و companion_price
    
    //         // استجابة عند النجاح
    //         return response()->json([
    //             'success' => true,
    //             'data' => $attendees,
    //         ], 200); // 200 تعني OK
    
    //     } catch (\Exception $e) {
    //         // استجابة عند حدوث خطأ
    //         return response()->json([
    //             'success' => false,
    //             'message' => 'An error occurred while fetching attendees: ' . $e->getMessage(),
    //         ], 500); // 500 تعني Internal Server Error
    //     }
    // }
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

        // إضافة بيانات المستخدم المرتبطة بكل سبيكر
        $attendees->each(function ($attendee) {
            if ($attendee->speaker) {
                $attendee->user = User::find($attendee->speaker->user_id); // جلب بيانات المستخدم باستخدام user_id
            }
        });

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
