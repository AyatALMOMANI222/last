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
        Schema::table('exhibitions', function (Blueprint $table) {
  $table->unsignedBigInteger('conference_id')->nullable();

  $table->foreign('conference_id')->references('id')->on('conferences')->onDelete('set null');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('exhibitions', function (Blueprint $table) {
            //
        });
    }
};