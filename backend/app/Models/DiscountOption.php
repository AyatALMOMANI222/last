<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiscountOption extends Model
{
    use HasFactory;

    // Define the table name (if not following Laravel's naming convention)
    protected $table = 'discount_option';

    // Define the fillable attributes for mass assignment
    protected $fillable = [
        'user_id',
        'trip_id',
        'option_id',
        'price',
        'show_price',
    ];

    // علاقة مع جدول User
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // علاقة مع جدول Trip
    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }

    // علاقة مع جدول AdditionalOption
    public function additionalOption()
    {
        return $this->belongsTo(AdditionalOption::class, 'option_id');
    }
    
}
