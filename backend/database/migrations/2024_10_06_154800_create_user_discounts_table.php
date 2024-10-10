<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserDiscountsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('user_discounts', function (Blueprint $table) {
            $table->id(); // مفتاح رئيسي جديد
            $table->unsignedBigInteger('trip_participant_id');
            $table->unsignedBigInteger('option_id'); 
            $table->decimal('discount_value', 10, 2); 
            $table->boolean('show_price')->default(false);
            $table->foreignId('trip_id')->constrained('trips')->onDelete('cascade');

            // إضافة العلاقات
            $table->foreign('trip_participant_id')->references('id')->on('trip_participants')->onDelete('cascade');
            $table->foreign('option_id')->references('id')->on('additional_options')->onDelete('cascade');

            $table->timestamps(); // تواريخ الإنشاء والتعديل
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('user_discounts');
    }
}
