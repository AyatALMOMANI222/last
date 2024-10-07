<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Models\Reservation;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RoomController extends Controller
{
  

public function store(Request $request)
{
    try {
        // تحقق من وجود الحجز للمستخدم
        $user_id = Auth::id();
        $reservation = Reservation::where('user_id', $user_id)->first();

        if (!$reservation) {
            return response()->json([
                'error' => 'No reservation found for the user.'
            ], 404);
        }

        // التحقق من المدخلات
        $request->validate([
            'room_type' => 'required|in:Single,Double,Triple',
            'occupant_name' => 'nullable|string',
            'special_requests' => 'nullable|string',
            'check_in_date' => 'required|date',
            'check_out_date' => 'required|date|after:check_in_date',
            'late_check_out' => 'nullable|boolean',
            'early_check_in' => 'nullable|boolean',
            'total_nights' => 'required|integer|min:1',
            'user_type' => 'required|in:main,companion',
        ]);

        // الحصول على الوقت الحالي وتحويله إلى Asia/Amman
        $timeInAmman = Carbon::now()->setTimezone('Asia/Amman');

        // إنشاء الغرفة
        $room = Room::create([
            'reservation_id' => $reservation->id,
            'room_type' => $request->input('room_type'),
            'occupant_name' => $request->input('occupant_name') ?? null, // إذا كانت غير موجودة، اجعلها null
            'special_requests' => $request->input('special_requests') ?? null, // إذا كانت غير موجودة، اجعلها null
            'check_in_date' => $request->input('check_in_date'),
            'check_out_date' => $request->input('check_out_date'),
            'total_nights' => $request->input('total_nights'),
            'late_check_out' => $request->input('late_check_out', false),
            'early_check_in' => $request->input('early_check_in', false),
            'user_type' => $request->input('user_type'),
            // يمكنك إضافة created_at و updated_at هنا إذا لزم الأمر
            'created_at' => $timeInAmman, // تعيين created_at
            'updated_at' => $timeInAmman, // تعيين updated_at
            // يمكن ترك الحقول الأخرى فارغة
        ]);

        return response()->json([
            'message' => 'Room created successfully!',
            'room' => $room
        ], 201);

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'An error occurred while creating the room.',
            'message' => $e->getMessage()
        ], 400);
    }
}




public function updateByAdmin(Request $request, $room_id)
{
    try {
        $room = Room::find($room_id);

        if (!$room) {
            return response()->json(['error' => 'Room not found.'], 404);
        }

        $request->validate([
            'cost' => 'nullable|numeric|min:0',
            'additional_cost' => 'nullable|numeric|min:0',
            'update_deadline' => 'nullable|date',
            'is_confirmed' => 'nullable|boolean',
            'confirmation_message_pdf' => 'nullable|file|mimes:pdf|max:4048',
        ]);

        // تحديث الحقول المطلوبة فقط
        $updatedData = [];

        if ($request->has('cost')) {
            $updatedData['cost'] = $request->input('cost');
        }

        if ($request->has('additional_cost')) {
            $updatedData['additional_cost'] = $request->input('additional_cost');
        }

        if ($request->has('update_deadline')) {
            $updatedData['update_deadline'] = $request->input('update_deadline');
        }

        if ($request->has('is_confirmed')) {
            $updatedData['is_confirmed'] = $request->input('is_confirmed');
        }

        if ($request->has('last_admin_update_at')) {
            $updatedData['last_admin_update_at'] = Carbon::now('Asia/Amman');
        }

        // معالجة ملف confirmation_message_pdf
        if ($request->hasFile('confirmation_message_pdf')) {
            $file = $request->file('confirmation_message_pdf');
            $path = $file->store('pdfs', 'public'); // تخزين الملف في مجلد 'pdfs' داخل المجلد العام

            $updatedData['confirmation_message_pdf'] = $path; // حفظ المسار في قاعدة البيانات

            // إرسال إشعار للمستخدم عند تحديث confirmation_message_pdf
            $reservation = Reservation::where('id', $room->reservation_id)->first();
            if ($reservation) {
                $user_id = $reservation->user_id;

                // إنشاء الإشعار وإضافته إلى جدول الإشعارات
                Notification::create([
                    'user_id' => $user_id,
                    'message' => 'The attached file for your reservation has been updated',
                    'is_read' => false,
                ]);
            }
        }

        // تحديث الغرفة بالبيانات الجديدة
        $room->update($updatedData);

        return response()->json([
            'message' => 'Room updated successfully!',
            'room' => $room
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'An error occurred while updating the room.',
            'message' => $e->getMessage()
        ], 400);
    }
}


public function updateByUser(Request $request, $room_id)
{
    try {
        // العثور على الغرفة
        $room = Room::find($room_id);

        if (!$room) {
            return response()->json(['error' => 'Room not found.'], 404);
        }

        // الحصول على reservation_id من جدول rooms
        $reservation_id = $room->reservation_id; // تأكد أن هذا العمود موجود في جدول rooms

        // العثور على الحجز المتعلق بهذه الغرفة باستخدام reservation_id
        $reservation = Reservation::find($reservation_id);

        if (!$reservation) {
            return response()->json(['error' => 'Reservation not found for this room.'], 404);
        }

        // تحقق من الوقت الحالي
        $currentTime = Carbon::now()->setTimezone('Asia/Amman');

        // تحقق من deadline للتحديث من جدول reservations
        if (is_null($reservation->update_deadline) || $currentTime->greaterThan($reservation->update_deadline)) {
            return response()->json(['error' => 'Cannot update room; update deadline has passed or is not set.'], 403);
        }

        // تحقق من المدخلات
        $request->validate([
            'room_type' => 'nullable|in:Single,Double,Triple',
            'occupant_name' => 'nullable|string',
            'special_requests' => 'nullable|string',
            'check_in_date' => 'nullable|date',
            'check_out_date' => 'nullable|date|after:check_in_date',
            'late_check_out' => 'nullable|boolean',
            'early_check_in' => 'nullable|boolean',
            'total_nights' => 'nullable|integer|min:1',
            'user_type' => 'nullable|in:main,companion',
        ]);

        // إعداد البيانات المحدثة
        $updatedData = [];

        if ($request->has('room_type')) {
            $updatedData['room_type'] = $request->input('room_type');
        }

        if ($request->has('occupant_name')) {
            $updatedData['occupant_name'] = $request->input('occupant_name');
        }

        if ($request->has('special_requests')) {
            $updatedData['special_requests'] = $request->input('special_requests');
        }

        if ($request->has('check_in_date')) {
            $updatedData['check_in_date'] = $request->input('check_in_date');
        }

        if ($request->has('check_out_date')) {
            $updatedData['check_out_date'] = $request->input('check_out_date');
        }

        if ($request->has('total_nights')) {
            $updatedData['total_nights'] = $request->input('total_nights');
        }

        if ($request->has('late_check_out')) {
            $updatedData['late_check_out'] = $request->input('late_check_out');
        }

        if ($request->has('early_check_in')) {
            $updatedData['early_check_in'] = $request->input('early_check_in');
        }

        if ($request->has('user_type')) {
            $updatedData['user_type'] = $request->input('user_type');
        }

        if ($request->has('last_user_update_at')) {
            $updatedData['last_user_update_at'] = Carbon::now('Asia/Amman');
        }

        // تحديث الغرفة
        $room->update($updatedData);

        return response()->json([
            'message' => 'Room updated successfully!',
            'room' => $room
        ], 200);

    } catch (\Exception $e) {
        return response()->json([
            'error' => 'An error occurred while updating the room.',
            'message' => $e->getMessage()
        ], 400);
    }
}




}