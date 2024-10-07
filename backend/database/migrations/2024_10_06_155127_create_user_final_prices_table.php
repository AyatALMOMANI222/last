<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserFinalPricesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_final_prices', function (Blueprint $table) {
            // Defining the columns
            $table->unsignedBigInteger('trip_participant_id'); // Foreign key for trip participants
            $table->unsignedBigInteger('trip_id'); // Foreign key for trips
            $table->decimal('final_price', 10, 2); // Decimal column for final price
            $table->timestamp('created_at')->useCurrent(); // Created at with default value as the current timestamp

            // Setting the primary key as a composite key (trip_participant_id, trip_id)
            $table->primary(['trip_participant_id', 'trip_id']);

            // Defining the foreign keys
            $table->foreign('trip_participant_id')->references('id')->on('trip_participants')->onDelete('cascade'); // Foreign key for trip participants
            $table->foreign('trip_id')->references('id')->on('trips')->onDelete('cascade'); // Foreign key for trips
        });
    }


    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_final_prices');
    }
}
