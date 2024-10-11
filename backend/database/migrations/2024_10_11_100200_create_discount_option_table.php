<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDiscountOptionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('discount_option', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key (id)
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // Foreign key referencing users(id)
            $table->foreignId('trip_id')->constrained('trips')->onDelete('cascade'); // Foreign key referencing trips(id)
            $table->foreignId('option_id')->constrained('additional_options')->onDelete('cascade'); // Foreign key referencing additional_options(id)
            $table->decimal('price', 10, 2); // Field for the price
            $table->boolean('show_price')->default(false); // Field to indicate if the price should be shown
            $table->timestamps(); // Created and updated timestamps
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('discount_option'); // Drop discount_option table
    }
}
