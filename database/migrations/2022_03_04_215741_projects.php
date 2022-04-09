<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Projects extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('projects', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->longText('details');
            $table->date('dateDebut');
            $table->date('dateFin');
            $table->enum('etat',['todo','inprogress','test','done'])->default('todo');
            $table->integer('chefP_id')->unsigned();
            $table->timestamps();

            $table->foreign('chefP_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('prjects');
    }
}
