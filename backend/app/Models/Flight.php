<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Flight extends Model
{
    use HasFactory;

    protected $table = 'flights';  // اسم الجدول

    protected $primaryKey = 'flight_id';  // المفتاح الأساسي

    protected $fillable = [
        'user_id',
        'is_companion',
        'main_user_id',
        'passport_image',
        'departure_airport',
        'arrival_airport',
        'departure_date',
        'arrival_date',
        'flight_number',
        'seat_preference',
        'upgrade_class',
        'ticket_count',
        'additional_requests',
        'admin_update_deadline',
        'last_update_at',
        'last_admin_update_at', // تأكد من إضافته
        'is_deleted',
        'passenger_name',
        'business_class_upgrade_cost', // إضافة الحقول هنا
        'reserved_seat_cost',
        'additional_baggage_cost',
        'other_additional_costs',
        'is_free',
        'ticket_number',
        'is_available_for_download',
        'valid_from',
        'valid_until',
        'download_url',
    ];
    

    public function availableFlights()
    {
        return $this->hasMany(AvailableFlight::class, 'flight_id', 'flight_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function acceptedFlights()
    {
        return $this->hasOne(AcceptedFlight::class, 'flight_id', 'flight_id');
    }

    // علاقة ذاتية
    public function mainUser()
    {
        return $this->belongsTo(Flight::class, 'main_user_id', 'flight_id');
    }
    protected $casts = [
        'main_user_id' => 'integer',
    ];


    public static function boot()
{
    parent::boot();

    static::updating(function ($flight) {
        $user = Auth::user(); // الحصول على المستخدم الحالي
        
        if ($user) {
            // إذا كان المستخدم هو المتحدث
            if ($user->id == $flight->user_id) {
                $flight->last_speaker_update_at = \Carbon\Carbon::now('Asia/Amman');
            }

            // إذا كان المستخدم هو الأدمن
            if ($user->is_admin) {
                $flight->last_speaker_update_at = \Carbon\Carbon::now('Asia/Amman');
            }
        }
    });
}

}
