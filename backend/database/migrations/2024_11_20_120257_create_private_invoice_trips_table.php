<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePrivateInvoiceTripsTable extends Migration
{
    public function up()
    {
        Schema::create('private_invoice_trips', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('participant_id');
            $table->decimal('base_price', 8, 2);
            $table->decimal('options_price', 8, 2);
            $table->decimal('total_price', 8, 2);
            $table->timestamps();

            // Foreign Key Constraint
            $table->foreign('participant_id')->references('id')->on('trip_participants')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('private_invoice_trips');
    }
}
