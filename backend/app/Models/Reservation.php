<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'check_in_date',
        'check_out_date',
        'late_check_out',
        'early_check_in',
        'additional_cost',
        'user_type',
        'total_nights',
        'room_count',
        'companions',
    ];

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

