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
        Schema::create('visas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // ID الخاص بالمتحدث
            $table->string('passport_image')->nullable(); // صورة جواز السفر
            $table->date('arrival_date')->nullable(); // تاريخ القدوم
            $table->date('departure_date')->nullable(); // تاريخ المغادرة
           
            $table->decimal('visa_cost', 8, 2)->nullable(); // تكلفة الفيزا
            $table->boolean('payment_required')->default(false); // إذا كان الدفع مطلوباً
            $table->enum('status', ['pending', 'approved', 'rejected'])->default('pending'); // حالة الفيزا
            $table->timestamp('visa_updated_at')->nullable(); // تاريخ آخر تحديث لحالة الفيزا
            $table->timestamps();



            // إضافة فهرس لـ user_id
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('visas');
    }
};
