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
        Schema::create('invoice_flights', function (Blueprint $table) {
            $table->id();  // معرّف فريد للفاتورة
            $table->unsignedBigInteger('flight_id');  // معرّف الرحلة (مفتاح خارجي)

            $table->decimal('total_price', 10, 2);  // السعر الإجمالي
            $table->string('status');  // الحالة

            // إضافة القيد الخارجي
            $table->foreign('flight_id')->references('flight_id')->on('flights')->onDelete('cascade');

            $table->timestamps();  // تاريخ الإنشاء والتحديث
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('invoice_flights');
    }
};
