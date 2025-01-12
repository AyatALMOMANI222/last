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
        Schema::table('committee_members', function (Blueprint $table) {
            $table->string('country')->nullable(); // إضافة عمود country مع جعله nullable
        });
    }
    
    public function down()
    {
        Schema::table('committee_members', function (Blueprint $table) {
            $table->dropColumn('country'); // إلغاء العمود عند التراجع
        });
    }
    

  
};
