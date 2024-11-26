<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('sponsor_invoices', function (Blueprint $table) {
            // إضافة قيد فريد على عمود 'exhibit_number'
            $table->integer('exhibit_number')->nullable()->unique()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sponsor_invoices', function (Blueprint $table) {
            // إزالة قيد الفريد عن عمود 'exhibit_number'
            $table->integer('exhibit_number')->nullable()->change();
        });
    }
};
