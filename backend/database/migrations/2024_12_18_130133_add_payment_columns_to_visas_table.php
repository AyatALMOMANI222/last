<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddPaymentColumnsToVisasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up(): void
    {
        Schema::table('visas', function (Blueprint $table) {
            // إضافة الأعمدة الجديدة
            $table->decimal('payment_amount', 8, 2)->nullable(); // مبلغ الدفع
            $table->string('payment_method')->nullable(); // طريقة الدفع
            $table->enum('payment_status', ['pending', 'completed', 'failed'])->default('pending'); // حالة الدفع
            $table->string('transaction_id')->nullable(); // رقم المعاملة
            $table->timestamp('payment_date')->nullable(); // تاريخ الدفع
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down(): void
    {
        Schema::table('visas', function (Blueprint $table) {
            // حذف الأعمدة إذا تم التراجع عن الترحيل
            $table->dropColumn(['payment_amount', 'payment_method', 'payment_status', 'transaction_id', 'payment_date']);
        });
    }
}
