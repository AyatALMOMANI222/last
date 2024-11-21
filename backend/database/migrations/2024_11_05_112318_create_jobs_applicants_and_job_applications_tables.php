<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateJobsApplicantsAndJobApplicationsTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // إنشاء جدول الوظائف
        Schema::create('available_jobs', function (Blueprint $table) {
            $table->id();
            $table->string('events_coordinator'); // اسم الوظيفة
            $table->text('responsibilities')->nullable(); // المسؤوليات
            $table->text('description')->nullable(); // الوصف
            $table->timestamps(); // تاريخ الإنشاء والتحديث
        });

        // إنشاء جدول المتقدمين مع الحقول المضافة
        Schema::create('applicants', function (Blueprint $table) {
            $table->id();
            $table->string('first_name'); // الاسم الأول
            $table->string('last_name'); // الاسم الأخير
            $table->string('phone', 20)->nullable(); // رقم الهاتف
            $table->string('whatsapp_number', 20)->nullable(); // رقم الواتساب
            $table->string('email')->unique(); // البريد الإلكتروني (فريد)
            $table->string('nationality')->nullable(); // الجنسية
            $table->string('home_address')->nullable(); // عنوان المنزل
            $table->string('position_applied_for'); // الوظيفة المتقدم لها
            $table->string('educational_qualification')->nullable(); // المؤهل التعليمي
            $table->string('resume')->nullable(); // مسار السيرة الذاتية (رفع CV)
            $table->timestamps(); // تاريخ الإنشاء والتحديث
        });

 
    Schema::create('applicant_job', function (Blueprint $table) {
        $table->id(); // معرف فريد
        $table->foreignId('applicant_id')->constrained('applicants')->onDelete('cascade'); // ربط بالجدول applicants
        $table->foreignId('job_id')->constrained('available_jobs')->onDelete('cascade'); // ربط بالجدول available_jobs
        $table->enum('status', ['Pending', 'Reviewed', 'Rejected'])->default('Pending'); // حالة الطلب
        $table->timestamps(); // تاريخ الإنشاء والتحديث
    });
}
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('job_applications');
        Schema::dropIfExists('applicants');
        Schema::dropIfExists('jobs');
    }
}
