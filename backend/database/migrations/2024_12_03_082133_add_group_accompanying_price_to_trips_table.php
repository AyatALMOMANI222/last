<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('trips', function (Blueprint $table) {
            // إضافة عمود سعر المرافق للرحلة الجماعية
            $table->decimal('group_accompanying_price', 10, 2)->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('trips', function (Blueprint $table) {
            // حذف عمود سعر المرافق للرحلة الجماعية إذا تم التراجع عن الترحيل
            $table->dropColumn('group_accompanying_price');
        });
    }
};
