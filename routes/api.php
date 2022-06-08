<?php

use App\Http\Controllers\AdminController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});



//Admin routes
Route::get('admin/register', 'App\Http\Controllers\AdminController@register');
Route::post('admin/login', 'App\Http\Controllers\AdminController@login');

Route::middleware('auth:api')->group(function () {
    Route::delete('admin/logout', 'App\Http\Controllers\AdminController@logout');
    Route::get('admin/comptesToApprouve', 'App\Http\Controllers\AdminController@comptesToApprouve');
    Route::get('admin/numberComptesToApprouve', 'App\Http\Controllers\AdminController@numberComptesToApprouve');
    Route::put('admin/approuverCompte/{id}', 'App\Http\Controllers\AdminController@approuverCompte');
    Route::delete('admin/supprimerCompte/{id}', 'App\Http\Controllers\AdminController@supprimerCompte');
    Route::get('admin/listComptes', 'App\Http\Controllers\AdminController@listComptes');
    Route::put('admin/setRole/{id}', 'App\Http\Controllers\AdminController@setRole');
    Route::get('admin/search', 'App\Http\Controllers\AdminController@search');
    Route::get('admin/adminNotification', 'App\Http\Controllers\NotificationController@adminNotification');
    Route::get('admin/adminNotificationMarkAsRead', 'App\Http\Controllers\NotificationController@adminNotificationMarkAsRead');
});

//Employe routes
Route::post('login/google', 'App\Http\Controllers\EmployeController@registerOrLoginWithGoogle');

Route::get('employe/confirmAcc', 'App\Http\Controllers\EmployeController@confirmAcc');
Route::post('employe/register/{id}', 'App\Http\Controllers\EmployeController@register');
Route::post('employe/login', 'App\Http\Controllers\EmployeController@login');
Route::delete('employe/logout', 'App\Http\Controllers\EmployeController@logout');
Route::get('employe/forgetPwdMessage', 'App\Http\Controllers\EmployeController@forgetPwdMessage');
Route::put('employe/resetForgetPwd/{id}', 'App\Http\Controllers\EmployeController@resetForgetPwd');
Route::get('employe/resetForgetPwd/verifCode/{id}', 'App\Http\Controllers\EmployeController@verifCode');
Route::middleware('auth:api')->group(function () {
    Route::get('employe/CompteVerifier', 'App\Http\Controllers\EmployeController@CompteVerifier');
    Route::post('employe/updatePhoto', 'App\Http\Controllers\EmployeController@updatePhoto');
    Route::get('employe/userPhoto', 'App\Http\Controllers\EmployeController@userPhoto');
    Route::get('employe/userProfil', 'App\Http\Controllers\EmployeController@userProfil');
    Route::put('employe/updateProfil', 'App\Http\Controllers\EmployeController@updateProfil');
    Route::put('employe/updatePassword', 'App\Http\Controllers\EmployeController@updatePassword');
    Route::get('employe/getEmployeCalendar', 'App\Http\Controllers\EmployeController@getEmployeCalendar');
    //Project
    Route::get('project/groupeMessage/{id}', 'App\Http\Controllers\ProjectController@groupeMessage');
    Route::post('project/addGroupeMessage', 'App\Http\Controllers\ProjectController@addGroupeMessage');
    //Task
    Route::get('task/getTask/{id}', 'App\Http\Controllers\TaskController@getTask');
    Route::put('task/changeState/{id}', 'App\Http\Controllers\TaskController@changeState');
    Route::post('task/addComment', 'App\Http\Controllers\TaskController@addComment');
    //Message
    Route::get('Messages/getMessages/{id}', 'App\Http\Controllers\MessageController@getMessages');
    Route::post('Messages/sendMessage/{id}', 'App\Http\Controllers\MessageController@sendMessage');
});
Route::get('employe/getEmployes', 'App\Http\Controllers\EmployeController@getEmployes');
Route::get('employe/getUsers', 'App\Http\Controllers\EmployeController@getUsers');
//ChefProjet routes
Route::middleware('auth:api')->group(function () {
    Route::post('chefProjet/createProject', 'App\Http\Controllers\ProjectController@createProject');
    Route::get('chefProjet/getProjects', 'App\Http\Controllers\ProjectController@getProjects');
    Route::get('project/getProject/{id}', 'App\Http\Controllers\ProjectController@getProject');
    Route::delete('project/deleteProject/{id}', 'App\Http\Controllers\ProjectController@deleteProject');
    Route::post('project/removeMember', 'App\Http\Controllers\ProjectController@removeMember');
    Route::post('project/addMember', 'App\Http\Controllers\ProjectController@addMember');
    Route::put('project/editTitle/{id}', 'App\Http\Controllers\ProjectController@editTitle');
    Route::put('project/editDate/{id}', 'App\Http\Controllers\ProjectController@editDate');
    Route::post('task/createTask', 'App\Http\Controllers\TaskController@createTask');
    Route::delete(
        'task/removeTask/{id}',
        'App\Http\Controllers\TaskController@removeTask'
    );
    Route::post('task/addMember', 'App\Http\Controllers\TaskController@addMember');
    Route::post(
        'task/removeMember',
        'App\Http\Controllers\TaskController@removeMember'
    );
    Route::put('task/editTitle/{id}', 'App\Http\Controllers\TaskController@editTitle');
    Route::put('task/editDate/{id}', 'App\Http\Controllers\TaskController@editDate');
    Route::put('task/editDescription/{id}', 'App\Http\Controllers\TaskController@editDescription');
    Route::post('task/addTodo', 'App\Http\Controllers\TaskController@addTodo');
    Route::put('task/verifiedTodo/{id}', 'App\Http\Controllers\TaskController@verifiedTodo');
});
