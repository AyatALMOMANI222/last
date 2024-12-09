<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAirportTransfersInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('airport_transfers_invoices', function (Blueprint $table) {
            $table->id();  // Auto-incrementing 'id'
            $table->unsignedBigInteger('airport_transfer_booking_id');  // Foreign key column
            $table->decimal('total_price', 8, 2);  // Total price for the invoice
            $table->enum('status', ['pending', 'paid', 'cancelled'])->default('pending');  // Status of the invoice
            $table->timestamps();  // Created_at and updated_at timestamps

            // Foreign key constraint to relate the invoice with an airport transfer booking
            $table->foreign('airport_transfer_booking_id')->references('id')->on('airport_transfer_bookings')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('airport_transfers_invoices');
    }
}
