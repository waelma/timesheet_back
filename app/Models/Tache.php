<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Tache extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'verified',
        'dateDebut',
        'dateFin',
        'etat',
        'project_id',
    ];

    public function projects()
    {
        return $this->belongsTo('app\Models\Project', 'project_id');
    }
    public function employes_taches()
    {
        return $this->hasMany('App\Models\Employes_tache', 'tache_id');
    }
}
