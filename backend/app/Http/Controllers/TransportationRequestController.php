<?php

namespace App\Http\Controllers;

use App\Models\TransportationRequest;
use App\Notifications\EmailNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;

class TransportationRequestController extends Controller
{
  
    
    public function store(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'whatsapp' => 'required|string|max:255',
            'passengers' => 'required|integer|min:1',
            'pickup_option' => 'required|in:pickup,drop_off,both',
            'flight_code' => 'required|string|max:255',
            'flight_time' => 'required|string|max:255',
            'total_usd' => 'required|numeric|min:0',
        ]);
    
        // تخزين البيانات في قاعدة البيانات
        $data = TransportationRequest::create($request->all());
    
        // تحضير البيانات لتمريرها كرسالة
        $message = "A new transportation request has been submitted:\n";
        $message .= "First Name: " . $data->first_name . "\n";
        $message .= "Last Name: " . $data->last_name . "\n";
        $message .= "Email: " . $data->email . "\n";
        $message .= "WhatsApp: " . $data->whatsapp . "\n";
        $message .= "Passengers: " . $data->passengers . "\n";
        $message .= "Pickup/Drop off: " . $data->pickup_option . "\n";
        $message .= "Flight Code: " . $data->flight_code . "\n";
        $message .= "Flight Time: " . $data->flight_time . "\n";
        $message .= "Total USD: " . $data->total_usd . "\n";
        $message .= "Additional Info: " . $data->additional_info . "\n";
    
        // إرسال الإشعار عبر البريد الإلكتروني
        Notification::route('mail', 'ayatalmomani655@gmail.com')
                    ->notify(new EmailNotification($message));
    
        return response()->json(['message' => 'Request submitted successfully!', 'data' => $data], 201);
    }
    

}
