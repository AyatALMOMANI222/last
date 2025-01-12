<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMultiplyByNightsToAdditionalOptionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('additional_options', function (Blueprint $table) {
            $table->boolean('multiply_by_nights')->default(false)->after('price'); // Add the new column
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('additional_options', function (Blueprint $table) {
            $table->dropColumn('multiply_by_nights'); // Drop the column on rollback
        });
    }
}
