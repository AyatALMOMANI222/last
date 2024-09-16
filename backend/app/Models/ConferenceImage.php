<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConferenceImage extends Model
{
    use HasFactory;
    protected $table = 'conference_image';

    protected $fillable = [
        'conference_id',
        'conference_img',
    ];

    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
