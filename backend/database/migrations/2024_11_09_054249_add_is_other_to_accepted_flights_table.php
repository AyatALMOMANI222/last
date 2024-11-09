<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddIsOtherToAcceptedFlightsTable extends Migration
{
    public function up()
    {
        Schema::table('accepted_flights', function (Blueprint $table) {
            $table->boolean('isOther')->default(false)->after('expiration_date');
        });
    }

    public function down()
    {
        Schema::table('accepted_flights', function (Blueprint $table) {
            $table->dropColumn('isOther');
        });
    }
}
