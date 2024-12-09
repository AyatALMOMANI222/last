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
        Schema::table('speakers', function (Blueprint $table) {
            $table->boolean('is_visa_payment_required')->default(true); // إضافة عمود is_visa_payment_required

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('speakers', function (Blueprint $table) {
            //
        });
    }
};
