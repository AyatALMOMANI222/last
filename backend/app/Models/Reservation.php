<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'room_count',
        'companions_count',
        'companions_names',
        'is_delete',
        'update_deadline',
        'conference_id'

    ];

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
