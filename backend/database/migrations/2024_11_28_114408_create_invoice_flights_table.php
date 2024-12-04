<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateInvoiceFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoice_flights', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('flight_id'); // تأكد من أن العمود flight_id من نفس النوع كالعمود id في جدول flights
            $table->foreign('flight_id')->references('flight_id')->on('flights')->onDelete('cascade'); // القيد الخارجي
            $table->decimal('total_price', 10, 2); // السعر الإجمالي
            $table->string('status'); // الحالة
            $table->timestamps();
        });
        
        
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('invoice_flights');
    }
}
