<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('papers', function (Blueprint $table) {
            $table->foreignId('conference_id')->nullable()->constrained()->onDelete('set null'); // إضافة عمود conference_id
        });
    }

    public function down(): void
    {
        Schema::table('papers', function (Blueprint $table) {
            $table->dropForeign(['conference_id']); // حذف المفتاح الأجنبي
            $table->dropColumn('conference_id'); // حذف العمود
        });
    }
};
