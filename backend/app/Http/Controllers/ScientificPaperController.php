<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Notification;
use App\Models\Paper;
use App\Models\User;
use App\Notifications\EmailNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;


class PaperController extends Controller
{

    public function store(Request $request)
    {
        // 1. التحقق من صحة البيانات
        $validatedData = $request->validate([
            'conference_id' => 'required|exists:conferences,id',
            'title' => 'required|string|max:255',
            'file_path' => 'required|file|mimes:pdf,doc,docx|max:10240', // 10MB كحد أقصى للملف
            'abstract' => 'required|file|mimes:pdf,doc,docx|max:10240', // 10MB كحد أقصى للملف
            // 'user_id' => 'required|exists:users,id',

            'status' => 'required|in:under review,accepted,rejected',
            'submitted_at' => 'nullable|date',
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:8',
            'phone_number' => 'required|string|max:20',
            'whatsapp_number' => 'nullable|string|max:20',
            'nationality' => 'nullable|string|max:100',
            'country_of_residence' => 'nullable|string|max:100',
        ]);

        // 2. تخزين البيانات في جدول `users` (تعيين isAdmin إلى false و registration_type إلى speaker)
        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
            'registration_type' => 'speaker', // تعيين registration_type إلى speaker
            'phone_number' => $validatedData['phone_number'],
            'whatsapp_number' => $validatedData['whatsapp_number'],
            'nationality' => $validatedData['nationality'],
            'country_of_residence' => $validatedData['country_of_residence'],
            'isAdmin' => false, // تعيين isAdmin إلى false
        ]);

        // 3. تخزين البيانات في جدول `papers` مع user_id من جدول users الذي تم إنشاؤه للتو
        $paper = Paper::create([
            'conference_id' => $validatedData['conference_id'],
            'user_id' => $user->id, // استخدام الـ user_id الذي تم إنشاؤه تلقائيًا
            'title' => $validatedData['title'],
            'abstract' => $validatedData['abstract'],
            'file_path' => $validatedData['file_path'],
            'status' => $validatedData['status'],
            'submitted_at' => $validatedData['submitted_at'],
        ]);

        // 4. إرسال إشعار للمسؤولين (admins)
        $admins = User::where('isAdmin', true)->get();
        foreach ($admins as $admin) {
            $notification = Notification::create([
                'user_id' => $admin->id,
                'conference_id' => $validatedData['conference_id'],
                'message' => 'A new submission has been added by ' . $user->name . ' for conference ID: ' . $validatedData['conference_id'] . '. Would you like to update the status?',
                'is_read' => false,
                'register_id' => $user->id,
            ]);
            broadcast(new NotificationSent($notification))->toOthers(); // بث الإشعار إلى الآخرين
        }

        // 5. إرسال إشعار للمستخدم
        $userNotification = Notification::create([
            'user_id' => $user->id,
            'message' => "Your abstract is currently under review by the congress scientific committee. You can log in to your profile at any time to check its status.",
            'is_read' => false,
            'register_id' => null,
        ]);
        broadcast(new NotificationSent($userNotification)); // بث الإشعار للمستخدم

        // 6. إرسال إشعار عبر البريد الإلكتروني
        try {
            Notification::route('mail', $user->email)->notify(new EmailNotification("Your abstract is currently under review by the congress scientific committee. You can log in to your profile at any time to check its status."));
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Abstract registration updated successfully, but email notification failed to send.',
                'error' => $e->getMessage(),
            ], 200);
        }

        // 7. إرجاع استجابة ناجحة
        return response()->json([
            'message' => 'Paper and user created successfully, and notifications sent.',
            'paper' => $paper,
            'user' => $user,
        ], 201);
    }







}
