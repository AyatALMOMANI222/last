<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDinnerAttendeesInvoiceTable extends Migration
{
    public function up()
    {
        Schema::create('dinner_attendees_invoice', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key
            $table->decimal('price', 10, 2); // Price field
            $table->string('status'); // Status field
            $table->foreignId('dinner_attendees_id')->constrained()->onDelete('cascade'); // Foreign key referencing dinner_attendees table
            $table->timestamps(); // Created at and updated at timestamps
        });
    }

    public function down()
    {
        Schema::dropIfExists('dinner_attendees_invoice');
    }
}
