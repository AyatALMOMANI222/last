<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Exhibition extends Model
{
    use HasFactory;

    protected $table = 'exhibitions';

    protected $fillable = [
        'title',
        'description',
        'location',
        'start_date',
        'end_date',
        'image',
        'status',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'status' => 'string',
    ];
    public function images()
    {
        return $this->hasMany(ExhibitionImage::class, 'exhibition_id');
    }
}
