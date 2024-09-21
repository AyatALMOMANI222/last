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
    ];

    public function flight()
    {
        return $this->belongsTo(Flight::class, 'flight_id', 'flight_id');
    }
}
