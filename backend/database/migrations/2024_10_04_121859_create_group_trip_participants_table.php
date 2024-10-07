<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('group_trip_participants', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable(); // عمود للربط مع جدول المستخدمين
            $table->unsignedBigInteger('trip_id'); // عمود للربط مع جدول الرحلات
            $table->date('selected_date'); // التاريخ الذي اختاره المشارك
            $table->integer('companions_count')->default(0); // عدد المرافقين
           
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null'); // تعيين إلى null عند حذف المستخدم
            $table->foreign('trip_id')->references('id')->on('trips')->onDelete('cascade'); // حذف المشارك عند حذف الرحلة
            $table->decimal('total_price', 10, 2)->default(0); // إجمالي السعر

          
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('group_trip_participants');
    }
};
