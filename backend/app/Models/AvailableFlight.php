<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AvailableFlight extends Model
{
    use HasFactory;

    protected $table = 'available_flights';  // اسم الجدول

    protected $primaryKey = 'available_id';  // المفتاح الأساسي

    protected $fillable = [
        'flight_id',
        'departure_date',
        'departure_time',
        'price',
        'is_free',
        'departure_flight_number',  // رقم رحلة المغادرة
        'departure_airport',        // مطار المغادرة
        'arrival_flight_number',    // رقم رحلة الوصول
        'arrival_date',             // تاريخ الوصول
        'arrival_time',             // وقت الوصول
        'arrival_airport',          // مطار الوصول
    ];

    public function flight()
    {
        return $this->belongsTo(Flight::class, 'flight_id', 'flight_id');
    }
}
