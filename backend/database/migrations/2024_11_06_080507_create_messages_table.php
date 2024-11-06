<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMessagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('messages', function (Blueprint $table) {
            $table->id(); // معرف فريد لكل رسالة
            $table->string('name'); // اسم الشخص
            $table->string('email'); // البريد الإلكتروني
            $table->string('subject')->nullable(); // الموضوع (اختياري)
            $table->text('message'); // الرسالة
            $table->timestamps(); // timestamps (created_at, updated_at)
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('messages');
    }
}
