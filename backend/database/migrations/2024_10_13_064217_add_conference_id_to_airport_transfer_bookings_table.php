<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddConferenceIdToAirportTransferBookingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('airport_transfer_bookings', function (Blueprint $table) {
            $table->unsignedBigInteger('conference_id')->nullable()->after('id'); // إضافة حقل conference_id

            // إعداد المفتاح الخارجي
            $table->foreign('conference_id')
                ->references('id')
                ->on('conferences')
                ->onDelete('cascade'); // عند حذف المؤتمر، يتم حذف الحجوزات المرتبطة
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('airport_transfer_bookings', function (Blueprint $table) {
            $table->dropForeign(['conference_id']); // حذف المفتاح الخارجي
            $table->dropColumn('conference_id'); // حذف العمود
        });
    }
}
