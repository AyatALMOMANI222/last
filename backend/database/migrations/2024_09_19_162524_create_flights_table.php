<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('flights', function (Blueprint $table) {
            $table->id('flight_id');  // معرّف الرحلة (Primary Key)
            $table->foreignId('user_id')->constrained('users');  // معرّف المستخدم (Foreign Key)
        
            $table->boolean('is_companion')->default(false);  // هل هو مرافق أم لا
            $table->unsignedBigInteger('main_user_id')->nullable();

         
            $table->string('passport_image')->nullable();  // صورة جواز السفر
            $table->string('departure_airport', 100);  // مطار المغادرة
            $table->string('arrival_airport', 100);  // مطار العودة
            $table->date('departure_date');  // تاريخ القدوم
            $table->date('arrival_date');  // تاريخ المغادرة
           
            $table->text('flight_number')->nullable();  // رقم الطائرة (إذا كان متاحاً)
            $table->string('seat_preference', 50)->nullable();  // تفضيل المقعد (إذا كان متاحاً)
            $table->boolean('upgrade_class')->default(false);  // طلب رفع درجة الرحلة
            $table->integer('ticket_count');  // عدد التذاكر المطلوبة
            $table->text('additional_requests')->nullable();  // طلبات خاصة متعلقة برحلة الطيران (اختياري)
            $table->string('passenger_name')->nullable();  // اسم المسافر (اختياري)
            $table->boolean('is_deleted')->default(false);  // حالة الحذف المنطقي

           
            $table->timestamp('last_speaker_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->timestamp('last_admin_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم

         

            $table->decimal('business_class_upgrade_cost', 8, 2)->nullable()->default(0.00);  
            $table->decimal('reserved_seat_cost', 8, 2)->nullable()->default(0.00);  
            $table->decimal('additional_baggage_cost', 8, 2)->nullable()->default(0.00);  
            $table->decimal('other_additional_costs', 8, 2)->nullable()->default(0.00);  

            $table->date('admin_update_deadline')->nullable();  // تاريخ آخر موعد للتحديث يحدده الأدمن
           


            $table->boolean('is_free')->default(false);  // هل التذكرة مجانية أم لا
            $table->string('ticket_number')->nullable();  // رقم التذكرة
            $table->boolean('is_available_for_download')->default(false);  // هل التذكرة متاحة للتحميل
            $table->date('valid_from')->nullable();  // تاريخ بدء صلاحية التذكرة
            $table->date('valid_until')->nullable();  // تاريخ انتهاء صلاحية التذكرة
            $table->string('download_url')->nullable();  // رابط تحميل التذكرة
            $table->timestamps();  // تاريخ الإنشاء والتحديث
        });
    }
    
    

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('flights');
    }
}
