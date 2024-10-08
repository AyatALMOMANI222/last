<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTripIdToUserDiscountsTable extends Migration
{
    /**
     * تشغيل الترحيل
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_discounts', function (Blueprint $table) {
            // إضافة العمود trip_id كـ foreign key مع الربط بجدول trips والحذف بالتسلسل (cascade)
            $table->foreignId('trip_id')->constrained('trips')->onDelete('cascade');
        });
    }

    /**
     * التراجع عن الترحيل
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_discounts', function (Blueprint $table) {
            // حذف العمود والعلاقة في حالة التراجع عن الترحيل
            $table->dropForeign(['trip_id']);
            $table->dropColumn('trip_id');
        });
    }
}
