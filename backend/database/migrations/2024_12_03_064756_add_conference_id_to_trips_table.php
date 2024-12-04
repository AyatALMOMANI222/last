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
        Schema::table('trips', function (Blueprint $table) {
            $table->unsignedBigInteger('conference_id')->nullable()->after('id');

            // إذا كنت تحتاج إلى ربط المؤتمر بجداول أخرى
            $table->foreign('conference_id')
                ->references('id')
                ->on('conferences')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('trips', function (Blueprint $table) {
            // إزالة العلاقة والحقل عند التراجع
            $table->dropForeign(['conference_id']);
            $table->dropColumn('conference_id');
        });
    }
};
