<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReservationInvoice extends Model
{
    use HasFactory;

    // تحديد الجدول المرتبط (اختياري إذا كان اسم الجدول مطابق لاسم الموديل بالصيغة الجمعية)
    protected $table = 'reservation_invoices';

    // السماح بتعبئة الأعمدة بشكل جماعي
    protected $fillable = [
        'room_id',
        'price',
        'additional_price',
        'total',
        'status',
        'late_check_out_price',
        'early_check_in_price',
        'confirmationPDF'
    ];

    // تعريف العلاقة مع جدول الغرف
    public function room()
    {
        return $this->belongsTo(Room::class);
    }
}
