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
        Schema::table('users', function (Blueprint $table) {
            // Drop the foreign key constraint if it exists
            if (Schema::hasColumn('users', 'conference_id')) {
                $table->dropForeign(['conference_id']);  // Drop the foreign key constraint
            }
        });

        Schema::table('users', function (Blueprint $table) {
            // Make conference_id a nullable unsigned bigint column without foreign key constraint
            $table->unsignedBigInteger('conference_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Drop the conference_id column
            $table->dropColumn('conference_id');
        });
    }
};
