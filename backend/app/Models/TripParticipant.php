<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TripParticipant extends Model
{
    use HasFactory;

    // Define the table name
    protected $table = 'trip_participants';

    // Specify fillable fields
    protected $fillable = [
        'user_id',
        'main_user_id',
        'trip_id',
        'name',
        'nationality',
        'phone_number',
        'whatsapp_number',
        'is_companion',
        'include_accommodation',
        'accommodation_stars',
        'nights_count',
        'check_in_date',
        'check_out_date',
    ];

    // Define relationships
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }

    public function tripOptionsParticipants()
    {
        return $this->hasMany(TripOptionsParticipant::class);
    }

    public function privateInvoiceTrip()
    {
        return $this->hasOne(PrivateInvoiceTrip::class, 'participant_id');
    }

    // Add companions relationship
    public function companions()
    {
        return $this->hasMany(TripParticipant::class, 'main_user_id');
    }
}
