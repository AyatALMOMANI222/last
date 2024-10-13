<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAirportTransferPricesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('airport_transfer_prices', function (Blueprint $table) {
            $table->id(); // معرف فريد لكل سجل في الجدول
            $table->unsignedBigInteger('conference_id')->nullable(); // المفتاح الخارجي للمؤتمر
            $table->decimal('from_airport_price', 8, 2)->nullable(); // سعر التوصيل من المطار إلى الفندق
            $table->decimal('to_airport_price', 8, 2)->nullable(); // سعر التوصيل من الفندق إلى المطار
            $table->decimal('round_trip_price', 8, 2)->nullable(); // سعر رحلتين (ذهاب وإياب)
            $table->timestamps(); // لتتبع أوقات الإنشاء والتحديث

            // إعداد المفتاح الخارجي مع onDelete('cascade')
            $table->foreign('conference_id')
                  ->references('id')
                  ->on('conferences')
                  ->onDelete('cascade'); // عندما يتم حذف المؤتمر، يتم حذف السجلات المرتبطة بالتوصيل
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('airport_transfer_prices');
    }
}
