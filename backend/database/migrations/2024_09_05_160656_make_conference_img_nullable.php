<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class MakeConferenceImgNullable extends Migration
{
    public function up()
    {
        Schema::table('conference_image', function (Blueprint $table) {
            $table->string('conference_img')->nullable()->change();
        });
    }

    public function down()
    {
        Schema::table('conference_image', function (Blueprint $table) {
            $table->string('conference_img')->nullable(false)->change();
        });
    }
}
