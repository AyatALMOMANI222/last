<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRoomsTable extends Migration
{
    public function up()
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reservation_id')->constrained()->onDelete('cascade'); // معرف الحجز مع حذف تلقائي
            $table->enum('room_type', ['Single', 'Double', 'Triple']); // نوع الغرفة
            $table->string('occupant_name'); // اسم المقيم
            $table->text('special_requests')->nullable(); // الطلبات الخاصة
            $table->decimal('cost', 10, 2); // تكلفة الغرفة
            $table->dateTime('update_deadline')->nullable(); // تاريخ التحديث
            $table->boolean('is_confirmed')->default(false); // تأكيد الغرفة
            $table->string('confirmation_message')->nullable(); // رسالة تأكيد حجز الفندق
            $table->string('confirmation_number');
                  
            $table->timestamp('last_speaker_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->timestamp('last_admin_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم

            $table->date('admin_update_deadline')->nullable();  // تاريخ آخر موعد للتحديث يحدده الأدمن

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('rooms');
    }
}
