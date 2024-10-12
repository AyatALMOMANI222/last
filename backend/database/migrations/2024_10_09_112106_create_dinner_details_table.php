<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDinnerDetailsTable extends Migration
{
    public function up()
    {
        Schema::create('dinner_details', function (Blueprint $table) {
            $table->id(); // Primary Key
              $table->foreignId('conference_id') 
            ->constrained('conferences')  
            ->onDelete('cascade');    
            $table->dateTime('dinner_date')->nullable(); // تاريخ العشاء
            $table->string('restaurant_name')->nullable(); // اسم المطعم
            $table->string('location')->nullable(); // مكان العشاء
            $table->string('gathering_place')->nullable(); // مكان التجمع
            $table->string('transportation_method')->nullable(); // وسيلة النقل (باص أو غيره)
            $table->time('gathering_time')->nullable(); // ساعة التجمع
            $table->time('dinner_time')->nullable(); // ساعة العشاء
            $table->integer('duration')->nullable(); // مدة العشاء بالدقائق
            $table->string('dress_code')->nullable(); // نوع اللباس
            $table->timestamps(); // Created and updated timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('dinner_details');
    }
}
