<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommitteeMember extends Model
{
    use HasFactory;
    protected $table = 'committee_members';

    protected $fillable = [
        'name',
        'committee_image',
        'conference_id',
    ];

    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
