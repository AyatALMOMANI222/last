<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DinnerDetail extends Model
{
    use HasFactory;
    protected $table = 'dinner_details';

    // Define fillable fields for mass assignment
    protected $fillable = [
        'conference_id',
        'dinner_date',
        'restaurant_name',
        'location',
        'gathering_place',
        'transportation_method',
        'gathering_time',
        'dinner_time',
        'duration',
        'dress_code',
    ];

    // Define relationships
    public function conference()
    {
        return $this->belongsTo(Conference::class, 'conference_id');
    }
    public function attendees()
    {
        return $this->hasMany(DinnerAttendee::class);
    }
    public function companionFees()
    {
        return $this->hasMany(DinnerSpeakerCompanionFee::class, 'dinner_id');
    }
}
