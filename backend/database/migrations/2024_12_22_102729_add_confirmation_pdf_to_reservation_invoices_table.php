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
        Schema::table('reservation_invoices', function (Blueprint $table) {
            $table->string('confirmationPDF')->nullable(); // إضافة العمود الجديد

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('reservation_invoices', function (Blueprint $table) {
            //
        });
    }
};