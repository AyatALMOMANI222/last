<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAcceptedFlightsTable extends Migration
{
    public function up()
    {
        Schema::create('accepted_flights', function (Blueprint $table) {
            $table->id('accepted_flight_id');  // معرّف الرحلة المقبولة (Primary Key)
            $table->foreignId('flight_id')->constrained('flights', 'flight_id')->onDelete('cascade');
            $table->decimal('price', 8, 2);  // سعر التذكرة
            
            $table->timestamp('admin_set_deadline')->nullable();  // تاريخ آخر موعد تحدده الإدارة
        
            $table->string('ticket_number')->nullable();  // رقم التذكرة
            $table->string('ticket_image')->nullable();  // صورة التذكرة
            $table->timestamp('issued_at')->nullable();  // تاريخ إصدار التذكرة
            $table->date('expiration_date')->nullable();  // تاريخ انتهاء صلاحية التذكرة
            $table->timestamps();  // تاريخ الإنشاء والتحديث
        });
    }

    public function down()
    {
        Schema::dropIfExists('accepted_flights'); 
    }
}
