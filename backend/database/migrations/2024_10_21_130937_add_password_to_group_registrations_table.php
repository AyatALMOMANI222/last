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
        Schema::table('group_registrations', function (Blueprint $table) {
            $table->string('password')->nullable(); // إضافة حقل كلمة المرور
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('group_registrations', function (Blueprint $table) {
            //
        });
    }
};