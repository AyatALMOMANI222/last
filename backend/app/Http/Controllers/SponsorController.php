<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Notification;
use App\Models\Sponsor;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;


    

    class SponsorController extends Controller
    {
        public function store(Request $request)
        {
            try {
                // التحقق من صحة البيانات المرسلة
                $validatedData = $request->validate([
                    'phone_number' => 'nullable|string|max:255',
                    'whatsapp_number' => 'nullable|string|max:255',
                    'email' => 'required|email|unique:users,email', // تأكد من أن البريد الإلكتروني فريد
                    // 'conference_id' => 'required|exists:conferences,id',
                    'company_name' => 'required|string|max:255',
                    'contact_person' => 'required|string|max:255',
                    'company_address' => 'required|string|max:255',
                ]);
        
                // إنشاء مستخدم جديد
                $user = User::create([
                    'phone_number' => $validatedData['phone_number'],
                    'whatsapp_number' => $validatedData['whatsapp_number'],
                    'email' => $validatedData['email'],
                    // 'conference_id' => $validatedData['conference_id'],
                ]);
        
                // إنشاء Sponsor وربطه بالمستخدم
                $sponsor = new Sponsor([
                    'company_name' => $validatedData['company_name'],
                    'contact_person' => $validatedData['contact_person'],
                    'company_address' => $validatedData['company_address'],
                ]);
        
                // ربط Sponsor بالمستخدم وحفظ البيانات
                $user->sponsors()->save($sponsor);
        
                // إرسال إشعار إلى المستخدم
                $userNotification = Notification::create([
                    'user_id' => $user->id,
                    'message' => 'You will be contacted directly by the organizing company via email.',
                    'is_read' => false,
                ]);
                broadcast(new NotificationSent($userNotification));
                // **إضافة إشعار لجميع المدراء**
                $admins = User::where('isAdmin', true)->get();
                foreach ($admins as $admin) {
                 $notification = Notification::create([
                        'user_id' => $admin->id,
                        'register_id' => $user->id,
                        // 'conference_id' => $validatedData['conference_id'],
                        'message' => 'New sponsor registration: ' . $user->email, // يمكنك تعديل هذه الرسالة حسب الحاجة
                        'is_read' => false,
                    ]);
                    broadcast(new NotificationSent($notification))->toOthers();
                }
        
                return response()->json(['message' => 'User and Sponsor created successfully!', 'sponsor' => $sponsor], 201);
            } catch (ValidationException $e) {
                // رسالة الخطأ الخاصة بالتحقق
                return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
            } catch (\Exception $e) {
                // رسالة الخطأ العامة
                return response()->json(['message' => 'Something went wrong: ' . $e->getMessage()], 500);
            }
        }
        
        
    }
    
