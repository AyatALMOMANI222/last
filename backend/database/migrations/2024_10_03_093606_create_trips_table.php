<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('trips', function (Blueprint $table) {
            $table->id();
            $table->enum('trip_type', ['private', 'group'])->notNullable();
            $table->string('name')->nullable();
            $table->text('description')->nullable();
            $table->string('additional_info')->nullable();
            $table->string('image_1')->nullable();
            $table->string('image_2')->nullable();
            $table->string('image_3')->nullable();
            $table->string('image_4')->nullable();
            $table->string('image_5')->nullable();
            $table->decimal('price_per_person', 10, 2)->nullable();
            $table->decimal('price_for_two', 10, 2)->nullable();
            $table->decimal('price_for_three_or_more', 10, 2)->nullable();

            // $table->decimal('transport_price', 8, 2)->nullable(); // سعر النقل
            // $table->decimal('breakfast_price', 8, 2)->nullable(); // سعر الفطور
            // $table->decimal('dinner_price', 8, 2)->nullable(); // سعر العشاء
            // $table->decimal('lunch_price', 8, 2)->nullable(); // سعر الغداء
            // $table->decimal('tour_guide_price', 8, 2)->nullable(); // سعر دليل سياحي
            // $table->decimal('entry_fees_price', 8, 2)->nullable(); // سعر دخولية الأماكن السياحية
            // $table->decimal('horse_ride_price', 8, 2)->nullable(); // سعر ركوب الحصان
            // $table->decimal('jeep_tour_price', 8, 2)->nullable(); // سعر جولة الجيب
            // $table->decimal('tent_accommodation_price', 10, 2)->nullable(); // سعر المبيت في خيمة
            // //  $table->text('accommodation_options')->nullable(); // خيارات الإقامة

            // // أسعار الفنادق حسب عدد النجوم
            // $table->decimal('hotel_price_one_star', 10, 2)->nullable(); // سعر فندق نجمة واحدة
            // $table->decimal('hotel_price_two_stars', 10, 2)->nullable(); // سعر فندق نجمتين
            // $table->decimal('hotel_price_three_stars', 10, 2)->nullable(); // سعر فندق ثلاث نجوم
            // $table->decimal('hotel_price_four_stars', 10, 2)->nullable(); // سعر فندق أربع نجوم
            // $table->decimal('hotel_price_five_stars', 10, 2)->nullable(); // سعر فندق خمس نجوم
            // $table->decimal('hotel_price_six_stars', 10, 2)->nullable(); // سعر فندق ست نجوم
            // $table->decimal('hotel_price_seven_stars', 10, 2)->nullable(); // سعر فندق سبع نجوم
            

            // الحقول الجديدة لخيارات الرحلة الجماعية
            // $table->boolean('is_group_active')->default(false);
            $table->json('available_dates')->nullable(); // تواريخ الرحلات المتاحة
            $table->string('location')->nullable(); // موقع الرحلة
            $table->integer('duration')->nullable(); // مدة الرحلة (بالساعات أو الأيام)
            $table->text('inclusions')->nullable(); // ما تشمل الرحلة
            $table->decimal('group_price_per_person', 10, 2); // سعر الرحلة للشخص الواحد
            $table->decimal('group_price_per_speaker', 10, 2)->nullable(); // سعر الرحلة للشخص المضاف في الرحلات الجماعية
            $table->string('trip_details'); // تفاصيل الرحلة
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('trips');
    }
};
