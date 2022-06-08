<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;
    protected $fillable = [
        'comment',
        'tache_id ',
        'user_id '
    ];

    public function users()
    {
        return $this->belongsTo('app\Models\User', 'user_id');
    }
    public function taches()
    {
        return $this->belongsTo('app\Models\Tache', 'tache_id');
    }
}
