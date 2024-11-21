<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTourismTripsTable extends Migration
{
    public function up()
    {
        Schema::create('الرحلات_السياحية', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('firstname');
            $table->string('lastname');
            $table->string('emailaddress');
            $table->string('phonenumber');
            $table->string('nationality');
            $table->string('country');
            $table->string('arrivalPoint');
            $table->string('departurePoint');
            $table->date('arrivalDate');
            $table->date('departureDate');
            $table->time('arrivalTime');
            $table->time('departureTime');
            $table->string('preferredHotel')->nullable();
            $table->integer('duration');
            $table->integer('adults');
            $table->integer('children');
            $table->json('preferredDestination'); // Array of preferred destinations
            $table->json('activities'); // Array of activities
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('الرحلات_السياحية');
    }
}
