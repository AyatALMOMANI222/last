<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAvailableFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // عند القبول يتم التسجيل التكت بهذا الجدول
        Schema::create('available_flights', function (Blueprint $table) {
            $table->id('available_id');  // معرّف الرحلة المتاحة (Primary Key)
            $table->foreignId('flight_id')->constrained('flights', 'flight_id')->onDelete('cascade');  // معرّف الرحلة من جدول الرحلات (Foreign Key)

            $table->date('departure_date');  // تاريخ الرحلة
            $table->time('departure_time');  // وقت الرحلة
            $table->decimal('price', 8, 2);  // سعر التذكرة
            $table->boolean('is_free')->default(false);  // هل التذكرة مجانية
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
        Schema::dropIfExists('available_flights');
    }
}
