<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
 
    public function up(): void
    {
        Schema::create('exhibitions', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('location');
            $table->date('start_date'); 
            $table->date('end_date')->nullable();
            $table->longText('image')->nullable(); 
            $table->enum('status', ['upcoming', 'past'])->default('upcoming'); // حالة المعرض: قادم أو سابق
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('exhibitions');
    }
};
