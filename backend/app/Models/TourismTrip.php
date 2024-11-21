<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TourismTrip extends Model
{
    use HasFactory;

    // تحديد اسم الجدول
    protected $table = 'الرحلات_السياحية';

    // تحديد الأعمدة القابلة للتعبئة
    protected $fillable = [
        'title', 
        'firstname', 
        'lastname', 
        'emailaddress', 
        'phonenumber', 
        'nationality', 
        'country', 
        'arrivalPoint', 
        'departurePoint', 
        'arrivalDate', 
        'departureDate', 
        'arrivalTime', 
        'departureTime', 
        'preferredHotel', 
        'duration', 
        'adults', 
        'children', 
        'preferredDestination', 
        'activities'
    ];

    // تحويل الأعمدة التي تحتوي على بيانات JSON
    protected $casts = [
        'preferredDestination' => 'array',
        'activities' => 'array',
    ];
}
