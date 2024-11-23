<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddLateCheckOutPriceAndEarlyCheckInPriceAndStatusToReservationInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('reservation_invoices', function (Blueprint $table) {
            // Add the new columns
            $table->decimal('late_check_out_price', 10, 2)->default(0); // السعر لتأخير الخروج
            $table->decimal('early_check_in_price', 10, 2)->default(0); // السعر للدخول المبكر
            $table->enum('status', ['approved', 'pending'])->default('pending'); // حالة الفاتورة (approved أو pending)
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('reservation_invoices', function (Blueprint $table) {
            // Drop the columns if the migration is rolled back
            $table->dropColumn('late_check_out_price');
            $table->dropColumn('early_check_in_price');
            $table->dropColumn('status');
        });
    }
}
