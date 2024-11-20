<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBoothCostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('booth_costs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('conference_id')->nullable()->constrained('conferences')->onDelete('cascade'); // إضافة عمود conference_id مع فرض علاقة مع جدول conferences
            $table->string('size', 10);
            $table->integer('cost');
            $table->integer('lunch_invitations');
            $table->integer('name_tags');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('booth_costs');
    }
}
