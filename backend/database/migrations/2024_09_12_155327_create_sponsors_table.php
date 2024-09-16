<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSponsorsTable extends Migration
{
    public function up()
    {
        Schema::create('sponsors', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // ربط الداعم أو العارض بالمستخدم
            $table->string('company_name'); // اسم الشركة
            $table->string('contact_person'); // الشخص المعني بالتواصل
            $table->string('company_address'); // عنوان الشركة
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('sponsors');
    }
}
