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
        Schema::table('conferences', function (Blueprint $table) {
            $table->decimal('companion_dinner_price', 8, 2)->nullable()->after('conference_scientific_program_pdf')->comment('Price for companion dinner');
        });
    }
    
    public function down(): void
    {
        Schema::table('conferences', function (Blueprint $table) {
            $table->dropColumn('companion_dinner_price');
        });
    }
    
};
