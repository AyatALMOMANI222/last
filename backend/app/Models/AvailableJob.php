<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AvailableJob extends Model
{
    use HasFactory;

    protected $table = 'available_jobs';

    protected $fillable = [
        'events_coordinator', // اسم الوظيفة
        'responsibilities', // المسؤوليات
        'description', // الوصف
    ];

    // علاقة "كثير إلى كثير" مع نموذج Applicant
    public function applicants()
    {
        return $this->belongsToMany(Applicant::class, 'applicant_job')
                    ->withPivot('status') // لإضافة العمود status من جدول الوسيط
                    ->withTimestamps(); // لتسجيل تاريخ الإنشاء والتحديث
    }
}
