<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ModifyTripParticipantsNullableColumns extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('trip_participants', function (Blueprint $table) {
            // جعل الأعمدة nullable
            $table->unsignedBigInteger('trip_id')->nullable()->change(); // عمود الربط مع جدول الرحلات
            $table->string('name')->nullable()->change(); // اسم المشارك
            $table->string('nationality')->nullable()->change(); // الجنسية
            $table->string('phone_number')->nullable()->change(); // رقم الهاتف
            $table->string('whatsapp_number')->nullable()->change(); // رقم الواتساب
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('trip_participants', function (Blueprint $table) {
            // إعادة الأعمدة كما كانت
            $table->unsignedBigInteger('trip_id')->nullable(false)->change(); // إعادة العمود غير nullable
            $table->string('name')->nullable(false)->change(); // إعادة العمود غير nullable
            $table->string('nationality')->nullable(false)->change(); // إعادة العمود غير nullable
            $table->string('phone_number')->nullable(false)->change(); // إعادة العمود غير nullable
            $table->string('whatsapp_number')->nullable(false)->change(); // إعادة العمود غير nullable
        });
    }
}
