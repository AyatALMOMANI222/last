<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSpeakersTable extends Migration
{


    public function down()
    {
        Schema::dropIfExists('speakers');
    }
}
