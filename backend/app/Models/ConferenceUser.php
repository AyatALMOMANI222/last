<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConferenceUser extends Model
{
    use HasFactory;

    // الجدول المرتبط بالموديل
    protected $table = 'conference_user';

    // الحقول القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'conference_id',
        'is_visa_payment_required'
    ];

    // العلاقة مع جدول users
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // العلاقة مع جدول conferences
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
}
