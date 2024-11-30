<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStandardBoothPackagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('standard_booth_packages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('conference_id')->nullable()->constrained('conferences')->onDelete('cascade'); // علاقة مع جدول conferences
            $table->string('floor_plan')->nullable(); // عمود لتخزين ملف PDF
            $table->timestamps(); // لتتبع وقت الإنشاء والتحديث
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('standard_booth_packages');
    }
}