<?php

namespace App\Http\Controllers;

use App\Models\TravelForm;
use App\Notifications\EmailNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;

class TravelFormController extends Controller
{
 
    
    public function store(Request $request)
    {
        // التحقق من صحة المدخلات
        $request->validate([
            'title' => 'required',
            'firstName' => 'required',
            'lastName' => 'required',
            'email' => 'required|email',
            'nationality' => 'required',
            'cellular' => 'required',
            'whatsapp' => 'required',
            'arrivalDate' => 'required|date',
            'departureDate' => 'required|date',
            'hotelCategory' => 'required',
            'hotelName' => 'required',
            'accompanyingPersons' => 'required|integer',
            'totalUSD' => 'required|numeric',
            'roomType' => 'required',
        ]);
    
        // إنشاء السجل في قاعدة البيانات
        $travelForm = TravelForm::create($request->all());
    
        // رسالة البريد الإلكتروني
        $message = "New Travel Form Submission:\n\n" .
                   "Title: {$travelForm->title}\n" .
                   "First Name: {$travelForm->firstName}\n" .
                   "Last Name: {$travelForm->lastName}\n" .
                   "Email: {$travelForm->email}\n" .
                   "Nationality: {$travelForm->nationality}\n" .
                   "Cellular: {$travelForm->cellular}\n" .
                   "WhatsApp: {$travelForm->whatsapp}\n" .
                   "Arrival Date: {$travelForm->arrivalDate}\n" .
                   "Departure Date: {$travelForm->departureDate}\n" .
                   "Hotel Category: {$travelForm->hotelCategory}\n" .
                   "Hotel Name: {$travelForm->hotelName}\n" .
                   "Accompanying Persons: {$travelForm->accompanyingPersons}\n" .
                   "Total in USD: {$travelForm->totalUSD}\n" .
                   "Room Type: {$travelForm->roomType}";
    
        // إرسال الإشعار عبر البريد الإلكتروني
        Notification::route('mail', 'ayatalmomani655@gmail.com')
                    ->notify(new EmailNotification($message));
    
        // إرجاع استجابة JSON تحتوي على البيانات التي تم إدخالها والرسالة
        return response()->json([
            'message' => 'Travel form created successfully and email sent.',
            'data' => $travelForm
        ], 201); // 201 تعني أنه تم إنشاء السجل بنجاح
    }
    

}
