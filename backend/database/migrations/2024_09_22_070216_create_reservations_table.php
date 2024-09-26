<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReservationsTable extends Migration
{
    public function up()
    {
        Schema::create('reservations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained();
            $table->dateTime('check_in_date'); // موعد القدوم
            $table->dateTime('check_out_date'); // موعد المغادرة
            $table->boolean('late_check_out')->default(false); // Late Check Out
            $table->boolean('early_check_in')->default(false); // Early Check In
       
       
            $table->decimal('additional_cost', 10, 2)->default(0.00); // التكاليف الإضافية
        
        
            $table->enum('user_type', ['main', 'companion']); // نوع المستخدم (أساسي أو مرافق)
            $table->integer('total_nights'); // عدد الليالي
            $table->integer('room_count')->default(1); // عدد الغرف المطلوبة
            $table->string('companions')->nullable(); // أسماء المرافقين مفصولة بفواصل
                 
            $table->timestamp('last_speaker_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->timestamp('last_admin_update_at')->nullable();  // تاريخ آخر تحديث قام به المستخدم
            $table->date('admin_update_deadline')->nullable();  // تاريخ آخر موعد للتحديث يحدده الأدمن

         
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('reservations');
    }
}
