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
            $table->dateTime('dinner_date'); // تاريخ العشاء
            $table->string('restaurant_name'); // اسم المطعم
            $table->string('location'); // مكان العشاء
            $table->string('gathering_place'); // مكان التجمع
            $table->string('transportation_method'); // وسيلة النقل (باص أو غيره)
            $table->time('gathering_time'); // ساعة التجمع
            $table->time('dinner_time'); // ساعة العشاء
            $table->integer('duration'); // مدة العشاء بالدقائق
            $table->string('dress_code'); // نوع اللباس
            $table->timestamps(); // Created and updated timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('dinner_details');
    }
}
