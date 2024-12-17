<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('group_trip_participants', function (Blueprint $table) {
            $table->string('status')->default('pending'); // إضافة عمود status مع القيمة الافتراضية 'pending'

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('group_trip_participants', function (Blueprint $table) {
            //
        });
    }
};
