<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoomPrice extends Model
{
    use HasFactory;

    // تحديد اسم الجدول إذا لم يكن الاسم الافتراضي هو plurals من اسم النموذج
    protected $table = 'room_prices';

    // تحديد الخصائص القابلة للتعبئة
    protected $fillable = [
        'room_type',
        'base_price',
        'companion_price',
        'early_check_in_price',
        'late_check_out_price',
        'conference_id',
    ];

    // تعريف العلاقة مع مؤتمر
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
