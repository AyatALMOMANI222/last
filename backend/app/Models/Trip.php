<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Trip extends Model
{
    use HasFactory;

    // تعريف جدول البيانات
    protected $table = 'trips';

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'trip_type',
        'name',
        'description',
        'additional_info',
        'image_1',
        'image_2',
        'image_3',
        'image_4',
        'image_5',
        'price_per_person',
        'price_for_two',
        'price_for_three_or_more',
        'available_dates',
        'location',
        'duration',
        'inclusions',
        'group_price_per_person',
        'group_price_per_speaker',
        'trip_details',
        'group_accompanying_price'
    ];

    // إذا كان لديك تواريخ متاحة وتريد التعامل معها كـ JSON
    protected $casts = [
        'available_dates' => 'array',
    ];

    public function conferences()
    {
        return $this->belongsToMany(Conference::class, 'conference_trip');
    }
    public function additionalOptions()
    {
        return $this->hasMany(AdditionalOption::class);
    }
//     public function conferenceTrips()
// {
//     return $this->hasMany(ConferenceTrip::class);
// }
// علاقة مع جدول DiscountOption
public function discountOptions()
{
    return $this->hasMany(DiscountOption::class);
}

public function tripOptionsParticipants()
{
    return $this->hasMany(TripOptionsParticipant::class);
}
public function groupTripRegistrations()
{
    return $this->hasMany(GroupTripRegistration::class);
}

}
