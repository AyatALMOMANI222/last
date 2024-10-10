<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDinnerSpeakerCompanionFeesTable extends Migration
{
    public function up()
    {
        Schema::create('dinner_speaker_companion_fees', function (Blueprint $table) {
            $table->id(); // Primary Key
            $table->foreignId('dinner_id') // Foreign Key linking to dinner_details table
                ->constrained('dinner_details')
                ->onDelete('cascade');
            $table->foreignId('speaker_id') // Foreign Key linking to speakers table
                ->constrained('speakers')
                ->onDelete('cascade');
            $table->decimal('companion_fee', 8, 2); // سعر المرافق
            $table->timestamps(); // Created and updated timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('dinner_speaker_companion_fees');
    }
}
