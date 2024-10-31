<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Conference;
use App\Models\Notification;
use App\Models\Speaker;
use App\Models\User;
use App\Models\Visa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VisaController extends Controller
{
//     public function postVisaByUser(Request $request)
// {
//     // تحقق من صحة البيانات المدخلة من قبل المستخدم
//     $validatedData = $request->validate([
//         'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
//         'arrival_date' => 'nullable|date',
//         'departure_date' => 'nullable|date',
//     ]);

//     // إنشاء سجل جديد في جدول الفيزا
//     $visa = new Visa();
//     $visa->user_id = Auth::id(); // تعيين ID المتحدث الحالي
//     $visa->passport_image = $request->file('passport_image') ? $request->file('passport_image')->store('passport_images') : null;
//     $visa->arrival_date = $request->input('arrival_date');
//     $visa->departure_date = $request->input('departure_date');
//     // الفيزا قد تحتاج إلى قيمة تكلفة مبدئية إذا كان الدفع مطلوباً
//     $visa->visa_cost = 0; // يمكن تعيين قيمة افتراضية إذا لزم الأمر
//     $visa->payment_required = false; // سيتم تحديد ذلك لاحقاً من قبل الأدمن
//     $visa->status = 'pending'; // تعيين الحالة إلى "معلق" افتراضيًا

//     // حفظ السجل في قاعدة البيانات
//     $visa->save();

//     return response()->json(['success' => 'Visa request submitted successfully', 'visa' => $visa]);
// }



public function postVisaByUser(Request $request)
{
    try {
        // تحقق من صحة البيانات المدخلة من قبل المستخدم
        $validatedData = $request->validate([
            'passport_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'arrival_date' => 'nullable|date',
            'departure_date' => 'nullable|date',
        ]);

        // جلب conference_id من جدول speakers بناءً على user_id
        $conference_id = Speaker::where('user_id', Auth::id())->value('conference_id');

        // جلب title من جدول conferences باستخدام conference_id
        $conferenceTitle = Conference::where('id', $conference_id)->value('title');

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
        $visa->visa_cost = 0;
        $visa->payment_required = false;
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
            ]);

            // بث الإشعار
            broadcast(new NotificationSent($notification))->toOthers();
        }

        return response()->json(['success' => 'Visa request submitted successfully', 'visa' => $visa]);

    } catch (\Exception $e) {
        // إذا حدث خطأ، أعد رسالة خطأ مع تفاصيل الاستثناء
        return response()->json(['error' => 'An error occurred while processing the visa request. Please try again later.', 'message' => $e->getMessage()], 500);
    }
}








public function updateVisaByAdmin(Request $request, $userId)
{
    // تحقق من صحة البيانات المدخلة من قبل الأدمن
    $validatedData = $request->validate([
        'visa_cost' => 'nullable|numeric|min:0',
        'payment_required' => 'required|boolean',
        'status' => 'required|in:pending,approved,rejected',
    ]);

    // العثور على الفيزا الخاصة بالمستخدم المحدد بناءً على user_id
    $visa = Visa::where('user_id', $userId)->first();

    if (!$visa) {
        return response()->json(['error' => 'Visa not found for this user'], 404);
    }

    // تحديث بيانات الفيزا
    $visa->visa_cost = $request->input('payment_required') ? $request->input('visa_cost') ?? 0 : 0;
    $visa->payment_required = $request->input('payment_required');
    $visa->status = $request->input('status');

    // تحديث تاريخ آخر تعديل لحالة الفيزا
    $visa->visa_updated_at = now();
    
    // تعيين updated_at_by_admin إلى الآن
    $visa->updated_at_by_admin = now();

    // حفظ التعديلات
    $visa->save();

    return response()->json(['success' => 'Visa updated successfully', 'visa' => $visa]);
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
            return response()->json(['error' => 'Visa not found for this user'], 404);
        }

        return response()->json(['visa' => $visa]);

    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred while retrieving visa details', 'message' => $e->getMessage()], 500);
    }
}


}
