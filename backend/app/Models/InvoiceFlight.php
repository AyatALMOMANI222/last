<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InvoiceFlight extends Model
{
    use HasFactory;

    protected $table = 'invoice_flights'; // Specify the table name (optional if it's the plural form)

    protected $fillable = [
        'flight_id', // Foreign key
        'total_price',
        'status',
    ];

    /**
     * Get the flight that owns the InvoiceFlight.
     */
    public function flight()
    {
        return $this->belongsTo(Flight::class);
    }
}
