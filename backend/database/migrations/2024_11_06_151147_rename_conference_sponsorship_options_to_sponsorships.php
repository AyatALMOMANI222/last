<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RenameConferenceSponsorshipOptionsToSponsorships extends Migration
{
    public function up()
    {
        Schema::rename('conference_sponsorship_options', 'sponsorships');
    }

    public function down()
    {
        Schema::rename('sponsorships', 'conference_sponsorship_options');
    }
}
