<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('papers', function (Blueprint $table) {
            $table->id(); // معرف فريد للورقة العلمية
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // ارتباط الورقة بمقدمها عبر مفتاح أجنبي
            $table->string('title'); // عنوان الورقة العلمية
            $table->string('abstract', 500)->nullable(); // ملخص الورقة العلمية (اختياري)
            $table->string('file_path'); // مسار الملف المرفوع للورقة العلمية
            $table->enum('status', ['under review', 'accepted', 'rejected'])->default('under review'); // حالة الورقة العلمية
            $table->timestamp('submitted_at')->nullable(); // وقت تقديم الورقة
            $table->foreignId('conference_id')->nullable()->constrained('conferences')->onDelete('cascade'); // إضافة عمود conference_id مع فرض علاقة مع جدول conferences

            $table->timestamps(); // حقول التسجيل الزمني
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('scientific_papers', function (Blueprint $table) {
            //
        });
    }
};
