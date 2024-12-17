<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DinnerAttendee extends Model
{
    use HasFactory;

    // اسم الجدول
    protected $table = 'dinner_attendees';

    // الحقول القابلة للتعبئة
    protected $fillable = [
        'speaker_id',
        'companion_name',
        'notes',
        'paid',
        'is_companion_fee_applicable',
        'companion_price',
        'conference_id',
    ];

    // العلاقة مع نموذج Speaker
    public function speaker()
    {
        return $this->belongsTo(Speaker::class);
    }

    // العلاقة مع نموذج DinnerAttendeesInvoice
    public function dinnerAttendeesInvoice()
    {
        return $this->hasOne(DinnerAttendeesInvoice::class, 'dinner_attendees_id');
    }
}
