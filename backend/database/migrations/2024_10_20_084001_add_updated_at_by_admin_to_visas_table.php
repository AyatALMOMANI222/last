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
        Schema::table('visas', function (Blueprint $table) {
            // إضافة حقل updated_at_by_admin ليكون nullable
            $table->timestamp('updated_at_by_admin')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('visas', function (Blueprint $table) {
            // حذف الحقل عند التراجع عن الترحيل
            $table->dropColumn('updated_at_by_admin');
        });
    }
};
