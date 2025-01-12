<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PrivateInvoiceTrip extends Model
{
    use HasFactory;

    // Define the table name (optional if the table follows Laravel's naming conventions)
    protected $table = 'private_invoice_trips';

    // Define which attributes are mass assignable
    protected $fillable = [
        'participant_id',
        'base_price',
        'options_price',
        'total_price',
        'status'
    ];

    // Define the relationship with the TripParticipant model
    public function participant()
    {
        return $this->belongsTo(TripParticipant::class, 'participant_id');
    }
    
}
