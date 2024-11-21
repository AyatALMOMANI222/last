<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TicketBooking extends Model
{
    use HasFactory;

    // تحديد اسم الجدول إذا لم يتبع الاسم الافتراضي
    protected $table = 'ticket_bookings';

    // تحديد الأعمدة القابلة للتحديث بشكل جماعي
    protected $fillable = [
        'title',
        'first_name',
        'last_name',
        'nationality',
        'email',
        'cellular',
        'whatsapp',
        'departure_date',
        'arrival_date',
        'arrival_time',
        'departure_time',
        'preferred_airline',
        'departure_from',
        'passport_copy',
    ];

    // إذا كنت تريد أن يتم التعامل مع الـ timestamps (created_at و updated_at)
    public $timestamps = true;
}
