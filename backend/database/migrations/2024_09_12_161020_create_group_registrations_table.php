<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGroupRegistrationsTable extends Migration
{
    public function up()
    {
        Schema::create('group_registrations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // ربط بالتسجيل الأساسي
            // $table->string('organization_name')->nullable(); // اسم المنظمة
            $table->string('contact_person')->nullable(); // اسم الشخص المعني
            // $table->string('contact_email')->nullable(); // بريد إلكتروني للتواصل
            // $table->string('contact_phone')->nullable(); // رقم هاتف للتواصل
            $table->integer('number_of_doctors')->nullable(); // عدد الأطباء المسجلين


            
            $table->boolean('is_active')->default(false); // حالة التسجيل
            $table->timestamp('update_deadline')->nullable(); // تاريخ انتهاء تحديث القائمة
       
            $table->string('excel_file')->nullable(); // ملف إكسل للأسماء المسجلة

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('group_registrations');
    }
}
