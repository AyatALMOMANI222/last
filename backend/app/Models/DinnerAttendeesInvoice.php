<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DinnerAttendeesInvoice extends Model
{
    use HasFactory;

    // Table name (optional if it's the plural of the model)
    protected $table = 'dinner_attendees_invoice';

    // Fillable fields to allow mass assignment
    protected $fillable = [
        'price',
        'status',
        'dinner_attendees_id',
    ];

    // Define the relationship with the DinnerAttendee model (foreign key reference)
    public function dinnerAttendee()
    {
        return $this->belongsTo(DinnerAttendee::class, 'dinner_attendees_id');
    }
}
