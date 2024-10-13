<?php

namespace App\Http\Controllers;

use App\Models\AirportTransferBooking;
use App\Models\ConferenceUser;
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

    // الحصول على معرف المستخدم من التوكن
    $userId = Auth::id();

    // البحث عن المؤتمرات التي يشارك بها المستخدم والتي لم تبدأ ولم تنتهِ بعد
    $conferences = ConferenceUser::with('conference')
        ->where('user_id', $userId)
        ->whereHas('conference', function ($query) {
            $today = now()->toDateString(); // التاريخ الحالي
            $query->where('start_date', '>=', $today) // المؤتمر لم يبدأ بعد
                  ->orWhere(function ($query) use ($today) {
                      $query->where('start_date', '<=', $today)
                            ->where('end_date', '>=', $today); // المؤتمر قيد التنفيذ
                  });
        })
        ->get();

    // تحقق من وجود مؤتمر
    if ($conferences->isEmpty()) {
        return response()->json(['message' => 'لا توجد مؤتمرات متاحة لحجز النقل.'], 404);
    }

    // يمكنك اختيار أول مؤتمر أو أي مؤتمر تريده، هنا نختار أول مؤتمر كمثال
    $conferenceId = $conferences->first()->conference_id;

    // إنشاء حجز جديد
    $booking = AirportTransferBooking::create([
        'trip_type' => $request->trip_type,
        'arrival_date' => $request->arrival_date,
        'arrival_time' => $request->arrival_time,
        'departure_date' => $request->departure_date,
        'departure_time' => $request->departure_time,
        'flight_number' => $request->flight_number,
        'companion_name' => $request->companion_name,
        'driver_name' => $request->driver_name,
        'driver_phone' => $request->driver_phone,
        'conference_id' => $conferenceId,
        'user_id' => $userId,
    ]);

    return response()->json($booking, 201);
}
public function index()
    {
        // الحصول على معرف المستخدم من التوكن
        $userId = Auth::id();

        // استرجاع جميع الحجوزات الخاصة بالمستخدم
        $bookings = AirportTransferBooking::where('user_id', $userId)->get();

        // تحقق من وجود حجوزات
        if ($bookings->isEmpty()) {
            return response()->json(['message' => 'لا توجد حجوزات متاحة.'], 404);
        }

        return response()->json($bookings, 200);
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
