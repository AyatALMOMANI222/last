<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reservation_id')->constrained()->onDelete('cascade'); // معرف الحجز مع حذف تلقائي
            $table->enum('room_type', ['Single', 'Double', 'Triple']); // نوع الغرفة
            $table->string('occupant_name')->nullable(); // اسم المقيم
            $table->text('special_requests')->nullable(); // الطلبات الخاصة
            $table->dateTime('check_in_date'); // موعد القدوم
            $table->dateTime('check_out_date'); // موعد المغادرة
            $table->boolean('late_check_out')->default(false); // Late Check Out
            $table->boolean('early_check_in')->default(false); // Early Check In
            $table->integer('total_nights'); // عدد الليالي
            $table->enum('user_type', ['main', 'companion']);


            $table->boolean('is_delete')->default(false);

            $table->decimal('cost', 10, 2)->nullable(); // تكلفة الغرفة
            $table->decimal('additional_cost', 10, 2)->default(0.00)->nullable(); // التكاليف الإضافية
            $table->dateTime('update_deadline')->nullable(); // تاريخ التحديث
            $table->boolean('is_confirmed')->default(false)->nullable(); // تأكيد الغرفة
            $table->text('confirmation_message_pdf')->nullable(); // رسالة تأكيد حجز الفندق
            
            $table->timestamp('last_user_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->timestamp('last_admin_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
