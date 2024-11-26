<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StandardBoothPackage extends Model
{
    use HasFactory;

    // اسم الجدول المرتبط بالموديل
    protected $table = 'standard_booth_packages';

    // الأعمدة القابلة للتعبئة
    protected $fillable = [
        'conference_id',
        'floor_plan',
    ];

    // العلاقة مع جدول conferences
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
