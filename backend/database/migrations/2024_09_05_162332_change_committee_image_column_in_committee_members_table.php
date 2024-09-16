<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
        Schema::table('committee_members', function (Blueprint $table) {
            $table->string('committee_image')->nullable()->change();
        });
    }

   
    public function down(): void
    {
        Schema::table('committee_members', function (Blueprint $table) {
            $table->text('committee_image')->nullable()->change();
        });
    }
};
