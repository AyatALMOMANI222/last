<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\GroupRegistration;
use App\Models\Notification;
use App\Models\User;
use App\Notifications\EmailNotification;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupRegistrationController extends Controller
{

    public function store(Request $request)
    {
        try {
            // Validate the input data
            $validatedData = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'phone' => 'nullable|string|max:15',
                'contact_person' => 'nullable|string|max:255',
                'number_of_doctors' => 'nullable|integer|min:0',
                'conference_id' => 'required|exists:conferences,id', // Adding conference_id
                'password' => 'required|string|min:8', // Validate password
            ]);
    
            // Create the new user
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'phone' => $validatedData['phone'],
                'password' => bcrypt($validatedData['password']), // Hash the password
            ]);
    
            // Create a token for the newly registered user (Auto-login)
            $token = $user->createToken('laravel')->plainTextToken;
    
            // Save group registration data with conference_id
            $groupRegistration = GroupRegistration::create([
                'user_id' => $user->id,
                'contact_person' => $validatedData['contact_person'],
                'number_of_doctors' => $validatedData['number_of_doctors'],
                'conference_id' => $validatedData['conference_id'], // Add conference_id
            ]);
    
            // Send notification to the user
            $userNotification =  Notification::create([
                'user_id' => $user->id,
                'message' => 'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',
                'conference_id' => $validatedData['conference_id'],
                'is_read' => false,
            ]);
            broadcast(new NotificationSent($userNotification));
            // Send notifications to all admins
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                $notification =   Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'message' => 'New group registration: ' . $user->email,
                    'is_read' => false,
                ]);
                broadcast(new NotificationSent($notification))->toOthers();
            }
    
            // Return the response with user details and token
            return response()->json([
                'message' => 'User and registration created successfully.',
                'token' => $token,  // Return the token
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'isAdmin' => $user->isAdmin, // Include isAdmin
                ]
            ], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    



    // public function updateGroupByAdminByUserId(Request $request)
    // {
    //     // تحقق من صحة المدخلات
    //     $request->validate([
    //         'user_id' => 'required|exists:users,id', // تحقق من وجود المستخدم
    //         'is_active' => 'required|boolean',
    //         'update_deadline' => 'nullable|date',
    //     ]);
    
    //     try {
    //         // تحديث حالة التسجيل
    //         $groupRegistration = GroupRegistration::where('user_id', $request->user_id)->firstOrFail();
    //         $groupRegistration->is_active = $request->is_active;
    //         $groupRegistration->update_deadline = $request->update_deadline;
    //         $groupRegistration->save();
    
    //         $user = User::findOrFail($request->user_id);
    //         if ($groupRegistration->is_active) {
    //             $user->status = 'approved';
    //             $message = "Now you can access the activated file and download the registered names.";
    //         } else {
    //             $user->status = 'rejected';
    //             $message = "Your registration has been rejected. Please contact support for further assistance.";
    //         }
    //         $user->save();
    
    //         // إذا أصبحت الحالة نشطة، أرسل إشعاراً للمستخدم
    //         if ($groupRegistration->is_active) {
    //             $message = "Now you can access the activated file and download the registered names.";
    
    //             // إنشاء إشعار في قاعدة البيانات
    //             Notification::create([
    //                 'user_id' => $request->user_id,
    //                 'message' => $message,
    //                 'is_read' => false,
    //                 'register_id' => null,
    //             ]);
    // echo( $user->email);
    //             // إرسال الإشعار عبر البريد الإلكتروني
    //             try {
    //                 Notification::route('mail', $user->email)->notify(new EmailNotification($message));
    //             } catch (\Exception $e) {
    //                 // في حال فشل إرسال البريد الإلكتروني
    //                 return response()->json([
    //                     'message' => 'Group registration updated successfully, but email notification failed to send.',
    //                     'error' => $e->getMessage(),
    //                 ], 200);
    //             }
    //         }
    
    //         return response()->json([
    //             'message' => 'Group registration updated successfully.',
    //             'user_id' => $request->user_id,
    //         ], 200);
    
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Failed to update group registration.',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
    
    // public function updateGroupByAdminByUserId(Request $request)
    // {
    //     // تحقق من صحة المدخلات
    //     $request->validate([
    //         'user_id' => 'required|exists:users,id', // تحقق من وجود المستخدم
    //         'is_active' => 'required|boolean',
    //         'update_deadline' => 'nullable|date',
    //     ]);
    
    //     try {
    //         // تحديث حالة التسجيل
    //         $groupRegistration = GroupRegistration::where('user_id', $request->user_id)->firstOrFail();
    //         $groupRegistration->is_active = $request->is_active;
    //         $groupRegistration->update_deadline = $request->update_deadline;
    //         $groupRegistration->save();
    
    //         $user = User::findOrFail($request->user_id);
    //         if ($groupRegistration->is_active) {
    //             $user->status = 'approved';
    //             $message = "Now you can access the activated file and download the registered names.";
    //         } else {
    //             $user->status = 'rejected';
    //             $message = "Your registration has been rejected. Please contact support for further assistance.";
    //         }
    //         $user->save();
    
    //         // إذا أصبحت الحالة نشطة، أرسل إشعاراً للمستخدم
    //         if ($groupRegistration->is_active) {
    //             // إنشاء إشعار في قاعدة البيانات
    //             Notification::create([
    //                 'user_id' => $request->user_id,
    //                 'message' => $message,
    //                 'is_read' => false,
    //                 'register_id' => null,
    //             ]);
    
    //             // إرسال الإشعار عبر البريد الإلكتروني
    //             try {
    //                 $user->notify(new EmailNotification($message)); // استخدم notify على الكائن $user
    //             } catch (\Exception $e) {
    //                 // في حال فشل إرسال البريد الإلكتروني
    //                 return response()->json([
    //                     'message' => 'Group registration updated successfully, but email notification failed to send.',
    //                     'error' => $e->getMessage(),
    //                 ], 200);
    //             }
    //         }
    
    //         return response()->json([
    //             'message' => 'Group registration updated successfully.',
    //             'user_id' => $request->user_id,
    //         ], 200);
    
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Failed to update group registration.',
    //             'error' => $e->getMessage(),
    //         ], 500);
    //     }
    // }
    public function updateGroupByAdminByUserId(Request $request, $user_id) // أضف $user_id كمعامل
{
    // تحقق من صحة المدخلات
    $request->validate([
        'is_active' => 'required|boolean',
        'update_deadline' => 'nullable|date',
    ]);

    try {
        // تحديث حالة التسجيل
        $groupRegistration = GroupRegistration::where('user_id', $user_id)->firstOrFail();
        $groupRegistration->is_active = $request->is_active;
        $groupRegistration->update_deadline = $request->update_deadline;
        $groupRegistration->save();

        $user = User::findOrFail($user_id);
        if ($groupRegistration->is_active) {
            $user->status = 'approved';
            $message = "Now you can access the activated file and download the registered names.";
        } else {
            $user->status = 'rejected';
            $message = "Your registration has been rejected. Please contact support for further assistance.";
        }
        $user->save();

        // إذا أصبحت الحالة نشطة، أرسل إشعاراً للمستخدم
        if ($groupRegistration->is_active) {
            // إنشاء إشعار في قاعدة البيانات
            Notification::create([
                'user_id' => $user_id,
                'message' => $message,
                'is_read' => false,
                'register_id' => null,
            ]);

            // إرسال الإشعار عبر البريد الإلكتروني
            try {
                $user->notify(new EmailNotification($message)); // استخدم notify على الكائن $user
            } catch (\Exception $e) {
                // في حال فشل إرسال البريد الإلكتروني
                return response()->json([
                    'message' => 'Group registration updated successfully, but email notification failed to send.',
                    'error' => $e->getMessage(),
                ], 200);
            }
        }

        return response()->json([
            'message' => 'Group registration updated successfully.',
            'user_id' => $user_id,
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Failed to update group registration.',
            'error' => $e->getMessage(),
        ], 500);
    }
}


    public function updateByUser(Request $request)
    {
        // تحقق من صحة المدخلات
        $request->validate([
            'excel_file' => 'required|file|mimes:xlsx,csv,xls', // تحقق من صحة ملف إكسل
        ]);
    
        try {
            // الحصول على معرف المستخدم من التوكن
            $userId = Auth::id(); // أو يمكن استخدام Auth::user()->id
    
            // ابحث عن تسجيل المجموعة الخاص بالمستخدم
            $groupRegistration = GroupRegistration::where('user_id', $userId)
                // تأكد من وجود علاقة مع جدول ملفات إكسل
                ->firstOrFail();
    
            // تحقق من أن update_deadline لم تتجاوز الوقت الحالي
            if ($groupRegistration->update_deadline && now()->greaterThan($groupRegistration->update_deadline)) {
                return response()->json([
                    'message' => 'Update deadline has passed. You cannot update the excel file.',
                ], 200);
            }
    
            // تخزين ملف الإكسل
            $path = $request->file('excel_file')->store('excel_files', 'public');
    
            // تحديث ملف الإكسل في جدول تسجيل المجموعة
            $groupRegistration->excel_file = $path; // تأكد من وجود حقل excel_file في جدول group_registrations
            $groupRegistration->save();
    
            return response()->json([
                'message' => 'Excel file updated successfully.',
                'file_path' => $path,
            ], 200);
    
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update the excel file.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    
    
    



    public function getRegistrationGroupDataByToken()
{
    // الحصول على user_id من التوكن
    $user_id = Auth::id();

    // التحقق من أن المستخدم مصادق عليه
    if (!$user_id) {
        return response()->json([
            'message' => 'User not authenticated.'
        ], 401);
    }

    try {
        // جلب معلومات التسجيل من جدول GroupRegistration باستخدام user_id
        $groupRegistration = GroupRegistration::where('user_id', $user_id)->first();

        if (!$groupRegistration) {
            return response()->json([
                'message' => 'No registration data found for this user.'
            ], 404);
        }

        return response()->json([
            'message' => 'Registration data retrieved successfully.',
            'data' => $groupRegistration
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Failed to retrieve registration data.',
            'error' => $e->getMessage()
        ], 500);
    }
}
}




