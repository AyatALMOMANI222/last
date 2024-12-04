<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupTripRegistration extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'trip_id',
        'number_of_companion',
        'total_price',
    ];

    // علاقة مع المستخدم
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // علاقة مع الرحلة
    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }
}
