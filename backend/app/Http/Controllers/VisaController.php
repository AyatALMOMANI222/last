<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\ConferenceUser;
use App\Models\Notification;
use App\Models\Speaker;
use App\Models\User;
use App\Models\Visa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VisaController extends Controller
{
public function postVisaByUser(Request $request)
{
    try {
        // تحقق من صحة البيانات المدخلة من قبل المستخدم
        $validatedData = $request->validate([
            'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'arrival_date' => 'nullable|date',
            'departure_date' => 'nullable|date',
        ]);

        // جلب user_id الحالي من التوكن
        $userId = Auth::id();

        // جلب conference_id من جدول conference_user بناءً على user_id
        $conferenceUser = ConferenceUser::where('user_id', $userId)->first();

        if (!$conferenceUser) {
            return response()->json(['error' => 'Conference user not found.'], 404);
        }

        // استرجاع conference_id من جدول conference_user
        $conference_id = $conferenceUser->conference_id;
        $conferenceTitle = Conference::where('id', $conference_id)->value('title');

        // جلب is_visa_payment_required من جدول speakers بناءً على user_id و conference_id
        $speaker = Speaker::where('user_id', $userId)
            ->where('conference_id', $conference_id)
            ->first();

        if (!$speaker) {
            return response()->json(['error' => 'Speaker data not found.'], 404);
        }

        // الحصول على is_visa_payment_required من جدول speakers
        $isVisaPaymentRequired = $speaker->is_visa_payment_required;

        // تعيين قيمة visa_cost بناءً على is_visa_payment_required
        $visaCost = $isVisaPaymentRequired ? Conference::where('id', $conference_id)->value('visa_price') : 0;

        // إنشاء سجل جديد في جدول الفيزا
        $visa = new Visa();
        $visa->user_id = Auth::id();

        // تخزين صورة جواز السفر في مجلد 'images' في 'public'
        if ($request->hasFile('passport_image')) {
            $imagePath = $request->file('passport_image')->store('images', 'public');
            $visa->passport_image = $imagePath; // قم بتحديث مسار الصورة
        } else {
            $visa->passport_image = null;
        }

        $visa->arrival_date = $request->input('arrival_date');
        $visa->departure_date = $request->input('departure_date');
        $visa->visa_cost = $visaCost; // استخدام القيمة المحسوبة هنا
        $visa->payment_required = $isVisaPaymentRequired; // تحديث حالة الدفع
        $visa->status = 'pending';

        // حفظ السجل في قاعدة البيانات
        $visa->save();

        // إشعار آخر للمستخدم بمدة العملية
        $userNotification = Notification::create([
            'user_id' => Auth::id(),
            'register_id' => Auth::id(),
            'conference_id' => $conference_id,
            'message' => 'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',
            'is_read' => false,
        ]);
        broadcast(new NotificationSent($userNotification));

        // إشعار للمدراء عن تقديم معلومات الفيزا
        $admins = User::where('isAdmin', true)->get();
        $userName = Auth::user()->name; // الحصول على اسم المستخدم

        foreach ($admins as $admin) {
            // إنشاء الإشعار مع conference_id و title
            $notification = Notification::create([
                'user_id' => $admin->id,
                'conference_id' => $conference_id,
                'message' => 'New visa request from user: ' . $userName . ' for conference: ' . $conferenceTitle, // إضافة title في الرسالة
                'is_read' => false,
                'register_id' => Auth::id(),
            ]);

            // بث الإشعار
            broadcast(new NotificationSent($notification))->toOthers();
        }

        return response()->json(['success' => 'Visa request submitted successfully', 'visa' => $visa , 'conference_id'=> $conference_id]);

    } catch (\Exception $e) {
        // إذا حدث خطأ، أعد رسالة خطأ مع تفاصيل الاستثناء
        return response()->json(['error' => 'An error occurred while processing the visa request. Please try again later.', 'message' => $e->getMessage()], 500);
    }
}


// public function postVisaByUser(Request $request)
// {
//     try {
//         // تحقق من صحة البيانات المدخلة من قبل المستخدم
//         $validatedData = $request->validate([
//             'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
//             'arrival_date' => 'nullable|date',
//             'departure_date' => 'nullable|date',
//         ]);

//         // جلب conference_id من جدول speakers بناءً على user_id
//         $conference_id = ConferenceUser::where('user_id', Auth::id())->value('conference_id');
        
// // where اقارن الوقت start >now
//         // جلب title من جدول conferences باستخدام conference_id
//         $conferenceTitle = Conference::where('id', $conference_id)->value('title');

//         // استرجاع قيمة is_visa_payment_required من جدول conference_user
//         $userId = Auth::id(); // الحصول على user_id من التوكن
//         $conferenceUser = ConferenceUser::where('user_id', $userId)
//             ->where('conference_id', $conference_id)
//             ->first();

//         if (!$conferenceUser) {
//             return response()->json(['error' => 'Conference user not found.'], 404);
//         }

//         // الحصول على قيمة is_visa_payment_required
//         $isVisaPaymentRequired = $conferenceUser->is_visa_payment_required;

//         // تعيين قيمة visa_cost بناءً على is_visa_payment_required
//         $visaCost = $isVisaPaymentRequired ? Conference::where('id', $conference_id)->value('visa_price') : 0;

//         // إنشاء سجل جديد في جدول الفيزا
//         $visa = new Visa();
//         $visa->user_id = Auth::id();

//         // تخزين صورة جواز السفر في مجلد 'images' في 'public'
//         if ($request->hasFile('passport_image')) {
//             $imagePath = $request->file('passport_image')->store('images', 'public');
//             $visa->passport_image = $imagePath; // قم بتحديث مسار الصورة
//         } else {
//             $visa->passport_image = null;
//         }

//         $visa->arrival_date = $request->input('arrival_date');
//         $visa->departure_date = $request->input('departure_date');
//         $visa->visa_cost = $visaCost; // استخدام القيمة المحسوبة هنا
//         $visa->payment_required = $isVisaPaymentRequired; // تحديث حالة الدفع
//         $visa->status = 'pending';

//         // حفظ السجل في قاعدة البيانات
//         $visa->save();

//         // إشعار آخر للمستخدم بمدة العملية
//         $userNotification = Notification::create([
//             'user_id' => Auth::id(),
//             'register_id' => Auth::id(),
//             'conference_id' => $conference_id,
//             'message' => 'This process takes approximately one month from the date of application, and you will be notified of any updates regarding the visa status.',
//             'is_read' => false,
//         ]);
//         broadcast(new NotificationSent($userNotification));

//         // إشعار للمدراء عن تقديم معلومات الفيزا
//         $admins = User::where('isAdmin', true)->get();
//         $userName = Auth::user()->name; // الحصول على اسم المستخدم

//         foreach ($admins as $admin) {
//             // إنشاء الإشعار مع conference_id و title
//             $notification = Notification::create([
//                 'user_id' => $admin->id,
//                 'conference_id' => $conference_id,
//                 'message' => 'New visa request from user: ' . $userName . ' for conference: ' . $conferenceTitle, // إضافة title في الرسالة
//                 'is_read' => false,
//                 'register_id' => Auth::id(),
//             ]);

//             // بث الإشعار
//             broadcast(new NotificationSent($notification))->toOthers();
//         }

//         return response()->json(['success' => 'Visa request submitted successfully', 'visa' => $visa , 'hh'=> $conference_id]);

//     } catch (\Exception $e) {
//         // إذا حدث خطأ، أعد رسالة خطأ مع تفاصيل الاستثناء
//         return response()->json(['error' => 'An error occurred while processing the visa request. Please try again later.', 'message' => $e->getMessage()], 500);
//     }
// }







public function updateVisaByAdmin(Request $request, $userId)
{
    try {
        // تحقق من صحة البيانات المدخلة من قبل الأدمن
        $validatedData = $request->validate([
            'visa_cost' => 'nullable|numeric|min:0',
            'payment_required' => 'nullable|boolean',
            'status' => 'required|in:pending,approved,rejected',
        ]);

        // العثور على الفيزا الخاصة بالمستخدم المحدد بناءً على user_id
        $visa = Visa::where('user_id', $userId)->first();

        if (!$visa) {
            return response()->json(['message' => 'Visa not found for this user'], 401);
        }

        // تحديث حالة الفيزا فقط بناءً على الحالة المقدمة
        $visa->status = $request->input('status');

        // تحديث تاريخ آخر تعديل لحالة الفيزا وتحديث admin
        $visa->visa_updated_at = now()->setTimezone('Asia/Amman');
        $visa->updated_at_by_admin = now()->setTimezone('Asia/Amman');

        // حفظ التعديلات
        $visa->save();

        // إنشاء الرسالة للإشعار بناءً على حالة الفيزا
        $message = '';
        switch ($visa->status) {
            case 'approved':
                $message = 'Your visa has been approved.';
                break;
            case 'pending':
                $message = 'Your visa is currently pending. Please wait for further updates.';
                break;
            case 'rejected':
                $message = 'Unfortunately, your visa has been rejected.';
                break;
            default:
                $message = 'Your visa status has been updated.';
        }

        // إرسال الإشعار
        $userNotification = Notification::create([
            'user_id' => $userId,
            'message' => $message,
            'is_read' => false,
            'register_id' => $userId,
        ]);

        // إرسال الإشعار بالبث للمستخدم
        broadcast(new NotificationSent($userNotification));

        return response()->json(['success' => 'Visa updated successfully', 'visa' => $visa]);

    } catch (\Exception $e) {
        // عند حدوث خطأ، عرض رسالة خطأ للمستخدم
        return response()->json(['error' => 'An error occurred while updating the visa. Please try again later.'], 500);
    }
}



public function getVisaByAuthUser()
{
    try {
        $userId = Auth::id();

        if (!$userId) {
            return response()->json(['error' => 'User is not authenticated'], 401);
        }

        $visa = Visa::where('user_id', $userId)->first();

        if (!$visa) {
            return response()->json(['message' => 'Visa not found for this user'], 401);
        }

        return response()->json(['visa' => $visa]);

    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred while retrieving visa details', 'message' => $e->getMessage()], 500);
    }
}


}
