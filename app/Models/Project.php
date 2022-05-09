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

    public function user()
    {
        return $this->belongsTo('app\Models\User', 'chefP_id');
    }
}
