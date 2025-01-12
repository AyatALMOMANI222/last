<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddFlightDetailsToAvailableFlights extends Migration
{
    public function up()
    {
        Schema::table('available_flights', function (Blueprint $table) {
            // تفاصيل الرحلة المغادرة
            $table->string('departure_flight_number')->nullable();  // رقم الرحلة المغادرة
            $table->string('departure_airport')->nullable();  // مطار المغادرة

            // تفاصيل الرحلة الوصول
            $table->string('arrival_flight_number')->nullable();  // رقم الرحلة الوصول
            $table->date('arrival_date')->nullable();  // تاريخ الرحلة الوصول
            $table->time('arrival_time')->nullable();  // وقت الرحلة الوصول
            $table->string('arrival_airport')->nullable();  // مطار الوصول
            
        });
    }

    public function down()
    {
        Schema::table('available_flights', function (Blueprint $table) {
            // إزالة الأعمدة التي تم إضافتها
            $table->dropColumn('departure_flight_number');
            $table->dropColumn('departure_airport');
            $table->dropColumn('arrival_flight_number');
            $table->dropColumn('arrival_date');
            $table->dropColumn('arrival_time');
            $table->dropColumn('arrival_airport');
        });
    }
}
