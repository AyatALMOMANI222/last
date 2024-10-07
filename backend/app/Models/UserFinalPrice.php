<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserFinalPrice extends Model
{
    use HasFactory;

    // تعريف الجدول
    protected $table = 'user_final_prices';

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'trip_participant_id',
        'trip_id',
        'final_price',
    ];

    // تعريف العلاقة مع نموذج TripParticipant
    public function tripParticipant()
    {
        return $this->belongsTo(TripParticipant::class);
    }

    // تعريف العلاقة مع نموذج Trip
    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }
}
