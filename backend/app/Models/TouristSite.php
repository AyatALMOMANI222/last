<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TouristSite extends Model
{
    use HasFactory;

    protected $table = 'tourist_sites';

    protected $fillable = [
        'name',
        'description',
        'image',
        'additional_info',
    ];
}
