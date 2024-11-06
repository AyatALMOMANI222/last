<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SponsorshipOption extends Model
{
    use HasFactory;

    protected $fillable = [
        'conference_id',
        'title',
        'description',
        'price'
    ];

    /**
     * العلاقة بين SponsorshipOption و Conference
     */
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
