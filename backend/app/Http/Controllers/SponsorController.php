<?php

namespace App\Http\Controllers;

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
                    'user_id' => 'required|exists:users,id', // التأكد من وجود user_id
                    'company_name' => 'required|string|max:255',
                    'contact_person' => 'required|string|max:255',
                    'company_address' => 'required|string|max:255',
                ]);
        
                // العثور على المستخدم باستخدام الـ user_id
                $user = User::findOrFail($validatedData['user_id']);
        
                // إنشاء Sponsor جديد وربطه بالمستخدم
                $sponsor = new Sponsor([
                    'company_name' => $validatedData['company_name'],
                    'contact_person' => $validatedData['contact_person'],
                    'company_address' => $validatedData['company_address'],
                ]);
        
                // ربط sponsor بالمستخدم وحفظ البيانات
                $user->sponsors()->save($sponsor);
        
                // إرسال إشعار إلى المستخدم
                Notification::create([
                    'user_id' => $validatedData['user_id'],
                    'message' => 'You will be notified via email after your request is accepted to download the registered names. These names must be in English and in an Excel file format.',
                    'is_read' => false, // يمكنك تعيين القيمة حسب الحاجة
                ]);
        
                return response()->json(['message' => 'Sponsor created successfully!', 'sponsor' => $sponsor], 201);
            } catch (ValidationException $e) {
                // رسالة الخطأ الخاصة بالتحقق
                return response()->json(['message' => 'Validation Error', 'errors' => $e->validator->errors()], 422);
            } catch (\Exception $e) {
                // رسالة الخطأ العامة
                return response()->json(['message' => 'Something went wrong: ' . $e->getMessage()], 500);
            }
        }
    }
    
