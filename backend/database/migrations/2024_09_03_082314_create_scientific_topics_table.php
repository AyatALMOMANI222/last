<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
   
    public function up(): void
    {
        Schema::create('scientific_topics', function (Blueprint $table) {
            $table->id();
            $table->foreignId('conference_id')   
                ->constrained('conferences')     
                ->onDelete('cascade');          
            $table->string('title');            
            $table->text('description')->nullable(); 
            $table->string('speaker_names')->nullable(); 
            $table->text('goal')->nullable();    
            $table->timestamps();
        });
    }

 
    public function down(): void
    {
        Schema::dropIfExists('scientific_topics');
    }
};
