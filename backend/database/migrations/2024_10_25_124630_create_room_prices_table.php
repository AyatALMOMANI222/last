<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('room_prices', function (Blueprint $table) {
            $table->id();
            $table->enum('room_type', ['Single', 'Double', 'Triple'])->notNullable(); // نوع الغرفة
            $table->decimal('base_price', 10, 2)->notNullable(); // السعر الأساسي
            $table->decimal('companion_price', 10, 2)->notNullable(); // سعر المرافق
            $table->decimal('early_check_in_price', 10, 2)->notNullable(); // سعر الـ Early Check-In
            $table->decimal('late_check_out_price', 10, 2)->notNullable(); // سعر الـ Late Check-Out
            $table->unsignedBigInteger('conference_id')->nullable(); // حقل conference_id
            $table->foreign('conference_id')
                ->references('id')->on('conferences')
                ->onDelete('cascade'); // استخدام cascade عند الحذف
            $table->timestamps(); // timestamps for created_at and updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('room_prices');
    }
};
