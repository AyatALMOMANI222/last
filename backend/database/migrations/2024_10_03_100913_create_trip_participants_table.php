<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTripParticipantsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('trip_participants', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable(); // عمود للربط مع جدول المستخدمين، يمكن أن يكون فارغًا
            $table->unsignedBigInteger('main_user_id')->nullable(); // عمود للمستخدم الرئيسي
            $table->unsignedBigInteger('trip_id'); // عمود للربط مع جدول الرحلات
            $table->string('name'); // اسم المشارك
            $table->string('nationality'); // الجنسية
            $table->string('phone_number'); // رقم الهاتف
            $table->string('whatsapp_number'); // رقم الواتساب
            $table->boolean('is_companion')->default(false); // تحديد ما إذا كان هو مرافق أم لا
            
             $table->boolean('include_accommodation')->default(false); // هل تشمل الإقامة؟
            // $table->string('accommodation_type')->nullable(); // نوع الإقامة (فندق أو خيمة)
            // $table->string('tent_type')->nullable(); // إضافة حقل نوع الخيمة مع كونه nullable
            $table->integer('accommodation_stars')->nullable(); // عدد النجوم للفندق
            $table->integer('nights_count')->nullable(); // عدد الليالي
            $table->date('check_in_date')->nullable(); // تاريخ بدء الإقامة
            $table->date('check_out_date')->nullable(); // تاريخ نهاية الإقامة
    
            // العلاقات
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('trip_id')->references('id')->on('trips')->onDelete('cascade');
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
        Schema::dropIfExists('trip_participants');
    }
}
