<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTravelFormTable extends Migration
{
    /**
     * تشغيل الترحيل.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('travel_forms', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('firstName');
            $table->string('lastName');
            $table->string('email');
            $table->string('nationality');
            $table->string('cellular');
            $table->string('whatsapp');
            $table->date('arrivalDate');
            $table->date('departureDate');
            $table->string('hotelCategory');
            $table->string('hotelName');
            $table->integer('accompanyingPersons')->default(0);
            $table->decimal('totalUSD', 10, 2)->default(0.00);
            $table->string('roomType');
            $table->timestamps();
        });
    }

    /**
     * التراجع عن الترحيل.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('travel_forms');
    }
}
