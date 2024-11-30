<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   
    public function up(): void
    {
        Schema::create('conferences', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->string('location');
            $table->enum('status', ['upcoming', 'past']); 
            $table->longText('image')->nullable(); 
            $table->longText('first_announcement_pdf')->nullable(); 
            $table->longText('second_announcement_pdf')->nullable(); 
            $table->longText('conference_brochure_pdf')->nullable(); 
            $table->longText('conference_scientific_program_pdf')->nullable();
            $table->timestamps();
        });
    }

   
    public function down(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::dropIfExists('conferences');
        Schema::enableForeignKeyConstraints();
    }
    
};