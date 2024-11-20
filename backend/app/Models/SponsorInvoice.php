<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SponsorInvoice extends Model
{
    use HasFactory;

    protected $table = 'sponsor_invoices';

    protected $fillable = [
        'user_name',
        'user_id',
        'conference_sponsorship_option_ids',
        'booth_cost_ids',
        'sponsorship_option_ids',
        'additional_cost_for_shell_scheme_booth',
        'conference_id',
        'total_amount',
        'price', // السعر
        'exhibit_number'
    ];

    // تحويل الأعمدة من نوع JSON إلى مصفوفات/كائنات
    protected $casts = [
        'conference_sponsorship_option_ids' => 'array',
        'booth_cost_ids' => 'array',
        'sponsorship_option_ids' => 'array',
        'additional_cost_for_shell_scheme_booth' => 'boolean',
        'total_amount' => 'decimal:2',
    ];

    /**
     * علاقة مع موديل User (علاقة Many-to-One).
     * كل فاتورة مرتبطة بمستخدم واحد.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

   
    public function conference()
    {
        return $this->belongsTo(Conference::class);
    }
    public function boothCosts()
    {
        return $this->hasMany(BoothCost::class, 'conference_id', 'conference_id');
    }

    // علاقة مع SponsorshipOption
    public function sponsorshipOptions()
    {
        return $this->hasMany(SponsorshipOption::class, 'conference_id', 'conference_id');
    }

    // علاقة مع Sponsorship
    public function sponsorships()
    {
        return $this->hasMany(Sponsorship::class, 'conference_id', 'conference_id');
    }
}