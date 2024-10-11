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
        Schema::table('dinner_attendees', function (Blueprint $table) {
            // حذف المفتاح الخارجي الحالي
            $table->dropForeign(['speaker_id']);
            
            // إعادة إنشاء المفتاح الخارجي مع onDelete('cascade')
            $table->foreign('speaker_id')
                  ->references('id')
                  ->on('speakers')
                  ->onDelete('cascade');
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            //
        });
    }
};
