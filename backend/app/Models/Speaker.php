<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Speaker extends Model
{
    use HasFactory;

    // تحديد اسم الجدول (اختياري إذا كان اسم الجدول يتبع التسمية القياسية)
    protected $table = 'speakers';

    // تحديد الخصائص القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'conference_id',
        'abstract',
        'topics',
        'presentation_file',
        'online_participation',
        'is_online_approved',
        'accommodation_status',
        'ticket_status',
        'dinner_invitation',
        'airport_pickup',
        'free_trip',
        'certificate_file',
        'is_certificate_active',
    ];

    // العلاقة مع نموذج User (متحدث ينتمي إلى مستخدم واحد)
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // العلاقة مع نموذج Conference (متحدث ينتمي إلى مؤتمر واحد)
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }

    public function dinnerAttendees()
    {
        return $this->hasMany(DinnerAttendee::class);
    }
}
