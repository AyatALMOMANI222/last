<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Applicant extends Model
{
    use HasFactory;

    protected $table = 'applicants';

    protected $fillable = [
        'first_name',
        'last_name',
        'phone',
        'whatsapp_number',
        'email',
        'nationality',
        'home_address',
        'position_applied_for',
        'educational_qualification',
        'resume',
    ];

    // علاقة "كثير إلى كثير" مع نموذج AvailableJob
    public function jobs()
    {
        return $this->belongsToMany(AvailableJob::class, 'applicant_job')
                    ->withPivot('status') // لإضافة العمود status من جدول الوسيط
                    ->withTimestamps(); // لتسجيل تاريخ الإنشاء والتحديث
    }
}
