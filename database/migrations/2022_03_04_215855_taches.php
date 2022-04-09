<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Taches extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('taches', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->longText('details');
            $table->date('dateDebut');
            $table->date('dateFin');
            $table->enum('etat',['todo','inprogress','test','done'])->default('todo');

            $table->integer('user_id')->unsigned();
            //si elle est une tache de projet cette column va recevoir 0

            $table->integer('project_id')->unsigned();
            //si elle est une tache personnelle cette column va recevoir 0

            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');

            $table->foreign('project_id')->references('id')->on('projects')->onDelete('cascade')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_taches');
    }
}
