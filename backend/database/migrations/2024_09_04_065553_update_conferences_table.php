<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   
    public function up(): void
    {
        Schema::table('conferences', function (Blueprint $table) {
            $table->string('first_announcement_pdf')->nullable()->change();
            $table->string('second_announcement_pdf')->nullable()->change();
            $table->string('conference_brochure_pdf')->nullable()->change();
            $table->string('conference_scientific_program_pdf')->nullable()->change();
        });
    }

    
    public function down(): void
    {
        Schema::table('conferences', function (Blueprint $table) {
            $table->longText('first_announcement_pdf')->nullable()->change();
            $table->longText('second_announcement_pdf')->nullable()->change();
            $table->longText('conference_brochure_pdf')->nullable()->change();
            $table->longText('conference_scientific_program_pdf')->nullable()->change();
        });
    }
};
