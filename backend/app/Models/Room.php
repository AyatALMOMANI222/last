<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;

    protected $fillable = [
        'reservation_id',
        'room_type',
        'occupant_name',
        'special_requests',
        'cost',
        'update_deadline',
        'is_confirmed',
        'confirmation_message',
        'confirmation_number',
    ];

    public function reservation()
    {
        return $this->belongsTo(Reservation::class);
    }
}
