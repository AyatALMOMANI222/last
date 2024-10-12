<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('trip_options_participants', function (Blueprint $table) {
            $table->id(); 
            $table->foreignId('trip_id')->constrained('trips')->onDelete('cascade');
            $table->foreignId('option_id')->constrained('additional_options')->onDelete('cascade');
            $table->foreignId('participant_id')->constrained('trip_participants')->onDelete('cascade');
            $table->timestamps(); // Timestamps for created_at and updated_at
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('trip_options_participants');
    }
};
