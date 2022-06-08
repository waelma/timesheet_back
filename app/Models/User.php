<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'firstName',
        'lastName',
        'phone',
        'speciality',
        'photo',
        'email',
        'password',
        'email_verified_at',
        'role'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
    public function projects()
    {
        return $this->hasMany('App\Models\Project', 'user_id');
    }
    public function employes_taches()
    {
        return $this->hasMany('App\Models\Employes_tache', 'user_id');
    }
    public function employes_projects()
    {
        return $this->hasMany('App\Models\Employes_project', 'user_id');
    }
}
