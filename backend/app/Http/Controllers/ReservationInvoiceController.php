<?php

namespace App\Http\Controllers;

use App\Events\NotificationSent;
use App\Models\Notification;
use App\Models\Reservation;
use App\Models\ReservationInvoice;
use App\Models\Room;
use App\Models\User;
use Illuminate\Http\Request;

class ReservationInvoiceController extends Controller
{
    // إنشاء فاتورة جديدة
public function store(Request $request)
{
    $request->validate([
        'room_id' => 'required|exists:rooms,id',
        'price' => 'required|numeric',
        'additional_price' => 'nullable|numeric',
        'total' => 'required|numeric',
    ]);

    try {
        $invoice = ReservationInvoice::create($request->all());
        return response()->json(['message' => 'Invoice created successfully', 'data' => $invoice], 201);
    } catch (\Exception $e) {
        // إذا حدث خطأ، إرجاع رسالة خطأ مع التفاصيل
        return response()->json(['message' => 'Failed to create invoice', 'error' => $e->getMessage()], 500);
    }
}
public function pay(Request $request, $invoiceId)
{
    try {
        // التحقق من وجود السجل في جدول الفواتير
        $invoice = ReservationInvoice::find($invoiceId);

        if (!$invoice) {
            return response()->json(['error' => 'Reservation invoice not found.'], 404);
        }

        // تحديث حالة الفاتورة إلى "approved"
        $invoice->status = 'approved';
        $invoice->save();

        // جلب الإداريين
        $admins = User::where('isAdmin', true)->get();

        foreach ($admins as $admin) {
            // إنشاء رسالة الإشعار
            $notificationMessage = 'The payment for the reservation invoice with ID ' . $invoiceId . ' has been successfully completed.';

            // إنشاء إشعار جديد
            Notification::create([
                'user_id' => $admin->id,
                'message' => $notificationMessage,
                'is_read' => false,
            ]);
        }

        return response()->json([
            'success' => 'Reservation invoice approved and notifications sent to admins.',
            'invoice' => $invoice
        ]);

    } catch (\Exception $e) {
        // معالجة الأخطاء
        return response()->json([
            'error' => 'An error occurred while processing the invoice.',
            'message' => $e->getMessage()
        ], 500);
    }
}


public function getApprovedInvoices()
{
    try {
        // Eager load the related 'room' model for each invoice, and filter by 'approved' status
        $approvedInvoices = ReservationInvoice::with('room')  // Eager load 'room' relationship
            ->where('status', 'approved')
            ->get();

        if ($approvedInvoices->isEmpty()) {
            return response()->json(['message' => 'No approved invoices found.'], 404);
        }

        return response()->json(['success' => true, 'invoices' => $approvedInvoices], 200);
    } catch (\Exception $e) {
        // Error handling
        return response()->json([
            'error' => 'An error occurred while fetching approved invoices.',
            'message' => $e->getMessage()
        ], 500);
    }
}


public function addConfirmationPDF(Request $request, $invoiceId)
{
    // التحقق من وجود السجل في جدول الفواتير
    $invoice = ReservationInvoice::find($invoiceId);
    if (!$invoice) {
        return response()->json(['error' => 'Invoice not found.'], 404);
    }

    // التحقق من وجود ملف مرفوع
    if ($request->hasFile('confirmationPDF')) {
        $file = $request->file('confirmationPDF');

        // التحقق من نوع الملف (يجب أن يكون PDF أو صورة)
        $allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png'];
        $fileExtension = $file->getClientOriginalExtension();

        if (!in_array($fileExtension, $allowedExtensions)) {
            return response()->json(['error' => 'The file must be a PDF or an image (JPG, JPEG, PNG).'], 400);
        }

        // تخزين الملف في مجلد 'confirmationFiles' داخل المجلد العام
        $filePath = $file->store('confirmationFiles', 'public'); // تخزين في مجلد public/confirmationFiles

        // تحديث السجل وتخزين مسار الملف
        $invoice->confirmationPDF = $filePath;
        $invoice->save();

        // **جلب معلومات الحجز (reservation_id) من جدول rooms**
        $room = Room::find($invoice->room_id);
        if (!$room) {
            return response()->json(['error' => 'Room not found.'], 404);
        }

        // جلب reservation_id من جدول rooms
        $reservation = Reservation::find($room->reservation_id);
        if (!$reservation) {
            return response()->json(['error' => 'Reservation not found.'], 404);
        }

        // جلب user_id من جدول reservations
        $user = User::find($reservation->user_id);
        if (!$user) {
            return response()->json(['error' => 'User not found.'], 404);
        }

        // إرسال إشعار للمستخدم
        $notificationMessage = 'The confirmation letter for your reservation is now available. Please log in to your account to download it.';

        $userNotification = Notification::create([
            'user_id' => $user->id,
            'message' => $notificationMessage,
            'is_read' => false, // إعداد القراءة
        ]);

        // بث الإشعار
        broadcast(new NotificationSent($userNotification));

        return response()->json([
            'success' => 'Confirmation file (PDF or image) added successfully, and notification sent to the user.',
            'invoice' => $invoice,
        ]);
    }

    return response()->json(['error' => 'No file uploaded.'], 400);
}



}

