<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAttendanceTable extends Migration
{
    public function up()
    {
        Schema::create('attendance', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // ربط المسجل بجدول المستخدمين
            $table->foreignId('conference_id')->constrained('conferences')->onDelete('cascade'); // ربط المؤتمر
            $table->decimal('registration_fee', 8, 2)->nullable(); // سعر التسجيل - nullable
            $table->boolean('includes_conference_bag')->nullable()->default(true); // حقيبة المؤتمر - nullable
            $table->boolean('includes_conference_badge')->nullable()->default(true); // باجة المؤتمر - nullable
            $table->boolean('includes_conference_book')->nullable()->default(true); // كتيب المؤتمر - nullable
            $table->boolean('includes_certificate')->nullable()->default(true); // الشهادة العلمية - nullable
            $table->boolean('includes_lecture_attendance')->nullable()->default(true); // حضور محاضرات المؤتمر - nullable
            $table->timestamps();
        });
    }

}
