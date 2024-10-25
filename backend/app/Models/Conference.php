<?php

namespace App\Models;

use Carbon\Carbon;
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
     
        public function exhibition()
        {
            return $this->hasOne(Exhibition::class, 'conference_id');
        }
        public function trips()
        {
            return $this->belongsToMany(Trip::class, 'conference_trip');
        }
        public function users()
        {
            return $this->belongsToMany(User::class, 'conference_user', 'conference_id', 'user_id');
        }
        public function dinnerDetail()
    {
        return $this->hasOne(DinnerDetail::class);
    }
    public function airportTransferBookings()
    {
        return $this->hasMany(AirportTransferBooking::class);
    }
    public function airportTransferPrice()
    {
        return $this->hasOne(AirportTransferPrice::class);
    }  
    public function attendances()
    {
        return $this->hasMany(Attendance::class);
    }
    public function roomPrices()
    {
        return $this->hasMany(RoomPrice::class); // علاقة واحد إلى كثير
    }
        public static function boot()
        {
            parent::boot();
    
            static::creating(function ($conference) {
                $conference->created_at = Carbon::now('Asia/Amman');
                $conference->updated_at = Carbon::now('Asia/Amman');
            });
    
            static::updating(function ($conference) {
                $conference->updated_at = Carbon::now('Asia/Amman');
            });
        }
    
}
