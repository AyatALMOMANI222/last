<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConferenceTrip extends Model
{
    use HasFactory;

    // تعريف جدول البيانات
    protected $table = 'conference_trip';

    // تحديد الحقول القابلة للتعبئة إذا لزم الأمر
    protected $fillable = [
        'conference_id',
        'trip_id',
    ];

    // علاقة مع نموذج Conference
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }

    // علاقة مع نموذج Trip
    public function trip()
    {
        return $this->belongsTo(Trip::class, 'trip_id');
    }
}
