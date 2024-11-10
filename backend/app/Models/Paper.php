<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paper extends Model
{
    use HasFactory;

    protected $table = 'papers';


    protected $fillable = [
        'conference_id',
        'user_id',
        'title',
        'abstract',
        'file_path',
        'status',
        'submitted_at'
    ];

    protected $casts = [
        'submitted_at' => 'datetime',
        'status' => 'string',
    ];

    // تعريف علاقة الورقة العلمية بالمستخدم



    public function conference()
    {
        return $this->belongsToMany(Conference::class);
    }
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
