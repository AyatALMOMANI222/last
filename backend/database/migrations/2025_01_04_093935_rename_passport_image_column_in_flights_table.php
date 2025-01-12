<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RenamePassportImageColumnInFlightsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('flights', function (Blueprint $table) {
            // تغيير اسم العمود من passport_image إلى passportImage
            $table->renameColumn('passport_image', 'passportImage');
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
            // الرجوع للتسمية القديمة إذا لزم الأمر
            $table->renameColumn('passportImage', 'passport_image');
        });
    }
}
