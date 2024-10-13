<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AirportTransferPrice extends Model
{
    use HasFactory;

    protected $table = 'airport_transfer_prices'; // اسم الجدول

    protected $fillable = [
        'conference_id',
        'from_airport_price',
        'to_airport_price',
        'round_trip_price',
    ];

    // علاقة مع مؤتمر
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
