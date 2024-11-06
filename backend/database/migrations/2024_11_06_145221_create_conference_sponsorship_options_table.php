<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConferenceSponsorshipOptionsTable extends Migration
{
    public function up()
    {
        Schema::create('conference_sponsorship_options', function (Blueprint $table) {
            $table->id(); // المعرف الأساسي للجدول
            $table->foreignId('conference_id')->constrained()->onDelete('cascade'); // إضافة conference_id كـ foreign key يرتبط بجدول المؤتمرات، ويتم حذفه تلقائياً عند حذف المؤتمر
            $table->string('item'); // اسم العنصر
            $table->string('price'); // السعر
            $table->integer('max_sponsors'); // العدد الأقصى للرعاة
            $table->string('booth_size'); // حجم الكشك
            $table->string('booklet_ad')->nullable(); // الإعلان في الكتيب (يمكن أن يكون فارغًا)
            $table->string('website_ad')->nullable(); // الإعلان على الموقع (يمكن أن يكون فارغًا)
            $table->string('bags_inserts')->nullable(); // محتويات الحقائب (يمكن أن يكون فارغًا)
            $table->string('backdrop_logo')->nullable(); // شعار الخلفية (يمكن أن يكون فارغًا)
            $table->integer('non_residential_reg'); // عدد التسجيلات غير السكنية
            $table->integer('residential_reg'); // عدد التسجيلات السكنية
            $table->timestamps(); // لتتبع تاريخ الإنشاء والتحديث
        });
    }

    public function down()
    {
        Schema::dropIfExists('conference_sponsorship_options');
    }
}
