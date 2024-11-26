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
                'phone_number' => $validatedData['phone'],
                'password' => bcrypt($validatedData['password']), // Hash the password
                'registration_type' => 'group_registration'
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




//     public function getAllActiveRegistrations()
//     {
//         try {
//             // جلب جميع السجلات النشطة مع بيانات المستخدمين
//             $registrations = GroupRegistration::where('is_active', true)
//                 ->with('user') // جلب بيانات المستخدم المرتبطة
//                 ->get()
//                 ->map(function ($registration) {
//                     return [
//                         'user_name' => $registration->user->name ?? null,
//                         'user_email' => $registration->user->email ?? null,
//                         'user_phone' => $registration->user->phone ?? null,
//                         'organization_name' => $registration->organization_name,
//                         'contact_person' => $registration->contact_person,
//                         'contact_email' => $registration->contact_email,
//                         'contact_phone' => $registration->contact_phone,
//                         'number_of_doctors' => $registration->number_of_doctors,
//                         'excel_file' => $registration->excel_file,
//                         'update_deadline' => $registration->update_deadline,
//                     ];
//                 });

//             // إرجاع البيانات كـ JSON
//             return response()->json([
//                 'message' => 'Active registrations retrieved successfully.',
//                 'data' => $registrations,
//             ], 200);
//         } catch (\Exception $e) {
//             return response()->json([
//                 'message' => 'Failed to retrieve active registrations.',
//                 'error' => $e->getMessage(),
//             ], 500);
//         }
    
// }
// public function getAllActiveRegistrations()
// {
//     try {
//         // تحديد عدد السجلات في كل صفحة (مثلاً 10)
//         $perPage = 10;

//         // جلب السجلات النشطة مع بيانات المستخدمين باستخدام التصفية والصفحات
//         $registrations = GroupRegistration::where('is_active', true)
//             ->with('user') // جلب بيانات المستخدم المرتبطة
//             ->paginate($perPage); // استخدام paginate بدلاً من get

//         // تحويل السجلات إلى هيكل البيانات الذي تريده
//         $registrations = $registrations->map(function ($registration) {
//             return [
//                 'user_name' => $registration->user->name ?? null,
//                 'user_email' => $registration->user->email ?? null,
//                 'user_phone' => $registration->user->phone ?? null,
//                 'organization_name' => $registration->organization_name,
//                 'contact_person' => $registration->contact_person,
//                 'contact_email' => $registration->contact_email,
//                 'contact_phone' => $registration->contact_phone,
//                 'number_of_doctors' => $registration->number_of_doctors,
//                 'excel_file' => $registration->excel_file,
//                 'update_deadline' => $registration->update_deadline,
//             ];
//         });

//         // إرجاع البيانات كـ JSON مع معلومات الصفحات
//         return response()->json([
//             'message' => 'Active registrations retrieved successfully.',
//             'data' => $registrations,
//             'pagination' => [
//                 'total' => $registrations->total(),
//                 'per_page' => $registrations->perPage(),
//                 'current_page' => $registrations->currentPage(),
//                 'last_page' => $registrations->lastPage(),
//                 'next_page_url' => $registrations->nextPageUrl(),
//                 'prev_page_url' => $registrations->previousPageUrl(),
//             ],
//         ], 200);
//     } catch (\Exception $e) {
//         return response()->json([
//             'message' => 'Failed to retrieve active registrations.',
//             'error' => $e->getMessage(),
//         ], 500);
//     }
// }


public function getAllActiveRegistrations(Request $request)
{
    try {
        $search = $request->input('search', '');
        $perPage = $request->input('per_page', 10); // Number of results per page

        // Fetch active registrations with pagination
        $registrations = GroupRegistration::where('is_active', true)
            ->with('user') // Fetch the related user data
            ->when($search, function ($query) use ($search) {
                $query->whereHas('user', function ($q) use ($search) {
                    $q->where('name', 'LIKE', "%{$search}%")
                      ->orWhere('email', 'LIKE', "%{$search}%")
                      ->orWhere('phone', 'LIKE', "%{$search}%");
                })->orWhere('organization_name', 'LIKE', "%{$search}%")
                  ->orWhere('contact_person', 'LIKE', "%{$search}%");
            })
            ->paginate($perPage);

        // Modify the data to merge fields from both GroupRegistration and User tables
        $registrationsWithDetails = $registrations->items();

        $registrationsWithDetails = array_map(function ($registration) {
            return [
                'user_name' => $registration->user->name ?? 'N/A', // From User table
                'user_email' => $registration->user->email ?? 'N/A', // From User table
                'contact_phone' => $registration->user->phone_number ?? 'N/A', // From User table
                'organization_name' => $registration->user->name ?? 'N/A', // تخزين اسم المستخدم في organization_name
                'contact_person' => $registration->contact_person,
                'contact_email' => $registration->contact_email,
                // 'contact_phone' => $registration->contact_phone,
                'number_of_doctors' => $registration->number_of_doctors,
                'excel_file' => $registration->excel_file,
                'update_deadline' => $registration->update_deadline,
            ];
        }, $registrationsWithDetails);

        // Return the data with pagination details
        return response()->json([
            'message' => 'Active registrations retrieved successfully.',
            'registrations' => [
                'data' => $registrationsWithDetails,
                'current_page' => $registrations->currentPage(),
                'last_page' => $registrations->lastPage(),
                'per_page' => $registrations->perPage(),
                'total' => $registrations->total(),
            ],
        ], 200);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Failed to retrieve active registrations.',
            'error' => $e->getMessage(),
        ], 500);
    }
}


}




