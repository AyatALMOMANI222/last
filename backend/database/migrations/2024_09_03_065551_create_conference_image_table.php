<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
        Schema::create('conference_image', function (Blueprint $table) {
            $table->id();
            $table->foreignId('conference_id')
                ->constrained('conferences', 'id') 
                ->onDelete('cascade');
            $table->text('conference_img');
            $table->timestamps();
        });
    }

    
    public function down(): void
    {
        Schema::dropIfExists('conference_image');
    }
};
