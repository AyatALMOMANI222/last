<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransportationRequest extends Model
{
    use HasFactory;

    // تحديد الجدول في قاعدة البيانات (إذا كان اسمه مختلفًا عن الاسم الافتراضي)
    protected $table = 'transportation_requests';

    // الحقول التي يمكن ملؤها عبر الـ Mass Assignment
    protected $fillable = [
        'first_name',
        'last_name',
        'email',
        'whatsapp',
        'passengers',
        'pickup_option',
        'flight_code',
        'flight_time',
        'additional_info',
        'total_usd',
    ];

    // تحويل الحقول إلى النوع المناسب
    protected $casts = [
        'pickup_option' => 'string',  // خيار pickup_option
        'total_usd' => 'decimal:2',  // التأكد من أن إجمالي التكلفة هو قيمة عشرية
    ];
}
