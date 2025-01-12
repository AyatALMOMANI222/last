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
        Schema::table('sponsorships', function (Blueprint $table) {
            $table->string('video_show_between_sessions')->nullable(); // إضافة حقل video_show_between_sessions
        });
    }
    
    public function down()
    {
        Schema::table('sponsorships', function (Blueprint $table) {
            $table->dropColumn('video_show_between_sessions'); // إلغاء الحقل إذا تم التراجع عن الترحيل
        });
    }
    
};
