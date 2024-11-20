<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoothCost extends Model
{
    use HasFactory;

    // تحديد الحقول القابلة للتعبئة
    protected $fillable = [
        'conference_id',
        'size',
        'cost',
        'lunch_invitations',
        'name_tags',
    ];

    /**
     * العلاقة مع جدول Conferences
     * 
     * هذه الدالة تربط BoothCost بجدول Conference باستخدام foreign key (conference_id).
     * كل BoothCost ينتمي إلى Conference.
     */
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }

    // يمكن إضافة دوال إضافية هنا إذا كنت بحاجة إلى تخصيص عمليات أو استعلامات خاصة.
}
