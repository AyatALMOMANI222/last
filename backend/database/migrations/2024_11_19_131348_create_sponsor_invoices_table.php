<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('sponsor_invoices', function (Blueprint $table) {
            $table->id(); // عمود معرف الفاتورة
            $table->string('user_name')->nullable(); // اسم المستخدم
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // ربط بالتسجيل الأساسي
    
            $table->json('conference_sponsorship_option_ids')->nullable(); // خيارات رعاية المؤتمر
            $table->json('booth_cost_ids')->nullable(); // تكلفة الأكشاك
            $table->json('sponsorship_option_ids')->nullable(); // خيارات الرعاية
            $table->boolean('additional_cost_for_shell_scheme_booth')->default(false)->nullable(); // تكلفة إضافية لبوث النظام الصدفي
            $table->foreignId('conference_id')->constrained('conferences')->onDelete('cascade'); // ربط الفاتورة بالمؤتمر
            $table->decimal('total_amount', 10, 2)->nullable(); // إجمالي المبلغ: المجموع النهائي لجميع التكاليف
            
            // Adding the Exhibit Number column (nullable and type integer)
            $table->integer('exhibit_number')->nullable(); // رقم المعرض
            
            $table->timestamps(); // تاريخ الإنشاء والتحديث
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sponsor_invoices');
    }
};
