<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('committee_members', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('committee_image')->nullable(); 
            $table->foreignId('conference_id') 
                ->constrained('conferences')
                ->onDelete('cascade');
            $table->timestamps();
        });
    }

 
    public function down(): void
    {
        Schema::dropIfExists('committee_members');
    }
};
