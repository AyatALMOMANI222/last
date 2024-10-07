<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserDiscount extends Model
{
    use HasFactory;

    // تعريف جدول البيانات
    protected $table = 'user_discounts';

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'trip_participant_id',
        'option_id',
        'discount_value',
        'show_price',
    ];

    // تعريف العلاقة مع نموذج TripParticipant
    public function tripParticipant()
    {
        return $this->belongsTo(TripParticipant::class);
    }

    // تعريف العلاقة مع نموذج AdditionalOption
    public function additionalOption()
    {
        return $this->belongsTo(AdditionalOption::class);
    }
}
