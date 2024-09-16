<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConferencePrice extends Model
{
    use HasFactory;

    // تحديد اسم الجدول
    protected $table = 'conference_prices';

    // تحديد الأعمدة القابلة للتعبئة
    protected $fillable = [
        'conference_id',
        'price_type',
        'price',
        'description',
    ];

    // تعريف العلاقة مع موديل Conference
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
