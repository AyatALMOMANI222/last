<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransportationRequestsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transportation_requests', function (Blueprint $table) {
            $table->id(); // معرف الطلب
            $table->string('first_name');
            $table->string('last_name');
            $table->string('email');
            $table->string('whatsapp');
            $table->integer('passengers');
            
            // تعديل الحقول لاختيار واحدة من القيم (pickup, drop off, or both)
            $table->enum('pickup_option', ['pickup', 'drop_off', 'both'])->default('pickup');
            
            $table->string('flight_code');
            $table->string('flight_time');
            $table->text('additional_info')->nullable();
            $table->decimal('total_usd', 8, 2); // قيمة الإجمالي بالدولار
            $table->timestamps(); // التاريخ والوقت لإنشاء وتحديث السجل
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transportation_requests');
    }
}
