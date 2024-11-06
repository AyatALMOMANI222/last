<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConferenceSponsorshipOption extends Model
{
    use HasFactory;

    protected $fillable = [
        'conference_id', 'item', 'price', 'max_sponsors', 'booth_size',
        'booklet_ad', 'website_ad', 'bags_inserts', 'backdrop_logo',
        'non_residential_reg', 'residential_reg'
    ];

    // علاقة مع جدول المؤتمرات (Conference)
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
