<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{
    use HasFactory;

    // تحديد الاسم الكامل للجدول في قاعدة البيانات
    protected $table = 'attendance';

    // تعريف الأعمدة التي يمكن تعيينها
    protected $fillable = [
        'user_id',
        'conference_id',
        'registration_fee',
        'includes_conference_bag',
        'includes_conference_badge',
        'includes_conference_book',
        'includes_certificate',
        'includes_lecture_attendance',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
