<?php

namespace App\Http\Controllers;

use App\Models\GroupRegistration;
use App\Models\Notification;
use App\Models\User;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class GroupRegistrationController extends Controller
{

    public function store(Request $request)
    {
        try {
            // التحقق من البيانات المدخلة
            $validatedData = $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'phone' => 'nullable|string|max:15',
                'contact_person' => 'nullable|string|max:255',
                'number_of_doctors' => 'nullable|integer|min:0',
                'conference_id' => 'required|exists:conferences,id', // إضافة conference_id
                'password' => 'required|string|min:8', // تحقق من كلمة المرور
            ]);
    
            // إنشاء المستخدم الجديد
            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'phone' => $validatedData['phone'],
                'password' => bcrypt($validatedData['password']), // استخدام كلمة المرور المدخلة
            ]);
    
            // تخزين معلومات التسجيل في جدول group_registrations مع conference_id
            $groupRegistration = GroupRegistration::create([
                'user_id' => $user->id,
                'contact_person' => $validatedData['contact_person'],
                'number_of_doctors' => $validatedData['number_of_doctors'],
                'conference_id' => $validatedData['conference_id'], // إضافة conference_id
            ]);
    
            // إنشاء إشعار للمستخدم
            Notification::create([
                'user_id' => $user->id,
                'message' => 'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',
                'conference_id' => $validatedData['conference_id'], // استخدام conference_id للإشعار
                'is_read' => false,
            ]);
    
            // إرسال إشعار لجميع المدراء
            $admins = User::where('isAdmin', true)->get();
            foreach ($admins as $admin) {
                Notification::create([
                    'user_id' => $admin->id,
                    'register_id' => $user->id,
                    'message' => 'New group registration: ' . $user->email,
                    'is_read' => false,
                ]);
            }
    
            return response()->json(['message' => 'User and registration created successfully.'], 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
    



    public function updateGroupByAdminByUserId(Request $request)
    {
        // تحقق من صحة المدخلات
        $request->validate([
            'user_id' => 'required|exists:users,id', // تحقق من وجود المستخدم
            'is_active' => 'required|boolean',
            'update_deadline' => 'nullable|date',
        ]);
    
        try {
            // تحديث حالة التسجيل
            $groupRegistration = GroupRegistration::where('user_id', $request->user_id)->firstOrFail();
            $groupRegistration->is_active = $request->is_active;
            $groupRegistration->update_deadline = $request->update_deadline;
            $groupRegistration->save();
    
            // إذا أصبحت الحالة نشطة، أرسل إشعاراً للمستخدم
            if ($groupRegistration->is_active) {
                $message = "Now you can access the activated file and download the registered names.";
    
                Notification::create([
                    'user_id' => $request->user_id,
                    'message' => $message,
                    'is_read' => false,
                    'register_id' => null,
                ]);
            }
    
            return response()->json([
                'message' => 'Group registration updated successfully.',
                'user_id' => $request->user_id,
            ], 200);
    
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update group registration.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }


    public function updateByUser(Request $request, $userId)
    {
        // تحقق من صحة المدخلات
        $request->validate([
            'excel_file' => 'required|file|mimes:xlsx,csv,xls', // تحقق من صحة ملف إكسل
        ]);
    
        try {
            // ابحث عن تسجيل المجموعة الخاص بالمستخدم
            $groupRegistration = GroupRegistration::where('user_id', $userId)
                // تأكد من وجود علاقة مع جدول ملفات إكسل
                ->firstOrFail();
    
            // تحقق من أن update_deadline لم تتجاوز الوقت الحالي
            if ($groupRegistration->update_deadline && now()->greaterThan($groupRegistration->update_deadline)) {
                return response()->json([
                    'message' => 'Update deadline has passed. You cannot update the excel file.',
                ], 403);
            }
    
            // تخزين ملف الإكسل
            // استخدم public لتخزين الملفات
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
    
    

}




