<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExhibitionImage extends Model
{
    use HasFactory;

    protected $table = 'exhibition_images';

    protected $fillable = [
        'exhibition_id',
        'image',
        'alt_text',
        'uploaded_at',
    ];

    public function exhibition()
    {
        return $this->belongsTo(Exhibition::class, 'exhibition_id');
    }
}
