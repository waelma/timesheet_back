<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Todo extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'verified',
        'tache_id ',

    ];

    public function taches()
    {
        return $this->belongsTo('app\Models\Tache', 'tache_id');
    }
}
