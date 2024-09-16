<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sponsor extends Model
{
    use HasFactory;

    // تعريف الجداول القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'company_name',
        'contact_person',
        'company_address',
    ];

    // العلاقة مع جدول المستخدمين
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
