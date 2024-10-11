<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdditionalOption extends Model
{
    use HasFactory;

    // تعريف جدول البيانات
    protected $table = 'additional_options';
    public $timestamps = false;

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'trip_id',
        'option_name',
        'option_description',
        'price',
    ];

    // تعريف العلاقة مع جدول الرحلات
    public function trip()
    {
        return $this->belongsTo(Trip::class);
    }

    // علاقة مع جدول DiscountOption
public function discountOptions()
{
    return $this->hasMany(DiscountOption::class, 'option_id');
}

}
