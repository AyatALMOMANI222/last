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
        Schema::table('sponsor_invoices', function (Blueprint $table) {
            $table->decimal('shell_scheme_price', 10, 2)->nullable(); // إضافة الحقل الجديد

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sponsor_invoices', function (Blueprint $table) {
            //
        });
    }
};
