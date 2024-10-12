<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSpeakersTable extends Migration
{
    public function up()
    {
        Schema::create('speakers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // ربط المتحدث بجدول المستخدمين
            $table->foreignId('conference_id')->constrained('conferences')->onDelete('cascade'); // ربط المؤتمر
            $table->string('abstract')->nullable(); // مسار ملف PDF للورقة العلمية
            $table->text('topics')->nullable(); // المواضيع التي سيتم التحدث عنها
            $table->string('presentation_file')->nullable(); // ملف PowerPoint
            $table->boolean('online_participation')->default(false); // الحضور عبر الإنترنت
            $table->boolean('is_online_approved')->default(false); // هل وافق الإداري على الحضور عبر الإنترنت
            $table->boolean('accommodation_status')->default(false); // حالة الإقامة (مجانية أم مدفوعة)
            $table->boolean('ticket_status')->default(false); // حالة التذكرة (مجانية أم مدفوعة)
            $table->boolean('dinner_invitation')->default(false); // دعوة العشاء
            $table->boolean('airport_pickup')->default(false); // استلام من المطار
            $table->boolean('free_trip')->default(false); // رحلة مجانية
            $table->string('certificate_file')->nullable(); // رابط تحميل الشهادة
            $table->boolean('is_certificate_active')->default(false); // هل الشهادة متاحة للتحميل
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('speakers');
    }
}
