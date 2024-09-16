<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExhibitionImagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exhibition_images', function (Blueprint $table) {
            $table->id();  // Primary key
            $table->unsignedBigInteger('exhibition_id'); // عمود الربط مع جدول المعارض
            $table->string('image'); // عمود الصورة
            $table->string('alt_text')->nullable();  // نص بديل للصورة
            $table->timestamp('uploaded_at')->nullable();  // تاريخ ووقت التحميل
            $table->timestamps(); // إضافة الأعمدة created_at و updated_at
            $table->foreign('exhibition_id')->references('id')->on('exhibitions')->onDelete('cascade');  
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('exhibition_images');
    }
}
