<?php

namespace App\Http\Controllers;

use App\Models\Conference;
use App\Models\Notification;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Broadcast;
use App\Events\NotificationSent;
use App\Notifications\EmailNotification;
use Egulias\EmailValidator\EmailValidator;
use Egulias\EmailValidator\Validation\RFCValidation;

use function Laravel\Prompts\error;

class UserController extends Controller
{
    public function storeAdmin(Request $request)
    {
        try {
            // Validate the required fields
            $validatedData = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:8',
            ], [
                'email.unique' => 'The email address is already taken. Please choose another one.',
            ]);

            // Create the new admin user
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
            ]);

            // Return a success response
            return response()->json([
                'message' => 'Admin user created successfully!',
                'user_id' => $user->id,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create admin user.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function updateAdminStatus(Request $request, $userId)
    {
        try {
            // Validate the required fields
            $validatedData = $request->validate([
                'isAdmin' => 'required|boolean',  // Ensure isAdmin is a boolean
                'status' => 'required|string|in:approved,pending,rejected',  // Ensure status is a valid value
            ]);

            // Find the user by id
            $user = User::findOrFail($userId);

            // Update the isAdmin and status fields
            $user->isAdmin = $validatedData['isAdmin'];
            $user->status = $validatedData['status'];

            // Save the updated user
            $user->save();

            // Return a success response
            return response()->json([
                'message' => 'User admin status and approval status updated successfully!',
                'user_id' => $user->id,
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update user admin status and approval status.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    // public function store(Request $request, $conference_id)
    // {
    //     try {
    //         // تحقق من صحة البيانات
    //         $validatedData = $request->validate([
    //             'name' => 'nullable|string|max:255',
    //             'email' => 'required|email|unique:users,email',
    //             'password' => 'required|string|min:8',
    //             'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
    //             'biography' => 'nullable|string',
    //             'registration_type' => 'nullable|in:speaker,attendance,sponsor,group_registration',
    //             'phone_number' => 'nullable|string|max:255',
    //             'whatsapp_number' => 'nullable|string|max:255',
    //             'specialization' => 'nullable|string|max:255',
    //             'nationality' => 'nullable|string|max:255',
    //             'country_of_residence' => 'nullable|string|max:255',
    //             'isAdmin' => 'sometimes|in:true,false',
    //             'passenger_name' => 'nullable|string|max:255',
    //             'company_name' => 'nullable|string|max:255',
    //             'contact_person' => 'nullable|string|max:255',
    //             'company_address' => 'nullable|string|max:255',
    //         ]);

    //         // تحقق من وجود conference_id في قاعدة البيانات
    //         $conferenceExists = Conference::find($conference_id);
    //         if (!$conferenceExists) {
    //             return response()->json(['message' => 'Conference not found.'], 404);
    //         }

    //         // رفع الصورة إذا كانت موجودة
    //         if ($request->hasFile('image')) {
    //             $path = $request->file('image')->store('images', 'public');
    //             $validatedData['image'] = $path;
    //         }

    //         // التأكد من أن isAdmin عبارة عن قيمة منطقية
    //         $validatedData['isAdmin'] = filter_var($request->input('isAdmin', false), FILTER_VALIDATE_BOOLEAN);

    //         // إنشاء المستخدم الجديد باستخدام المدخلات فقط
    //         $user = User::create(array_filter([
    //             'name' => $validatedData['name'] ?? null,
    //             'email' => $validatedData['email'],
    //             'password' => bcrypt($validatedData['password']),
    //             'image' => $validatedData['image'] ?? null,
    //             'biography' => $validatedData['biography'] ?? null,
    //             'registration_type' => $validatedData['registration_type'] ?? null,
    //             'phone_number' => $validatedData['phone_number'] ?? null,
    //             'whatsapp_number' => $validatedData['whatsapp_number'] ?? null,
    //             'specialization' => $validatedData['specialization'] ?? null,
    //             'nationality' => $validatedData['nationality'] ?? null,
    //             'country_of_residence' => $validatedData['country_of_residence'] ?? null,
    //             'isAdmin' => $validatedData['isAdmin'],
    //             'company_name' => $validatedData['company_name'] ?? null,
    //             'contact_person' => $validatedData['contact_person'] ?? null,
    //             'company_address' => $validatedData['company_address'] ?? null,
    //             'conference_id' => $conference_id ?? null,
    //         ]));

    //         // إضافة المستخدم إلى جدول conference_user
    //         $user->conferences()->attach($conference_id);

    //         // إرسال الإشعار لجميع المدراء
    //         $admins = User::where('isAdmin', true)->get();
    //         foreach ($admins as $admin) {
    //             // إنشاء الإشعار
    //             $notification = Notification::create([
    //                 'user_id' => $admin->id,
    //                 'register_id' => $user->id,
    //                 'conference_id' => $conference_id,
    //                 'message' => 'New speaker registration: ' . $user->name,
    //                 'is_read' => false,
    //             ]);

    //             // بث الإشعار
    //             broadcast(new NotificationSent($notification))->toOthers();

    //         }
    //         $userNotification = Notification::create([
    //             'user_id' => $user->id,
    //             'register_id' => $user->id,
    //             'conference_id' => $conference_id,
    //             'message' => 'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',
    //             'is_read' => false,
    //         ]);

    //         // بث الإشعار للمستخدم الجديد
    //         broadcast(new NotificationSent($userNotification));
    //         $user->notify(new EmailNotification('Thank you for registering for the conference. Your profile will be reviewed shortly.'));


    //         return response()->json([
    //             'message' => 'User created, added to conference, and notifications sent successfully!',
    //             "id" => $conference_id
    //         ], 201);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Failed to create user.',
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }
    // }
    // public function store(Request $request, $conference_id)
    // {
    //     try {
    //         // تحقق من صحة البيانات
    //         $validatedData = $request->validate([
    //             'name' => 'nullable|string|max:255',
    //             'email' => 'required|email|unique:users,email',  // تحقق من البريد الإلكتروني باستخدام القاعدة المدمجة
    //             'password' => 'required|string|min:8',
    //             'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
    //             'biography' => 'nullable|string',
    //             'registration_type' => 'nullable|in:speaker,attendance,sponsor,group_registration',
    //             'phone_number' => 'nullable|string|max:255',
    //             'whatsapp_number' => 'nullable|string|max:255',
    //             'specialization' => 'nullable|string|max:255',
    //             'nationality' => 'nullable|string|max:255',
    //             'country_of_residence' => 'nullable|string|max:255',
    //             'isAdmin' => 'sometimes|in:true,false',
    //             'passenger_name' => 'nullable|string|max:255',
    //             'company_name' => 'nullable|string|max:255',
    //             'contact_person' => 'nullable|string|max:255',
    //             'company_address' => 'nullable|string|max:255',
    //         ]);
    
    //         // تحقق من صحة البريد الإلكتروني باستخدام مكتبة EmailValidator
    //         $validator = new EmailValidator();
    //         $email = $validatedData['email'];
            
    //         // التحقق من صحة البريد الإلكتروني باستخدام RFCValidation
    //         if (!$validator->isValid($email, new RFCValidation())) {
    //             return response()->json(['message' => 'The email address is invalid.'], 400);
    //         }
    
    //         // تحقق من وجود conference_id في قاعدة البيانات
    //         $conferenceExists = Conference::find($conference_id);
    //         if (!$conferenceExists) {
    //             return response()->json(['message' => 'Conference not found.'], 404);
    //         }
    
    //         // رفع الصورة إذا كانت موجودة
    //         if ($request->hasFile('image')) {
    //             $path = $request->file('image')->store('images', 'public');
    //             $validatedData['image'] = $path;
    //         }
    
    //         // التأكد من أن isAdmin عبارة عن قيمة منطقية
    //         $validatedData['isAdmin'] = filter_var($request->input('isAdmin', false), FILTER_VALIDATE_BOOLEAN);
    
    //         // إنشاء المستخدم الجديد باستخدام المدخلات فقط
    //         $user = User::create(array_filter([
    //             'name' => $validatedData['name'] ?? null,
    //             'email' => $validatedData['email'],
    //             'password' => bcrypt($validatedData['password']),
    //             'image' => $validatedData['image'] ?? null,
    //             'biography' => $validatedData['biography'] ?? null,
    //             'registration_type' => $validatedData['registration_type'] ?? null,
    //             'phone_number' => $validatedData['phone_number'] ?? null,
    //             'whatsapp_number' => $validatedData['whatsapp_number'] ?? null,
    //             'specialization' => $validatedData['specialization'] ?? null,
    //             'nationality' => $validatedData['nationality'] ?? null,
    //             'country_of_residence' => $validatedData['country_of_residence'] ?? null,
    //             'isAdmin' => $validatedData['isAdmin'],
    //             'company_name' => $validatedData['company_name'] ?? null,
    //             'contact_person' => $validatedData['contact_person'] ?? null,
    //             'company_address' => $validatedData['company_address'] ?? null,
    //             'conference_id' => $conference_id ?? null,
    //         ]));
    
    //         // إضافة المستخدم إلى جدول conference_user
    //         $user->conferences()->attach($conference_id);
    
    //         // إرسال الإشعار لجميع المدراء
    //         $admins = User::where('isAdmin', true)->get();
    //         foreach ($admins as $admin) {
    //             // إنشاء الإشعار
    //             $notification = Notification::create([
    //                 'user_id' => $admin->id,
    //                 'register_id' => $user->id,
    //                 'conference_id' => $conference_id,
    //                 'message' => 'New speaker registration: ' . $user->name,
    //                 'is_read' => false,
    //             ]);
    
    //             // بث الإشعار
    //             broadcast(new NotificationSent($notification))->toOthers();
    //         }
    
    //         $userNotification = Notification::create([
    //             'user_id' => $user->id,
    //             'register_id' => $user->id,
    //             'conference_id' => $conference_id,
    //             'message' => 'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',
    //             'is_read' => false,
    //         ]);
    
    //         // بث الإشعار للمستخدم الجديد
    //         broadcast(new NotificationSent($userNotification));
    //         $user->notify(new EmailNotification('Thank you for registering for the conference. Your profile will be reviewed shortly.'));
    
    //         return response()->json([
    //             'message' => 'User created, added to conference, and notifications sent successfully!',
    //             "id" => $conference_id
    //         ], 201);
    //     } catch (\Exception $e) {
    //         return response()->json([
    //             'message' => 'Failed to create user.',
    //             'error' => $e->getMessage()
    //         ], 500);
    //     }
    // }

public function store(Request $request, $conference_id)
{
    try {
        // تحقق من صحة البيانات
        $validatedData = $request->validate([
            'name' => 'nullable|string|max:255',
            'email' => 'required|email|unique:users,email',  // تحقق من صحة البريد الإلكتروني باستخدام القاعدة المدمجة
            'password' => 'required|string|min:8',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'biography' => 'nullable|string',
            'registration_type' => 'nullable|in:speaker,attendance,sponsor,group_registration',
            'phone_number' => 'nullable|string|max:255',
            'whatsapp_number' => 'nullable|string|max:255',
            'specialization' => 'nullable|string|max:255',
            'nationality' => 'nullable|string|max:255',
            'country_of_residence' => 'nullable|string|max:255',
            'isAdmin' => 'sometimes|in:true,false',
            'passenger_name' => 'nullable|string|max:255',
            'company_name' => 'nullable|string|max:255',
            'contact_person' => 'nullable|string|max:255',
            'company_address' => 'nullable|string|max:255',
        ]);

        // تحقق من صحة البريد الإلكتروني باستخدام مكتبة EmailValidator
        $emailValidator = new EmailValidator();
        $email = $validatedData['email'];

        // التحقق من صحة البريد الإلكتروني باستخدام RFCValidation
        if (!$emailValidator->isValid($email, new RFCValidation())) {
            return response()->json(['message' => 'The email address is invalid.'], 400);
        }


        // تحقق من وجود conference_id في قاعدة البيانات
        $conferenceExists = Conference::find($conference_id);
        if (!$conferenceExists) {
            return response()->json(['message' => 'Conference not found.'], 404);
        }

        // رفع الصورة إذا كانت موجودة
        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('images', 'public');
            $validatedData['image'] = $path;
        }

        // التأكد من أن isAdmin عبارة عن قيمة منطقية
        $validatedData['isAdmin'] = filter_var($request->input('isAdmin', false), FILTER_VALIDATE_BOOLEAN);

        // إنشاء المستخدم الجديد باستخدام المدخلات فقط
        $user = User::create(array_filter([
            'name' => $validatedData['name'] ?? null,
            'email' => $validatedData['email'],
            'password' => bcrypt($validatedData['password']),
            'image' => $validatedData['image'] ?? null,
            'biography' => $validatedData['biography'] ?? null,
            'registration_type' => $validatedData['registration_type'] ?? null,
            'phone_number' => $validatedData['phone_number'] ?? null,
            'whatsapp_number' => $validatedData['whatsapp_number'] ?? null,
            'specialization' => $validatedData['specialization'] ?? null,
            'nationality' => $validatedData['nationality'] ?? null,
            'country_of_residence' => $validatedData['country_of_residence'] ?? null,
            'isAdmin' => $validatedData['isAdmin'],
            'company_name' => $validatedData['company_name'] ?? null,
            'contact_person' => $validatedData['contact_person'] ?? null,
            'company_address' => $validatedData['company_address'] ?? null,
            'conference_id' => $conference_id ?? null,
        ]));

        // التحقق من البريد الإلكتروني وجعله "مؤكد" (verified) في الباكيند
        $user->email_verified_at = now();  // تعيين الوقت الحالي في حقل email_verified_at
        $user->save();  // حفظ التحديث في قاعدة البيانات

        // إضافة المستخدم إلى جدول conference_user
        $user->conferences()->attach($conference_id);

        // إرسال الإشعار لجميع المدراء
        $admins = User::where('isAdmin', true)->get();
        foreach ($admins as $admin) {
            // إنشاء الإشعار
            $notification = Notification::create([
                'user_id' => $admin->id,
                'register_id' => $user->id,
                'conference_id' => $conference_id,
                'message' => 'New speaker registration: ' . $user->name,
                'is_read' => false,
            ]);

            // بث الإشعار
            broadcast(new NotificationSent($notification))->toOthers();
        }

        $userNotification = Notification::create([
            'user_id' => $user->id,
            'register_id' => $user->id,
            'conference_id' => $conference_id,
            'message' => 'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',
            'is_read' => false,
        ]);

        // بث الإشعار للمستخدم الجديد
        broadcast(new NotificationSent($userNotification));
        $user->notify(new EmailNotification('Thank you for registering for the conference. Your profile will be reviewed shortly.'));

        return response()->json([
            'message' => 'User created, added to conference, and notifications sent successfully!',
            "id" => $conference_id
        ], 201);

    } catch (\Exception $e) {
        return response()->json([
            'message' => 'Failed to create user.',
            'error' => $e->getMessage()
        ], 500);
    }
}


    public function getUserById()
    {
        try {
            // الحصول على user_id من التوكن
            $user_id = Auth::id();

            // التحقق من وجود user_id
            if (!$user_id) {
                return response()->json(['message' => 'user id not found'], 401);
            }

            // جلب المستخدم مع المؤتمرات المرتبطة به التي تنتهي بعد الآن
            $user = User::with([
                'conferences' => function ($query) {
                    $query->where('end_date', '>', now());
                }
            ])->find($user_id);

            // التحقق من وجود المستخدم
            if (!$user) {
                return response()->json(['message' => 'User not found.'], 404);
            }

            return response()->json([
                'user' => $user,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve user.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function updateStatus(Request $request, $id)
    {
        try {
            $validatedData = $request->validate([
                'status' => 'required|in:approved,rejected',
            ]);

            $user = User::find($id);

            if (!$user) {
                return response()->json(['message' => 'User not found.'], 404);
            }

            // تحديث حالة المستخدم
            $user->status = $validatedData['status'];
            $user->save();

            // إعداد رسالة الإشعار بناءً على الحالة
            $message = $validatedData['status'] === 'approved'
                ? 'Your application has been approved.'
                : 'Your application has been rejected.';

            // إرسال الإشعار إلى المستخدم
            $userNotification = Notification::create([
                'user_id' => $user->id, // المتحدث نفسه
                'message' => $message,
                'is_read' => false,
                'register_id' => null, // بقاء register_id فارغة
            ]);
            broadcast(new NotificationSent($userNotification));
            return response()->json([
                'message' => 'User status updated successfully and notification sent!',
                'status' => $user->status,
            ], 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'message' => 'Validation error.',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update status.',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getAllUsers(Request $request)
    {
        try {
            $status = $request->input('status');

            $query = User::with([
                'conferences' => function ($query) {
                    $query->where('end_date', '>', now());
                }
            ]);

            if ($status && $status !== 'all') {
                $query->where('status', $status);
            }

            $users = $query->paginate(10);

            return response()->json([
                'message' => 'Users retrieved successfully!',
                'data' => $users->items(),
                'pagination' => [
                    'total' => $users->total(),
                    'per_page' => $users->perPage(),
                    'current_page' => $users->currentPage(),
                    'total_pages' => $users->lastPage(),
                ],
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve users.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }



}


