<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReservationInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reservation_invoices', function (Blueprint $table) {
            $table->id(); // العمود الأساسي
            $table->unsignedBigInteger('room_id'); // مفتاح أجنبي للغرفة
            $table->decimal('price', 10, 2); // سعر الغرفة
            $table->decimal('additional_price', 10, 2)->default(0); // السعر الإضافي
            $table->decimal('late_check_out_price', 10, 2)->default(0); // السعر لتأخير الخروج
            $table->decimal('early_check_in_price', 10, 2)->default(0); // السعر للدخول المبكر
            $table->enum('status', ['approved', 'pending'])->default('pending'); // حالة الفاتورة (approved أو pending)
            $table->decimal('total', 10, 2); // الإجمالي
            $table->timestamps();

            // تعريف المفتاح الأجنبي
            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reservation_invoices');
    }
}
