<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sponsorship extends Model
{
    use HasFactory;

    // تحديد اسم الجدول إذا كان مختلفًا عن الاسم الافتراضي
    protected $table = 'sponsorships';  // اسم الجدول في قاعدة البيانات

    // إذا كنت تستخدم التواريخ (timestamps)
    public $timestamps = true;

    // تحديد الأعمدة القابلة للتحديث
    protected $fillable = [
        'item',
        'price',
        'max_sponsors',
        'booth_size',
        'booklet_ad',
        'website_ad',
        'bags_inserts',
        'backdrop_logo',
        'non_residential_reg',
        'residential_reg',
        'conference_id', // إذا كان لديك عمود `conference_id` كـ foreign key
    ];

    // العلاقة مع جدول Conference إذا كان موجودًا
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
