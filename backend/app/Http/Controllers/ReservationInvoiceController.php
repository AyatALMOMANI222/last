<?php

namespace App\Http\Controllers;

use App\Models\ReservationInvoice;
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

}
