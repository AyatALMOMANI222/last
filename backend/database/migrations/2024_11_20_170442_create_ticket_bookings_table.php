<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketBookingsTable extends Migration
{
    public function up()
    {
        Schema::create('ticket_bookings', function (Blueprint $table) {
            $table->id(); // العمود الأساسي
            $table->string('title');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('nationality');
            $table->string('email')->unique();
            $table->string('cellular');
            $table->string('whatsapp');
            $table->date('departure_date');
            $table->date('arrival_date');
            $table->time('arrival_time');
            $table->time('departure_time');
            $table->string('preferred_airline');
            $table->string('departure_from');
            $table->string('passport_copy'); // هنا يمكنك حفظ مسار الملف أو اسم الملف
            $table->timestamps(); // لتخزين بيانات التوقيت
        });
    }

    public function down()
    {
        Schema::dropIfExists('ticket_bookings');
    }
}
