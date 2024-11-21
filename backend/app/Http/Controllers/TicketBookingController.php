<?php

namespace App\Http\Controllers;

use App\Models\TicketBooking;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification; 
use App\Notifications\EmailNotification;

class TicketBookingController extends Controller


    
 {
    public function store(Request $request)
    {
        try {
            // التحقق من صحة البيانات (Validation)
            $request->validate([
                'title' => 'required|string|max:255',
                'first_name' => 'required|string|max:255',
                'last_name' => 'required|string|max:255',
                'nationality' => 'required|string|max:255',
                'email' => 'required|email|max:255',
                'cellular' => 'required|string|max:255',
                'whatsapp' => 'required|string|max:255',
                'departure_date' => 'required|date',
                'arrival_date' => 'required|date',
                'arrival_time' => 'required|string|max:255',
                'departure_time' => 'required|string|max:255',
                'preferred_airline' => 'required|string|max:255',
                'departure_from' => 'required|string|max:255',
                'passport_copy' => 'nullable|file|mimes:jpeg,png,pdf|max:2048',
            ]);

            // حفظ البيانات في قاعدة البيانات
            $ticketBooking = TicketBooking::create([
                'title' => $request->title,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'nationality' => $request->nationality,
                'email' => $request->email,
                'cellular' => $request->cellular,
                'whatsapp' => $request->whatsapp,
                'departure_date' => $request->departure_date,
                'arrival_date' => $request->arrival_date,
                'arrival_time' => $request->arrival_time,
                'departure_time' => $request->departure_time,
                'preferred_airline' => $request->preferred_airline,
                'departure_from' => $request->departure_from,
                'passport_copy' => $request->file('passport_copy') ? $request->file('passport_copy')->store('passports', 'public') : null,
            ]);

            // إعداد محتوى الرسالة للإرسال باستخدام HTML
            $message = "<p>A new ticket booking request has been submitted:</p>";
            $message .= "<p><strong>Title:</strong> " . $ticketBooking->title . "</p>";
            $message .= "<p><strong>First Name:</strong> " . $ticketBooking->first_name . "</p>";
            $message .= "<p><strong>Last Name:</strong> " . $ticketBooking->last_name . "</p>";
            $message .= "<p><strong>Email:</strong> " . $ticketBooking->email . "</p>";
            $message .= "<p><strong>Cellular:</strong> " . $ticketBooking->cellular . "</p>";
            $message .= "<p><strong>Whatsapp:</strong> " . $ticketBooking->whatsapp . "</p>";
            $message .= "<p><strong>Departure Date:</strong> " . $ticketBooking->departure_date . "</p>";
            $message .= "<p><strong>Arrival Date:</strong> " . $ticketBooking->arrival_date . "</p>";
            $message .= "<p><strong>Preferred Airline:</strong> " . $ticketBooking->preferred_airline . "</p>";
            $message .= "<p><strong>Departure From:</strong> " . $ticketBooking->departure_from . "</p>";

            if ($ticketBooking->passport_copy) {
                $message .= "<p><strong>Passport Copy:</strong> <a href='" . storage_path('app/public/' . $ticketBooking->passport_copy) . "'>View Passport Copy</a></p>";
            }
            // إرسال الإشعار عبر البريد الإلكتروني باستخدام Notification
            Notification::route('mail', 'ayatalmomani655@gmail.com')
                        ->notify(new EmailNotification($message)); // إرسال الإشعار مع الرسالة

            // الرد على العميل بنجاح
            return response()->json(['message' => 'Request submitted successfully!', 'data' => $ticketBooking], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            // إذا حدث خطأ في التحقق من البيانات، إرسال رسالة بأخطاء التحقق
            return response()->json(['message' => 'Validation errors occurred', 'errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            // إذا حدث خطأ عام، إرسال رسالة الخطأ
            return response()->json(['message' => 'Error occurred: ' . $e->getMessage()], 500);
        }
    }
}

    
    
    
    

