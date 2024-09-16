<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
  
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // إضافة الأعمدة الجديدة للجدول الموجود
            $table->longText('image')->nullable();
            $table->text('biography')->nullable();
            $table->enum('registration_type', ['speaker', 'attendance', 'sponsor', 'group_registration'])->nullable();
            $table->string('phone_number');
            $table->string('whatsapp_number');
            $table->string('specialization')->nullable();
            $table->string('nationality')->nullable();
            $table->string('country_of_residence')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['image', 'biography', 'registration_type', 'phone_number', 'whatsapp_number', 'specialization', 'nationality', 'country_of_residence']);
        });
    }
};
