<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
 
    public function up()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            $table->decimal('companion_price', 8, 2)->nullable();// Adding companion price column
        });
    }
    
    public function down()
    {
        Schema::table('dinner_attendees', function (Blueprint $table) {
            $table->dropColumn('companion_price');
        });
    }
};
