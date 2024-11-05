<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DinnerAttendee extends Model
{
    use HasFactory;
    protected $table = 'dinner_attendees';

    protected $fillable = [
        'speaker_id',
        'companion_name',
        'notes',
        'paid',
        'is_companion_fee_applicable',
        'companion_price',
        'conference_id'
    ];

    public function speaker()
    {
        return $this->belongsTo(Speaker::class);
    }

 
}
