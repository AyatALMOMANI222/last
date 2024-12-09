<?php

namespace App\Http\Controllers;

use App\Models\Message;
use Illuminate\Http\Request;

class MessageController extends Controller
{
    public function store(Request $request)
    {
        // التحقق من البيانات المدخلة
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'subject' => 'required|string|max:255',
            'message' => 'required|string',
        ]);
    
        try {
            // تخزين الرسالة في قاعدة البيانات
            $message = Message::create($validatedData);
                // إرسال الإشعار لجميع المدراء
                $admins = User::where('isAdmin', true)->get();
                foreach ($admins as $admin) {
                    // إنشاء الإشعار
                    $notification = Notification::create([
                        'user_id' => $admin->id,
                        // 'register_id' => $user->id,
                        'message' =>"You have received a new message",
                        'is_read' => false,
                    ]);
    
                    // بث الإشعار
                    // broadcast(new NotificationSent($notification))->toOthers();
    
                }
            // إرجاع استجابة بنجاح
            return response()->json(['message' => 'Message sent successfully!'], 200);
        } catch (\Exception $e) {
            // في حال حدوث خطأ، سيتم إرجاع تفاصيل الخطأ
            return response()->json([
                'error' => 'There was an error while sending the message.',
                'details' => $e->getMessage()
            ], 500);
        }
    }
    public function getAllMsg()
{
    try {
        // جلب جميع الرسائل من قاعدة البيانات
        $messages = Message::all();

        // إرجاع استجابة تحتوي على الرسائل
        return response()->json(['messages' => $messages], 200);
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'There was an error while fetching the messages.',
            'details' => $e->getMessage()
        ], 500);
    }
}

    
}
