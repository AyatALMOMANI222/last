<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TripOptionsParticipant extends Model
{
    use HasFactory;

    // تحديد اسم الجدول (في حالة لم يتطابق مع اسم الموديل)
    protected $table = 'trip_options_participants';

    // الحقول المسموح بتعبئتها مباشرة
    protected $fillable = [
        'trip_id',
        'option_id',
        'participant_id',
    ];


    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }

    public function additionalOption()
    {
        return $this->belongsTo(AdditionalOption::class, 'option_id');
    }

    public function participant()
    {
        return $this->belongsTo(TripParticipant::class);
    }
}
