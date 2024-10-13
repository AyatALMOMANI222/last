<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DinnerSpeakerCompanionFee extends Model
{
    use HasFactory;

    protected $table = 'dinner_speaker_companion_fees';

    protected $fillable = [
        'dinner_id',
        'speaker_id',
        'companion_fee',
    ];


    public function dinnerDetail()
    {
        return $this->belongsTo(DinnerDetail::class, 'dinner_id'); // تأكد من اسم العلاقة هنا
    }
    public function speaker()
    {
        return $this->belongsTo(Speaker::class, 'speaker_id');
    }
}
