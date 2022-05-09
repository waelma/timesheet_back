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
});
Route::get('employe/getEmployes', 'App\Http\Controllers\EmployeController@getEmployes');

//ChefProjet routes
Route::middleware('auth:api')->group(function () {
    Route::post('chefProjet/createProject', 'App\Http\Controllers\ProjectController@createProject');
    Route::get('chefProjet/getChefProjects', 'App\Http\Controllers\ProjectController@getChefProjects');
});
