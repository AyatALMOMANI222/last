<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ModifyAdminUpdateDeadlineColumnInFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('flights', function (Blueprint $table) {
            // تغيير نوع العمود admin_update_deadline إلى dateTime
            $table->dateTime('admin_update_deadline')->change()->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('flights', function (Blueprint $table) {
            Schema::table('flights', function (Blueprint $table) {
                $table->dateTime('admin_update_deadline')->nullable()->change();
            });
                    });
    }
}
