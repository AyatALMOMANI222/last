<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            $table->unsignedBigInteger('conference_id')->nullable(); // إضافة عمود conference_id كـ رقم عادي ويمكن أن يكون فارغًا
        });
    }

    public function down()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            $table->dropForeign(['conference_id']); // إزالة الـ Foreign Key
            $table->dropColumn('conference_id'); // إزالة العمود
        });
    }
};
