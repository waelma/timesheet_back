<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'details',
        'dateDebut',
        'dateFin',
        'etat',
        'chefP_id',
    ];

    public function users()
    {
        return $this->belongsTo('app\Models\User', 'chefP_id');
    }
    public function taches()
    {
        return $this->hasMany('App\Models\Tache', 'project_id');
    }
    public function employes_projects()
    {
        return $this->hasMany('App\Models\Employes_project', 'project_id');
    }
}
