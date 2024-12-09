<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AirportTransferInvoice extends Model
{
    use HasFactory;

    // Specify the table name if it's not the plural of the model name
    protected $table = 'airport_transfers_invoices';

    // Define the relationship between AirportTransferInvoice and AirportTransferBooking
    public function airportTransferBooking()
    {
        return $this->belongsTo(AirportTransferBooking::class, 'airport_transfer_booking_id');
    }

    // Define the fillable properties
    protected $fillable = [
        'airport_transfer_booking_id',
        'total_price',
        'status',
    ];
}
