<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
        Schema::create('scientific_papers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('conference_id')->constrained()->onDelete('cascade'); 
            $table->string('author_name');
            $table->string('author_title'); 
            $table->string('email');
            $table->string('phone');
            $table->string('whatsapp')->nullable(); 
            $table->string('country');
            $table->string('nationality'); 
            $table->string('password'); 
            $table->string('file_path'); 
            $table->enum('status', ['under_review', 'accepted', 'rejected'])->default('under_review'); 
            $table->timestamps();
        });
    }

   
    public function down(): void
    {
        Schema::dropIfExists('papers');
    }
};
