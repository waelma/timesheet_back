<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Groupe_Message extends Model
{
    use HasFactory;
    protected $fillable = [
        'message',
        'date',
        'project_id ',
        'user_id '
    ];

    public function users()
    {
        return $this->belongsTo('app\Models\User', 'user_id');
    }
    public function projects()
    {
        return $this->belongsTo('app\Models\Project', 'project_id');
    }
}
