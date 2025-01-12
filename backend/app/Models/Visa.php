<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Visa extends Model
{
    use HasFactory;

    // تحديد اسم الجدول (اختياري إذا كان اسم الجدول يتبع التسمية القياسية)
    protected $table = 'visas';

    // تحديد الخصائص القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'passport_image',
        'arrival_date',
        'departure_date',
        'visa_cost',
        'payment_required',
        'status',
        'visa_updated_at',
        'payment_method',
        'payment_status',
        'transaction_id',
        'payment_date',
        'visapdf'
    ];

    // العلاقة مع نموذج User (فيزا تنتمي إلى مستخدم واحد)
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
