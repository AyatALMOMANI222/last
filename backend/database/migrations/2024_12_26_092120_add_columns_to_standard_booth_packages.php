<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColumnsToStandardBoothPackages extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('standard_booth_packages', function (Blueprint $table) {
            $table->decimal('space_only_stand_price_usd', 10, 2);    
            $table->decimal('space_only_stand_depth', 10, 2);     
            $table->decimal('shell_scheme_price_per_sqm', 10, 2);
      
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('standard_booth_packages', function (Blueprint $table) {
            $table->dropColumn([
                'space_only_stand_price_usd',
                'space_only_stand_depth',
                'shell_scheme_price_per_sqm',
            ]);
        });
    }
}
