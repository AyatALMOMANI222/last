<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDinnerAttendeesTable extends Migration
{
    public function up()
    {
        Schema::create('dinner_attendees', function (Blueprint $table) {
            $table->id(); // Primary Key
            $table->foreignId('speaker_id')->constrained(); // Foreign Key linking to speakers table
            $table->string('companion_name')->nullable(); // اسم المرافق (إن وجد)
            $table->text('notes')->nullable(); // أي ملاحظات إضافية
            $table->boolean('paid')->default(true); // تحديد ما إذا كانت تكلفة المرافق قد تم دفعها
            $table->boolean('is_companion_fee_applicable')->default(false); // هل سعر المرافق ينطبق 
            $table->decimal('companion_fee', 8, 2)->nullable(); // سعر المرافق (ثابت لكل مؤتمر)
            $table->timestamps(); // Created and updated timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('dinner_attendees');
    }
}
