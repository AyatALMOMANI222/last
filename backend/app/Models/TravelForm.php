<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TravelForm extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'firstName',
        'lastName',
        'email',
        'nationality',
        'cellular',
        'whatsapp',
        'arrivalDate',
        'departureDate',
        'hotelCategory',
        'hotelName',
        'accompanyingPersons',
        'totalUSD',
        'roomType',
    ];

    // إذا أردت تعطيل تحديث التاريخ بشكل تلقائي (إذا كنت لا تريد timestamps)
    public $timestamps = true;
}
