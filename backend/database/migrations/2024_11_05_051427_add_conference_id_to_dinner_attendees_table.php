<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            $table->unsignedBigInteger('conference_id')->nullable(); // Add the conference_id column
        });
    }

    public function down()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            // Check if the column exists before attempting to drop it
            if (Schema::hasColumn('dinner_attendees', 'conference_id')) {
                $table->dropColumn('conference_id'); // Remove the conference_id column
            }
        });
    }
};
