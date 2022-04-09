<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class EmployesProjects extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('employes_projects', function (Blueprint $table) {
            $table->integer('project_id')->unsigned();
            $table->integer('user_id')->unsigned();

            $table->foreign('project_id')->references('id')->on('projects')->onDelete('cascade')->onUpdate('cascade');

            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade')->onUpdate('cascade');

            $table->primary(['project_id','user_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('employes_projects');
    }
}
