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
        Schema::table('speakers', function (Blueprint $table) {
            $table->string('room_type')->nullable(); // نوع الغرفة المغطاة
            $table->integer('nights_covered')->nullable(); // عدد الليالي المغطاة
        });
    }
    
    public function down()
    {
        Schema::table('speakers', function (Blueprint $table) {
            $table->dropColumn(['room_type', 'nights_covered']);
        });
    }
    
    /**
     * Reverse the migrations.
     */
  
};
