<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

;

class User extends Authenticatable
{
    use HasFactory, HasApiTokens, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'image',
        'biography',
        'registration_type',
        'phone_number',
        'whatsapp_number',
        'specialization',
        'nationality', 
        'country_of_residence',
        'isAdmin',
        'passenger_name'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }
    public function visa()
    {
        return $this->hasOne(Visa::class);
    }
    public function flight()
    {
        return $this->hasOne(Flight::class, 'user_id', 'id');
    }
    // public function conferences()
    // {
    //     return $this->belongsToMany(Conference::class);
    // }
    public function conferences()
{
    return $this->belongsToMany(Conference::class, 'conference_user', 'user_id', 'conference_id');
}
// علاقة مع جدول DiscountOption
public function discountOptions()
{
    return $this->hasMany(DiscountOption::class);
}
public function airportTransferBooking()
{
    return $this->hasOne(AirportTransferBooking::class);
}
public function sponsors()
{
    return $this->hasMany(Sponsor::class);
}
public function attendances()
{
    return $this->hasMany(Attendance::class);
}

    protected $attributes = [
        'isAdmin' => false, 
    ];
}
