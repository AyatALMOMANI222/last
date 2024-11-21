<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddStatusToPrivateInvoiceTripsTable extends Migration
{
    public function up()
    {
        Schema::table('private_invoice_trips', function (Blueprint $table) {
            $table->string('status')->default('pending'); // Adjust the default value as needed
        });
    }

    public function down()
    {
        Schema::table('private_invoice_trips', function (Blueprint $table) {
            $table->dropColumn('status');
        });
    }
}
