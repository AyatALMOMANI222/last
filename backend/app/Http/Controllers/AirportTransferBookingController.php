<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\AirportTransferBooking;
use App\Models\AirportTransferInvoice;
use App\Models\AirportTransferPrice;
use App\Models\Attendance;
use App\Models\ConferenceUser;
use App\Models\Notification;
use App\Models\Speaker;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AirportTransferBookingController extends Controller
{
 

    public function store(Request $request)
    {
        $request->validate([
            'trip_type' => 'required|string',
            'arrival_date' => 'required|date',
            'arrival_time' => 'required|date_format:H:i',
            'departure_date' => 'nullable|date',
            'departure_time' => 'nullable|date_format:H:i',
            'flight_number' => 'required|string',
            'companion_name' => 'nullable|string',
            'driver_name' => 'nullable|string',
            'driver_phone' => 'nullable|string',
        ]);
    
        // Get the user ID from the token
        $userId = Auth::id();
    
        // Find conferences the user is attending that haven't started or are ongoing
        $conferences = ConferenceUser::with('conference')
            ->where('user_id', $userId)
            ->whereHas('conference', function ($query) {
                $today = now()->toDateString();
                $query->where('start_date', '>=', $today)
                      ->orWhere(function ($query) use ($today) {
                          $query->where('start_date', '<=', $today)
                                ->where('end_date', '>=', $today);
                      });
            })
            ->get();
    
        // Check if there are available conferences
        if ($conferences->isEmpty()) {
            return response()->json(['message' => 'No available conferences for transfer booking.'], 404);
        }
    
        // Select the first conference as an example
        $conferenceId = $conferences->first()->conference_id;
    
        // Retrieve airport transfer prices for the conference
        $airportTransferPrices = AirportTransferPrice::where('conference_id', $conferenceId)->first();
    
        if (!$airportTransferPrices) {
            return response()->json([
                'message' => 'No airport transfer prices found for the selected conference.',
            ], 404);
        }
    
        // Calculate invoice based on trip type
        $invoice = 0;
        switch ($request->trip_type) {
            case 'One-way trip from the airport to the hotel':
                $invoice = $airportTransferPrices->from_airport_price;
                break;
            case 'One-way trip from the hotel to the airport':
                $invoice = $airportTransferPrices->to_airport_price;
                break;
            case 'Round trip':
                $invoice = $airportTransferPrices->round_trip_price;
                break;
            default:
                return response()->json(['message' => 'Invalid trip type provided.'], 400);
        }
    
        // Create a new booking
        $booking = AirportTransferBooking::create([
            'trip_type' => $request->trip_type,
            'arrival_date' => $request->arrival_date,
            'arrival_time' => $request->arrival_time,
            'departure_date' => $request->departure_date,
            'departure_time' => $request->departure_time,
            'flight_number' => $request->flight_number,
            'companion_name' => $request->companion_name,
            'conference_id' => $conferenceId,
            'user_id' => $userId,
        ]);
    
        // Send notification to the user about the confirmation on WhatsApp
        $message = "It will be confirmed through a message sent to his WhatsApp, containing the driver's name and phone number.";
        $userNotification = Notification::create([
            'user_id' => $userId,
            'message' => $message,
            'is_read' => false,
            'register_id' => $userId,
        ]);
    
        broadcast(new NotificationSent($userNotification));
    
        // Create the airport transfer invoice with the calculated amount
        $airportTransferInvoice = AirportTransferInvoice::create([
            'airport_transfer_booking_id' => $booking->id,  // Foreign key
            'total_price' => $invoice,
            'status' => 'pending',
        ]);
    
        // Return response with booking, airport transfer prices, and invoice
        return response()->json([
            'booking' => $booking,
            'airport_transfer_prices' => $airportTransferPrices,
            'invoice' => $invoice,
        ], 201);
    }
    
    
    // public function index()
    // {
    //     try {
    //         // الحصول على معرف المستخدم من التوكن
    //         $userId = Auth::id();
    
    //         // استرجاع جميع الحجوزات الخاصة بالمستخدم
    //         $bookings = AirportTransferBooking::where('user_id', $userId)->get();
    
    //         // تحقق من وجود حجوزات
    //         if ($bookings->isEmpty()) {
    //             return response()->json(['message' => 'لا توجد حجوزات متاحة.'], 404);
    //         }
    
    //         // إضافة معلومات المتحدث أو الحضور لكل حجز
    //         foreach ($bookings as $booking) {
    //             // جلب معلومات المستخدم المرتبطة بالحجز
    //             $user = User::find($booking->user_id);
    
    //             // تحقق من نوع التسجيل للمستخدم
    //             if ($user->registration_type === 'speaker') {
    //                 $speaker = Speaker::where('user_id', $user->id)->first();
    //                 $booking->speaker = $speaker; // إضافة معلومات السبيكر
    //             } elseif ($user->registration_type === 'attendance') {
    //                 $attendance = Attendance::where('user_id', $user->id)->first();
    //                 $booking->attendance = $attendance; // إضافة معلومات الحضور
    //             }
    //         }
    
    //         return response()->json($bookings, 200);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => 'حدث خطأ: ' . $e->getMessage()], 500);
    //     }
    // }
    public function index()
{
    try {
        // الحصول على معرف المستخدم من التوكن
        $userId = Auth::id();

        // استرجاع جميع الحجوزات الخاصة بالمستخدم
        $bookings = AirportTransferBooking::where('user_id', $userId)->get();

        // تحقق من وجود حجوزات
        if ($bookings->isEmpty()) {
            return response()->json(['message' => 'لا توجد حجوزات متاحة.'], 404);
        }

        // إضافة معلومات المتحدث أو الحضور لكل حجز
        foreach ($bookings as $booking) {
            // جلب معلومات المستخدم المرتبطة بالحجز
            $user = User::find($booking->user_id);

            // تحقق من نوع التسجيل للمستخدم
            if ($user->registration_type === 'speaker') {
                $speaker = Speaker::where('user_id', $user->id)->first();
                $booking->speaker = $speaker; // إضافة معلومات السبيكر
            } elseif ($user->registration_type === 'attendance') {
                $attendance = Attendance::where('user_id', $user->id)->first();
                $booking->attendance = $attendance; // إضافة معلومات الحضور
            }

            // جلب الفاتورة المرتبطة بالحجز من جدول airport_transfers_invoices
            $invoice = AirportTransferInvoice::where('airport_transfer_booking_id', $booking->id)->first();
            if ($invoice) {
                $booking->invoice = $invoice; // إضافة بيانات الفاتورة
            }
        }

        return response()->json($bookings, 200);
    } catch (\Exception $e) {
        return response()->json(['message' => 'حدث خطأ: ' . $e->getMessage()], 500);
    }
}

    
    
    // دالة لاسترجاع جميع الحجوزات
public function getAllBooking()
{
    // استرجاع جميع الحجوزات
    $bookings = AirportTransferBooking::all();

    // تحقق من وجود حجوزات
    if ($bookings->isEmpty()) {
        return response()->json(['message' => 'لا توجد حجوزات متاحة.'], 404);
    }

    return response()->json($bookings, 200);
}
public function getBookingByConferenceId($conferenceId)
{
    try {
        // استرجاع الحجوزات بناءً على معرف المؤتمر
        $bookings = AirportTransferBooking::where('conference_id', $conferenceId)->get();

        // تحقق من وجود حجوزات
        if ($bookings->isEmpty()) {
            return response()->json(['message' => 'لا توجد حجوزات متاحة لهذا المؤتمر.'], 404);
        }

        return response()->json($bookings, 200);
    } catch (\Exception $e) {
        // رسالة الخطأ عند حدوث استثناء
        return response()->json(['message' => 'حدث خطأ أثناء استرجاع الحجوزات.'], 500);
    }
}


public function update(Request $request, $id)
{
    try {
        // التحقق من وجود الحجز
        $booking = AirportTransferBooking::find($id);

        if (!$booking) {
            return response()->json(['message' => 'حجز النقل غير موجود.'], 404);
        }

        // التحقق من صحة البيانات
        $request->validate([
            'trip_type' => 'nullable|string',
            'arrival_date' => 'nullable|date',
            'arrival_time' => 'nullable|date_format:H:i',
            'departure_date' => 'nullable|date',
            'departure_time' => 'nullable|date_format:H:i',
            'flight_number' => 'nullable|string',
            'companion_name' => 'nullable|string',
            'driver_name' => 'nullable|string',
            'driver_phone' => 'nullable|string',
        ]);

        // تحديث الحجز بالقيم الجديدة فقط
        $booking->fill($request->only([
            'trip_type',
            'arrival_date',
            'arrival_time',
            'departure_date',
            'departure_time',
            'flight_number',
            'companion_name',
            'driver_name',
            'driver_phone',
        ]));

        // حفظ التغييرات
        $booking->save();

        return response()->json($booking, 200);
    } catch (\Exception $e) {
        // إذا حدث خطأ، يتم إرجاع رسالة الخطأ
        return response()->json(['message' => 'حدث خطأ: ' . $e->getMessage()], 500);
    }
}

}
