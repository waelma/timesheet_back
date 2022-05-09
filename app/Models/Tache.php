<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tache extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'details',
        'dateDebut',
        'dateFin',
        'etat',
        'project_id',
    ];

    public function project()
    {
        return $this->belongsTo('app\Models\Project', 'project_id');
    }
}
