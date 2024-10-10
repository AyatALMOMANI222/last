<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAirportTransferBookingsTable extends Migration
{
    public function up()
    {
        Schema::create('airport_transfer_bookings', function (Blueprint $table) {
            $table->id(); // معرف فريد للحجز
            $table->enum('trip_type', ['One-way trip from the airport to the hotel', 'One-way trip from the hotel to the airport', 'Round trip'])->default('One-way trip from the airport to the hotel'); // نوع الرحلة
            $table->date('arrival_date'); // تاريخ الوصول
            $table->time('arrival_time'); // وقت الوصول
            $table->date('departure_date')->nullable(); // تاريخ المغادرة
            $table->time('departure_time')->nullable(); // وقت المغادرة
            $table->string('flight_number'); // رقم الرحلة
            $table->string('companion_name')->nullable(); // اسم المرافق
            $table->string('driver_name')->nullable(); // اسم السائق
            $table->string('driver_phone')->nullable(); // رقم هاتف السائق
            $table->timestamps(); // بيانات تاريخ الإنشاء والتحديث
        });
    }

    public function down()
    {
        Schema::dropIfExists('airport_transfer_bookings');
    }
}
