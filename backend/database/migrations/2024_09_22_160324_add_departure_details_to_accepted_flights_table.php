<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddDepartureDetailsToAcceptedFlightsTable extends Migration
{
    public function up()
    {
        Schema::table('accepted_flights', function (Blueprint $table) {
            $table->date('departure_date')->nullable();  // السماح بترك الحقل فارغًا
            $table->boolean('is_free')->default(false);  // هل التذكرة مجانية
            $table->time('departure_time')->nullable();  // السماح بترك الحقل فارغًا
        });
    }

    public function down()
    {
        Schema::table('accepted_flights', function (Blueprint $table) {
            $table->dropColumn('departure_date');
            $table->dropColumn('is_free');
            $table->dropColumn('departure_time');
        });
    }
}
