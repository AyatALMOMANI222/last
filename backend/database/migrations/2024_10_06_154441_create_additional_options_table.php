<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdditionalOptionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('additional_options', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key (id)
            $table->foreignId('trip_id')->constrained('trips')->onDelete('cascade'); // Foreign key referencing trips(id) with cascade on delete
            $table->string('option_name', 255); // Option name, max length 255
            $table->text('option_description')->nullable(); // Option description as TEXT, nullable
            $table->decimal('price', 10, 2); // Price with 10 digits total, 2 after the decimal point
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('additional_options');
    }
}
