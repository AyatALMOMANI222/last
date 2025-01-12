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
            $userId = Auth::id();

            // التحقق إذا كان لدى المستخدم فيزا سابقة
            $existingVisa = Visa::where('user_id', $userId)->where('status', 'pending')->first();
    
            if ($existingVisa) {
                return response()->json(['error' => 'You already have an existing visa request pending.'], 400);
            }
            // تحقق من صحة البيانات المدخلة من قبل المستخدم
            $validatedData = $request->validate([
                'passport_image' => 'required',
                'arrival_date' => 'required|date',
                'departure_date' => 'required|date',
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

            if ($speaker) {
                // جلب is_visa_payment_required من جدول speakers بناءً على user_id و conference_id
                $isVisaPaymentRequired = $speaker->is_visa_payment_required;

                // تعيين قيمة visa_cost بناءً على is_visa_payment_required
                $visaCost = $isVisaPaymentRequired ? Conference::where('id', $conference_id)->value('visa_price') : 0;

                // تحديث حالة الدفع حسب المتحدث
                $paymentRequired = $isVisaPaymentRequired;
            } else {
                // إذا كان المستخدم ليس متحدثًا، فهو حاضر ويجب فرض الدفع الكامل
                $visaCost = Conference::where('id', $conference_id)->value('visa_price');
                $paymentRequired = true;
                $isVisaPaymentRequired = true; // يمكن تعيين قيمة وهمية مثل true لأنه سيتم فرض الدفع بالكامل للحاضرين

            }
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

            return response()->json(['success' => 'Visa request submitted successfully', 'visa' => $visa, 'conference_id' => $conference_id]);
        } catch (\Exception $e) {
            // إذا حدث خطأ، أعد رسالة خطأ مع تفاصيل الاستثناء
            return response()->json(['error' => 'An error occurred while processing the visa request. Please try again later.', 'message' => $e->getMessage()], 500);
        }
    }

public function getPendingVisas()
{
    try {
        // استرجاع جميع الطلبات التي حالتها "pending"
        $pendingVisas = Visa::where('status', 'pending')
            ->with(['user']) // جلب البيانات المرتبطة بالمستخدم والمؤتمر
            ->get();

        // إذا لم يتم العثور على أي طلب
        if ($pendingVisas->isEmpty()) {
            return response()->json(['message' => 'No pending visa requests found.'], 404);
        }

        // إرجاع البيانات في شكل JSON
        return response()->json(['pending_visas' => $pendingVisas], 200);

    } catch (\Exception $e) {
        // إذا حدث خطأ، أعد رسالة خطأ مع تفاصيل الاستثناء
        return response()->json(['error' => 'An error occurred while fetching pending visas.', 'message' => $e->getMessage()], 500);
    }
}




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


public function pay(Request $request, $visaId)
{
    try {
        // التحقق من وجود السجل في جدول الفيزا
        $visa = Visa::find($visaId);

        if (!$visa) {
            return response()->json(['error' => 'Visa not found.'], 404);
        }

        // تحديث حالة الدفع إلى "completed" وإدخال تاريخ الدفع
        $visa->payment_status = 'completed';
        $visa->payment_date = now(); // تعيين تاريخ الدفع إلى الآن
        $visa->save();

        // جلب معلومات المستخدم باستخدام user_id من جدول الفيزا
        $user = User::find($visa->user_id);

        if (!$user) {
            return response()->json(['error' => 'User not found.'], 404);
        }

        // جلب معلومات المؤتمر باستخدام conference_id من جدول المستخدم
        $conference = Conference::find($user->conference_id);

        if (!$conference) {
            return response()->json(['error' => 'Conference not found.'], 404);
        }

        // إرسال إشعار إلى الإداريين
        $admins = User::where('isAdmin', true)->get();

        foreach ($admins as $admin) {
            $notificationMessage = 'The user ' . $user->name . ' has completed the visa payment for the conference: ' . $conference->title;

            $notification = Notification::create([
                'user_id' => $admin->id,
                'register_id' => $user->id,
                'conference_id' => $conference->id,
                'message' => $notificationMessage,
                'is_read' => false,
            ]);

            // بث الإشعار
            broadcast(new NotificationSent($notification))->toOthers();
        }

        return response()->json(['success' => 'Payment status updated to completed and notifications sent to admins.', 'visa' => $visa]);

    } catch (\Exception $e) {
        // معالجة الأخطاء مع عرض رسالة الخطأ
        return response()->json([
            'error' => 'An error occurred while processing the payment.',
            'message' => $e->getMessage() // عرض رسالة الخطأ هنا
        ], 500);
    }
}



public function getAllCompletedVisas()
{
    try {
        // استرجاع جميع الفيزات التي حالتها "مكتملة الدفع" مع معلومات المستخدم
        $visas = Visa::where('payment_status', 'completed')
            ->with('user') // تحميل علاقة المستخدم
            ->get();

        if ($visas->isEmpty()) {
            return response()->json(['message' => 'No completed visas found'], 404);
        }

        // تعديل الاستجابة لتضمين معلومات المستخدم
        $result = $visas->map(function ($visa) {
            // استرجاع بيانات المستخدم المرتبطة بالفيزا
            $user = $visa->user;

            return [
                'visa' => $visa,
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'phone' => $user->phone, // يمكنك تعديل هذا ليشمل أي معلومات أخرى ترغب فيها
                ]
            ];
        });

        return response()->json(['visas' => $result]);

    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred while retrieving completed visas', 'message' => $e->getMessage()], 500);
    }


    
}



public function addVisaPdf(Request $request, $visaId)
{
    // التحقق من وجود السجل في جدول الفيزا
    $visa = Visa::find($visaId);
    if (!$visa) {
        return response()->json(['error' => 'Visa not found.'], 404);
    }

    // التحقق من وجود ملف مرفوع
    if ($request->hasFile('visapdf')) {
        $file = $request->file('visapdf');

        // التحقق من نوع الملف (يجب أن يكون PDF أو صورة)
        $allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];
        $fileExtension = $file->getClientOriginalExtension();

        if (!in_array($fileExtension, $allowedExtensions)) {
            return response()->json(['error' => 'The file must be a PDF or an image (JPG, JPEG, PNG).'], 400);
        }

        // تخزين الملف في مجلد 'visapdf' داخل المجلد العام
        $filePath = $file->store('visapdf', 'public'); // تخزين في مجلد public/visapdf

        // تحديث السجل وتخزين مسار الملف
        $visa->visapdf = $filePath;
        $visa->save();

        // **جلب user_id من نفس جدول الفيزا**
        $user = User::find($visa->user_id);
        if (!$user) {
            return response()->json(['error' => 'User not found.'], 404);
        }

        // إرسال إشعار للمستخدم
        $notificationMessage = 'Your visa document has been successfully uploaded. Please log in to your account to download it.';

        $userNotification = Notification::create([
            'user_id' => $user->id,
            'message' => $notificationMessage,
            'is_read' => false, // إعداد القراءة
        ]);

        // بث الإشعار
        broadcast(new NotificationSent($userNotification));

        return response()->json([
            'success' => 'Visa file (PDF or image) added successfully, and notification sent to the user.',
            'visa' => $visa,
        ]);
    }

    return response()->json(['error' => 'No file uploaded.'], 400);
}

public function getAllVisas(Request $request)
{
    try {
        // Define the number of visas per page
        $perPage = 10; // You can adjust this number as needed

        // Get the current page or default to 1 if not provided
        $currentPage = $request->input('page', 1);

        // Query the visas table and join the users table
        $visas = Visa::join('users', 'visas.user_id', '=', 'users.id')
            ->select('visas.*', 'users.name as user_name') // Select all visa fields and user name
            ->paginate($perPage);

        // Return the response in the required format
        return response()->json([
            'message' => 'Visas successfully retrieved.',
            'visas' => $visas->items(),
            'currentPage' => $visas->currentPage(),
            'totalPages' => $visas->lastPage(),
        ]);
    } catch (\Exception $e) {
        // If an error occurs, return the error response
        return response()->json([
            'error' => 'An error occurred while fetching visas.',
            'message' => $e->getMessage(),
        ], 500);
    }
}


}
