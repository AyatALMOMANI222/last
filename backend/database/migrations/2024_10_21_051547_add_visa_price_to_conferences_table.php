<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('conferences', function (Blueprint $table) {
            // إضافة عمود VisaPrice من النوع decimal مع 8 أرقام و2 بعد الفاصلة
            $table->decimal('VisaPrice', 8, 2)->nullable(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('conferences', function (Blueprint $table) {
            //
        });
    }
};
