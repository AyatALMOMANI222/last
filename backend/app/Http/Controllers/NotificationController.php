<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Notification;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;



class NotificationController extends Controller
{
   

    
    public function sendNotification(Request $request)
    {
        try {
            // التحقق من البيانات
            $validated = $request->validate([
                'user_id' => 'required|exists:users,id', // تحقق من وجود المستخدم
                'message' => 'required|string',
            ]);
    
            // إدخال الإشعار مباشرة إلى قاعدة البيانات
            Notification::create([
                'user_id' => $validated['user_id'],
                'message' => $validated['message'],
                'is_read' => false, // يمكن تحديد حالة القراءة إذا لزم الأمر
            ]);
    
            return response()->json(['status' => 'Notification stored successfully!']);
        } catch (\Exception $e) {
            
            return response()->json(['error' => 'Failed to store notification. Please try again.'], 500);
        }
    }
    


    



    public function getAllNotificationsByAuthenticatedUser()
    {
        // الحصول على معرف المستخدم من التوكن
        $userId = Auth::id();
    
        // التحقق من وجود المستخدم
        if (!$userId) {
            return response()->json(['message' => 'User not authenticated.'], 401);
        }
    
        // الحصول على إشعارات المستخدم
        $notifications = Notification::where('user_id', $userId)->get();
    
        // التحقق من وجود إشعارات
        if ($notifications->isEmpty()) {
            return response()->json(['message' => 'No notifications found for this user.'], 404);
        }
    
        return response()->json([
            'message' => 'Notifications retrieved successfully!',
            'data' => $notifications
        ], 200);
    }
    


    
    
    
    

}
