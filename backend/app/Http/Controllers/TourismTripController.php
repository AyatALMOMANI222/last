<?php

namespace App\Http\Controllers;

use App\Models\TourismTrip;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmailNotification;
class TourismTripController extends Controller
{


    
    public function create(Request $request)
    {
        try {
            // التحقق من البيانات المدخلة
            $validatedData = $request->validate([
                'title' => 'required|string',
                'firstname' => 'required|string',
                'lastname' => 'required|string',
                'emailaddress' => 'required|email',
                'phonenumber' => 'required|string',
                'nationality' => 'required|string',
                'country' => 'required|string',
                'arrivalPoint' => 'required|string',
                'departurePoint' => 'required|string',
                'arrivalDate' => 'required|date',
                'departureDate' => 'required|date',
                'arrivalTime' => 'required|date_format:H:i',
                'departureTime' => 'required|date_format:H:i',
                'preferredHotel' => 'nullable|string',
                'duration' => 'required|integer',
                'adults' => 'required|integer',
                'children' => 'required|integer',
                'preferredDestination' => 'required|array',
                'activities' => 'required|array',
            ]);
    
            // إنشاء الرحلة السياحية
            $tourismTrip = TourismTrip::create($validatedData);
    
            // إرسال البريد الإلكتروني باستخدام Notification
            $message = "A new tourism trip has been created:\n" . print_r($validatedData, true);
    
            // إرسال الإشعار عبر البريد الإلكتروني
            Notification::route('mail', 'ayatalmomani655@gmail.com')
                ->notify(new EmailNotification($message));
    
            // إرجاع استجابة بالنجاح
            return response()->json([
                'message' => 'Tourism trip created successfully, and email notification sent!',
                'trip' => $tourismTrip
            ], 201);
        } catch (ValidationException $e) {
            // في حال كانت البيانات المدخلة غير صالحة، أرسل رسالة خطأ
            return response()->json([
                'error' => 'Validation failed!',
                'message' => $e->errors() // عرض تفاصيل الأخطاء
            ], 422);
        } catch (\Exception $e) {
            // في حال حدوث أي خطأ آخر غير متوقع
            return response()->json([
                'error' => 'An unexpected error occurred.',
                'message' => $e->getMessage() // عرض تفاصيل الخطأ
            ], 500);
        }
    }
    
}
