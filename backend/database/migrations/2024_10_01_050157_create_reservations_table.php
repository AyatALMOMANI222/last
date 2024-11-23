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
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained();
            $table->integer('room_count')->default(1)->nullable(); // عدد الغرف المطلوبة
            $table->integer('companions_count')->default(0);
            $table->text('companions_names')->nullable(); // تخزين أسماء المرافقين كنص طويل مفصول بفواصل
            $table->boolean('is_delete')->default(false);
            $table->foreignId('conference_id')->nullable()->constrained('conferences')->onDelete('cascade');

            $table->timestamps();
        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reservations');
    }
};
