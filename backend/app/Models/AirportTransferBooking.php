<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AirportTransferBooking extends Model
{
    use HasFactory;

    protected $table = 'airport_transfer_bookings'; // اسم الجدول

    protected $fillable = [
        'conference_id',
        'user_id',
        'trip_type',
        'arrival_date',
        'arrival_time',
        'departure_date',
        'departure_time',
        'flight_number',
        'companion_name',
        'driver_name',
        'driver_phone',
    ];

    // علاقة مع مؤتمر
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }

    // علاقة مع مستخدم
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
