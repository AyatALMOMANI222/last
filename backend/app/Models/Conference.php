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
        'visa_price',
        'companion_dinner_price'
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
        return $this->hasOne(Paper::class);
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
    public function sponsorshipOptions()
    {
        return $this->hasMany(SponsorshipOption::class);
    }
    // في نموذج Conference
    public function sponsorships()
    {
        return $this->hasMany(Sponsorship::class);
    }
    public function boothCosts()
    {
        return $this->hasMany(BoothCost::class); // تحديد العلاقة بين المؤتمر والأكشاك
    }
    public function sponsorInvoices()
    {
        return $this->hasMany(SponsorInvoice::class);
    }
    public function reservations()
    {
        return $this->hasMany(Reservation::class);
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
