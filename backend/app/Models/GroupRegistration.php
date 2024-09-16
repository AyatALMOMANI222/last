<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GroupRegistration extends Model
{
    use HasFactory;

    // تعريف الجداول القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'organization_name',
        'contact_person',
        'contact_email',
        'contact_phone',
        'number_of_doctors',
        'excel_file',
        'is_active',
        'update_deadline',
    ];

    // العلاقة مع جدول المستخدمين
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
