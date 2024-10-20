<?php

namespace App\Http\Controllers;

use App\Models\Conference;
use App\Models\Notification;
use App\Models\User;
use Illuminate\Http\Request;

use function Laravel\Prompts\error;

class UserController extends Controller
{


    public function store(Request $request, $conference_id)
    {
        try {
            // تحقق من صحة البيانات
            $validatedData = $request->validate([
                'name' => 'nullable|string|max:255',
                'email' => 'required|email|unique:users,email',
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
            ]);
    
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
            ]));
    
            // إضافة المستخدم إلى جدول conference_user
            $user->conferences()->attach($conference_id);
    
            // إرسال الإشعار لجميع المدراء
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'conference_id' => $conference_id,
                    'message' => 'New speaker registration: ' . $user->name,
                    'is_read' => false,
                ]);
            }
    
            // إرسال الإشعار للمستخدم الجديد
            Notification::create([
                'user_id' => $user->id,
                'register_id' => $user->id,
                'conference_id' => $conference_id,
                'message' => 'When the admin approves your addition as a speaker for this conference, you will be notified via email and an activation code will be sent for your profile on the website.',
                'is_read' => false,
            ]);
    
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
            Notification::create([
                'user_id' => $user->id, // المتحدث نفسه
                'message' => $message,
                'is_read' => false,
                'register_id' => null, // بقاء register_id فارغة
            ]);

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

    public function getAllUsers()
    {
        try {
            // استرجاع جميع المستخدمين من قاعدة البيانات
            $users = User::all();

            // إرجاع استجابة JSON
            return response()->json([
                'message' => 'Users retrieved successfully!',
                'data' => $users,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve users.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
