<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAcceptedFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('accepted_flights', function (Blueprint $table) {
            $table->id('accepted_flight_id');  // معرّف الرحلة المقبولة (Primary Key)
            
            // تأكد من تطابق العمود مع العمود في جدول `flights`
            $table->unsignedBigInteger('flight_id'); // يجب أن يتطابق مع نوع العمود في جدول `flights`
            $table->foreign('flight_id')->references('flight_id')->on('flights')->onDelete('cascade');

            $table->decimal('price', 8, 2);  // سعر التذكرة المقبولة
            $table->date('departure_date');  // تاريخ الرحلة
            $table->time('departure_time');  // وقت الرحلة
            
            // معلومات تدخل من قبل الأدمن
            $table->timestamp('admin_set_deadline')->nullable();  // التاريخ والوقت الذي يحدده الأدمن لتوافر التذكرة
            
            // معلومات التذكرة المدخلة لاحقاً
            $table->string('ticket_number')->nullable();  // رقم التذكرة (إذا كان متاحاً)
            $table->string('ticket_image')->nullable();  // صورة التذكرة (إذا كان متاحاً)
            $table->timestamp('issued_at')->nullable();  // تاريخ إصدار التذكرة (إذا كان متاحاً)
            $table->timestamp('expiration_date')->nullable();  // تاريخ انتهاء صلاحية التذكرة (إذا كان متاحاً)

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
        Schema::dropIfExists('accepted_flights');
    }
}
