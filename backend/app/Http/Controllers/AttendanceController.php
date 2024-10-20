<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\User;
use App\Models\Conference;
use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class AttendanceController extends Controller
{
    public function storeAttendance(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'name' => 'nullable|string|max:255',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:8',
                'phone_number' => 'nullable|string|max:255',
                'whatsapp_number' => 'nullable|string|max:255',
                'specialization' => 'nullable|string|max:255',
                'nationality' => 'nullable|string|max:255',
                'country_of_residence' => 'nullable|string|max:255',
                'conference_id' => 'required|exists:conferences,id', 
            ]);
    
            // إنشاء المستخدم الجديد
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => bcrypt($validatedData['password']),
                'phone_number' => $validatedData['phone_number'],
                'whatsapp_number' => $validatedData['whatsapp_number'],
                'specialization' => $validatedData['specialization'],
                'nationality' => $validatedData['nationality'],
                'country_of_residence' => $validatedData['country_of_residence'],
            ]);
    
            DB::table('attendance')->insert([
                'user_id' => $user->id, // ربط المستخدم الجديد
                'conference_id' => $validatedData['conference_id'], // تمرير conference_id
            ]);
    
            // إنشاء رسالة الإشعار للمستخدم
            $message = "We are pleased to inform you that you have been successfully registered, and your profile is now active on the website. You can log in to it now.";
    
            // إرسال الإشعار إلى المستخدم
            Notification::create([
                'user_id' => $user->id, // المتحدث نفسه
                'message' => $message,
                'is_read' => false,
                'register_id' => null, // بقاء register_id فارغة
            ]);
    
            // // إرسال الإشعار إلى جميع المدراء
            // $admins = User::where('isAdmin', true)->get();
            // foreach ($admins as $admin) {
            //     Notification::create([
            //         'user_id' => $admin->id,
            //         'register_id' => $user->id, // تسجيل ID المستخدم الجديد
            //         'conference_id' => $validatedData['conference_id'], // تسجيل conference_id
            //         'message' => 'New Attendance registration: ' . $user->name, // الرسالة الموجهة للمدراء
            //         'is_read' => false,
            //     ]);
            // }
    
            return response()->json([
                'message' => 'User created, attendance recorded, and notifications sent to user and admins successfully!',
                'user_id' => $user->id, // إرجاع user_id
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create user, record attendance, or send notifications.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    
    
    
}
