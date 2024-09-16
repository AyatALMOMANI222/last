<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Twilio\Rest\Client;

class WhatsAppController extends Controller
{
    public function sendWhatsAppNotification(Request $request)
    {
        // الحصول على معلومات Twilio من ملف البيئة
        $sid = env('TWILIO_SID');
        $token = env('TWILIO_TOKEN');
        $twilioNumber = env('TWILIO_WHATSAPP_FROM');

        // التحقق من وجود القيم
        if (empty($sid) || empty($token) || empty($twilioNumber)) {
            return response()->json(['message' => 'Twilio credentials are not properly configured.'], 500);
        }

        $client = new Client($sid, $token);

        // بيانات الرسالة
        $to = 'whatsapp:' . $request->input('to'); // رقم الهاتف المستلم بصيغة WhatsApp
        $message = $request->input('message'); // نص الرسالة

        try {
            $client->messages->create(
                $to,
                [
                    'from' => $twilioNumber,
                    'body' => $message,
                ]
            );

            return response()->json(['message' => 'WhatsApp notification sent successfully!']);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to send notification.', 'error' => $e->getMessage()], 500);
        }
    }
}
