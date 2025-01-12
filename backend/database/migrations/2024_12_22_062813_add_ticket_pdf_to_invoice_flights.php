<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTicketPdfToInvoiceFlights extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // إضافة العمود ticketPDF إلى جدول invoice_flights
        Schema::table('invoice_flights', function (Blueprint $table) {
            $table->string('ticketPDF')->nullable(); // إضافة العمود الجديد
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // إزالة العمود ticketPDF في حال الرجوع عن الترحيل
        Schema::table('invoice_flights', function (Blueprint $table) {
            $table->dropColumn('ticketPDF');
        });
    }
}
