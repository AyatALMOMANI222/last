<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Models\Reservation;
use App\Models\Room;
use App\Models\User;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReservationsController extends Controller
{
    // public function createReservation(Request $request)
    // {
    //     try {
    //         $request->validate([
    //             'room_count' => 'required|integer|min:1',
    //             'companions_count' => 'required|integer|min:0',
    //             'companions_names' => 'nullable|string'
    //         ]);
    
    //         // الحصول على معرف المستخدم من التوكن
    //         $user_id = Auth::id();
    
    //         // إنشاء الحجز
    //         $reservation = Reservation::create([
    //             'user_id' => $user_id,
    //             'room_count' => $request->input('room_count'),
    //             'companions_count' => $request->input('companions_count'),
    //             'companions_names' => $request->input('companions_names')
    //         ]);
    
    //         return response()->json([
    //             'message' => 'Reservation created successfully!',
    //             'reservation' => $reservation
    //         ], 201);

    //     } catch (Exception $e) {
    //         return response()->json([
    //             'error' => 'An error occurred while creating the reservation.',
    //             'message' => $e->getMessage()
    //         ], 400); 
    //     }
    // }
    public function createReservation(Request $request)
    {
        try {
            // تحقق من صحة البيانات
            $validatedData = $request->validate([
                'user_id' => 'required|exists:users,id',
                'room_count' => 'required|integer|min:1', // عدد الغرف
                'companions_count' => 'nullable|integer|min:0',
                'companions_names' => 'nullable|string',
                'update_deadline' => 'nullable|date',
                'rooms' => 'required|array', // التأكد من وجود مصفوفة الغرف
                'rooms.*.room_type' => 'required|string', // نوع الغرفة
                'rooms.*.occupant_name' => 'required|string', // اسم الشاغل
                'rooms.*.check_in_date' => 'required|date', // تاريخ الدخول
                'rooms.*.check_out_date' => 'required|date|after:rooms.*.check_in_date', // تاريخ الخروج
                'rooms.*.total_nights' => 'required|integer|min:1', // عدد الليالي
                'rooms.*.cost' => 'required|numeric|min:0', // التكلفة
                'rooms.*.additional_cost' => 'nullable|numeric|min:0', // تكلفة إضافية
            ]);
    
            // إنشاء الحجز
            $reservation = Reservation::create([
                'user_id' => $validatedData['user_id'],
                'room_count' => $validatedData['room_count'],
                'companions_count' => $validatedData['companions_count'] ?? 0,
                'companions_names' => $validatedData['companions_names'] ?? null,
                'update_deadline' => $validatedData['update_deadline'] ?? Carbon::now()->addDays(30),
            ]);
    
            // إعداد بيانات الغرف المرتبطة بالحجز
            $roomsData = [];
            for ($i = 0; $i < $validatedData['room_count']; $i++) {
                $roomsData[] = [
                    'reservation_id' => $reservation->id, // تمرير ID الحجز
                    'room_type' => $validatedData['rooms'][$i]['room_type'],
                    'occupant_name' => $validatedData['rooms'][$i]['occupant_name'],
                    'special_requests' => $request->input("rooms.$i.special_requests", null),
                    'check_in_date' => $validatedData['rooms'][$i]['check_in_date'],
                    'check_out_date' => $validatedData['rooms'][$i]['check_out_date'],
                    'total_nights' => $validatedData['rooms'][$i]['total_nights'],
                    'cost' => $validatedData['rooms'][$i]['cost'],
                    'additional_cost' => $validatedData['rooms'][$i]['additional_cost'] ?? 0.00,
                    'update_deadline' => $request->input("rooms.$i.update_deadline", Carbon::now()->addDays(30)),
                    'created_at' => now(), // استخدم now() بدلاً من Carbon::now()
                    'updated_at' => now(),
                ];
            }
    
            // إدخال بيانات الغرف في قاعدة البيانات دفعة واحدة
            Room::insert($roomsData);
    
            // استجابة النجاح
            return response()->json([
                'message' => 'Reservation and rooms created successfully.',
                'reservation_id' => $reservation->id, // إرجاع ID الحجز
                'rooms' => $roomsData,
            ], 201);
    
        } catch (\Exception $e) {
            // استجابة عند حدوث خطأ
            return response()->json([
                'message' => 'Failed to create reservation. ' . $e->getMessage(),
            ], 400);
        }
    }
    
    
    
    

































    
    // public function deleteReservation($id)
    // {
    //     try {
    //         // إيجاد الحجز بالمعرف (id)
    //         $reservation = Reservation::find($id);
    
    //         // التحقق إذا كان الحجز موجوداً
    //         if (!$reservation) {
    //             return response()->json([
    //                 'error' => 'Reservation not found.'
    //             ], 404);
    //         }
    
    //         $reservation->is_delete = true;
    //         $reservation->save();
    
    //         return response()->json([
    //             'message' => 'Reservation marked as deleted successfully!',
    //             'reservation' => $reservation
    //         ], 200);
    //     } catch (Exception $e) {
    //         return response()->json([
    //             'error' => 'An error occurred while deleting the reservation.',
    //             'message' => $e->getMessage()
    //         ], 400);
    //     }
    // }
    
    public function deleteReservation($id)
    {
        try {
            // إيجاد الحجز بالمعرف (id)
            $reservation = Reservation::find($id);
    
            // التحقق إذا كان الحجز موجوداً
            if (!$reservation) {
                return response()->json([
                    'error' => 'Reservation not found.'
                ], 404);
            }
    
            // حذف الحجز، مما سيؤدي تلقائياً إلى حذف الغرف المرتبطة بفضل onDelete('cascade')
            $reservation->delete();
    
            // إرسال إشعار إلى جميع الإداريين
            $admins = User::where('isAdmin', true)->get(); // افترض أن لديك نموذج User
            foreach ($admins as $admin) {
                // إنشاء إشعار وحفظه في جدول notifications
                Notification::create([
                    'user_id' => $admin->id, // استخدام معرف الإداري
                    'message' => 'Reservation ID ' . $reservation->id . ' has been deleted.',
                    'is_read' => false,
                ]);
            }
    
            return response()->json([
                'message' => 'Reservation deleted successfully!',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while deleting the reservation.',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    
    public function updateDeadlineByAdmin(Request $request, $id)
    {
        try {
            $reservation = Reservation::findOrFail($id);
    
            $request->validate([
                'update_deadline' => 'required|date' 
            ]);
    
            $reservation->update([
                'update_deadline' => $request->input('update_deadline')
            ]);
    
            return response()->json([
                'message' => 'Reservation deadline updated successfully!',
                'reservation' => $reservation
            ], 200);
    
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the reservation deadline.',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    
    public function updateReservation(Request $request, $id)
    {
        try {
            // الحصول على الحجز الحالي
            $reservation = Reservation::findOrFail($id);
    
            // التحقق إذا كان قد تم تجاوز الموعد النهائي للتحديث
            if ($reservation->update_deadline && now()->greaterThan($reservation->update_deadline)) {
                return response()->json([
                    'error' => 'The reservation cannot be updated because the deadline has passed.',
                ], 403); // إرسال خطأ إذا تم تجاوز الموعد النهائي
            }
    
            // تحقق من القيم المدخلة وتحديث فقط إذا كانت موجودة
            $dataToUpdate = [];
    
            // إذا تم تقديم قيمة جديدة، استخدمها، وإلا احتفظ بالقيمة القديمة
            if ($request->has('room_count')) {
                $dataToUpdate['room_count'] = $request->input('room_count');
            } else {
                $dataToUpdate['room_count'] = $reservation->room_count; // الاحتفاظ بالقيمة القديمة
            }
    
            if ($request->has('companions_count')) {
                $dataToUpdate['companions_count'] = $request->input('companions_count');
            } else {
                $dataToUpdate['companions_count'] = $reservation->companions_count; // الاحتفاظ بالقيمة القديمة
            }
    
            if ($request->has('companions_names')) {
                $dataToUpdate['companions_names'] = $request->input('companions_names');
            } else {
                $dataToUpdate['companions_names'] = $reservation->companions_names; // الاحتفاظ بالقيمة القديمة
            }
    
            // تحديث الحجز باستخدام القيم المحدثة
            $reservation->update($dataToUpdate);
    
            return response()->json([
                'message' => 'Reservation updated successfully!',
                'reservation' => $reservation
            ], 200);
    
        } catch (Exception $e) {
            return response()->json([
                'error' => 'An error occurred while updating the reservation.',
                'message' => $e->getMessage()
            ], 400); 
        }
    }
    

public function getReservationsByUserId(Request $request)
{
    try {
        $user_id = Auth::id();

        $reservations = Reservation::where('user_id', $user_id)->get();

        if ($reservations->isEmpty()) {
            return response()->json([
                'message' => 'No reservations found for this user.'
            ], 404);
        }

        return response()->json([
            'reservations' => $reservations
        ], 200);
        
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'An error occurred while retrieving reservations.',
            'message' => $e->getMessage()
        ], 500);
    }
}

public function getAllReservations()
{
    try {
       
        $reservations = Reservation::all();

        if ($reservations->isEmpty()) {
            return response()->json([
                'message' => 'No reservations found.'
            ], 404);
        }

        return response()->json([
            'reservations' => $reservations
        ], 200);
        
    } catch (\Exception $e) {
        return response()->json([
            'error' => 'An error occurred while retrieving reservations.',
            'message' => $e->getMessage()
        ], 500); 
    }
}


}

