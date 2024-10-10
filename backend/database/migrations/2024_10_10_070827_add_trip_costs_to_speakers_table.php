<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTripCostsToSpeakersTable extends Migration
{
    public function up()
    {
        Schema::table('speakers', function (Blueprint $table) {
            $table->decimal('cost_airport_to_hotel', 10, 2)->nullable(); // تكلفة الرحلة من المطار إلى الفندق
            $table->decimal('cost_hotel_to_airport', 10, 2)->nullable(); // تكلفة الرحلة من الفندق إلى المطار
            $table->decimal('cost_round_trip', 10, 2)->nullable(); // تكلفة الرحلتين (من وإلى المطار)
        });
    }

    public function down()
    {
        Schema::table('speakers', function (Blueprint $table) {
            $table->dropColumn('cost_airport_to_hotel');
            $table->dropColumn('cost_hotel_to_airport');
            $table->dropColumn('cost_round_trip');
        });
    }
}
