<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

    // تحديد الحقول المسموح بملئها
    protected $fillable = ['user_id', 'message', 'is_read','register_id','conference_id'];

    // العلاقة مع المستخدم (User)
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function notifiable()
    {
        return $this->morphTo();
    }
}

