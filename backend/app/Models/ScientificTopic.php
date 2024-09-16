<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ScientificTopic extends Model
{
    use HasFactory;

    protected $table = 'scientific_topics';

    protected $fillable = [
        'conference_id',
        'title',
        'description',
        'speaker_names',
        'goal',
    ];

    // علاقة مع مؤتمر
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
