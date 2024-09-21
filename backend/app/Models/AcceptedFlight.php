<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AcceptedFlight extends Model
{
    use HasFactory;

    protected $table = 'accepted_flights';  // اسم الجدول

    protected $primaryKey = 'accepted_flight_id';  // المفتاح الأساسي

    protected $fillable = [
        'flight_id',
        'price',
        'admin_set_deadline',
        'ticket_number',
        'ticket_image',
        'issued_at',
        'expiration_date',
    ];

    public function flight()
    {
        return $this->belongsTo(Flight::class, 'flight_id', 'flight_id');
    }
}
