<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupTripParticipant extends Model
{
    use HasFactory;

    // تعريف جدول البيانات
    protected $table = 'group_trip_participants';

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'trip_id',
        'selected_date',
        'companions_count',
        'total_price',
    ];

    // تعريف العلاقات
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }
}
