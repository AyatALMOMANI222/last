<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Conference extends Model
{
    use HasFactory;
    protected $table = 'conferences';
    protected $fillable = [
        'title',
        'description',
        'start_date',
        'end_date',
        'location',
        'status',
        'image',
        'first_announcement_pdf',
        'second_announcement_pdf',
        'conference_brochure_pdf',
        'conference_scientific_program_pdf',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'status' => 'string',
    ];
        public function images()
        {
            return $this->hasMany(ConferenceImage::class, 'conference_id');
        }
        public function committeeMembers()
        {
            return $this->hasMany(CommitteeMember::class);
        }
        public function scientificTopics()
        {
            return $this->hasMany(ScientificTopic::class);
        }
        public function prices()
        {
            return $this->hasMany(ConferencePrice::class);
        }
        public function papers()
        {
            return $this->hasMany(Paper::class);
        }
    
}
