<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;

    protected $table = 'rooms';

    protected $fillable = [
        'reservation_id',
        'room_type',
        'occupant_name',
        'special_requests',
        'check_in_date',
        'check_out_date',
        'late_check_out',
        'early_check_in',
        'total_nights',
        'user_type',
        'is_delete',
        'cost',
        'additional_cost',
        'update_deadline',
        'is_confirmed',
        'confirmation_message_pdf',
        'last_user_update_at',
        'last_admin_update_at'
    ];

    protected $attributes = [
        'is_delete' => false,
        'late_check_out' => false,
        'early_check_in' => false,
        'is_confirmed' => false,
        'additional_cost' => 0.00
    ];

    protected $dates = [
        'check_in_date',
        'check_out_date',
        'update_deadline',
        'last_user_update_at',
        'last_admin_update_at',
        'created_at',
        'updated_at'
    ];

    public static function boot()
    {
        parent::boot();
    
        // عند الإنشاء، تعيين created_at فقط إذا كنت تريد تخصيصه
        static::creating(function ($room) {
            $room->created_at = Carbon::now('Asia/Amman'); // تعيين التوقيت الصحيح
        });
    
        // عند التحديث
        static::updating(function ($room) {
            // يتم تعيين updated_at تلقائيًا بواسطة Eloquent، ولكن يمكنك تخصيصه
            $room->updated_at = Carbon::now('Asia/Amman');
    
            // تحديد الحقول المتعلقة بتحديث الإداري والمستخدم
            $adminFields = ['cost', 'additional_cost', 'update_deadline', 'is_confirmed'];
            $userFields = ['room_type', 'occupant_name', 'special_requests', 'check_in_date', 'check_out_date', 'total_nights', 'late_check_out', 'early_check_in', 'user_type'];
    
            // تعيين last_admin_update_at عند تحديث الإداري
            if (count(array_intersect($adminFields, array_keys($room->getDirty()))) > 0) {
                $room->last_admin_update_at = Carbon::now('Asia/Amman');
            }
    
            // تعيين last_user_update_at عند تحديث المستخدم
            if (count(array_intersect($userFields, array_keys($room->getDirty()))) > 0) {
                $room->last_user_update_at = Carbon::now('Asia/Amman');
            }
        });
    }
    

    

    public function reservation()
    {
        return $this->belongsTo(Reservation::class, 'reservation_id');
    }
    public function reservationInvoices()
    {
        return $this->hasMany(ReservationInvoice::class);
    }
}
