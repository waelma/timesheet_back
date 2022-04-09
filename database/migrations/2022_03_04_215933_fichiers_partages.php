<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class FichiersPartages extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('fichiers_partages', function (Blueprint $table) {
            $table->increments('id');
            $table->string('lien');
            $table->integer('tache_id')->unsigned();
            $table->timestamps();

            $table->foreign('tache_id')->references('id')->on('taches')->onDelete('cascade')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('fichiers_partages');
    }
}
