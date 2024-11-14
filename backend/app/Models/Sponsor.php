<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Sponsor extends Model
{
  
    use HasFactory, HasApiTokens, Notifiable;

    // تعريف الجداول القابلة للتعبئة
    protected $fillable = [
        'user_id',
        'company_name',
        'contact_person',
        'company_address',
        'password'
    ];

    // العلاقة مع جدول المستخدمين
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    protected function casts(): array
    {
        return [
            'password' => 'hashed',
        ];
    }
}
