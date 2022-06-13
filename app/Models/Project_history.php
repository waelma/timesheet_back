<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Project_history extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'date',
        'project_id',
    ];

    public function projects()
    {
        return $this->belongsTo('app\Models\Project', 'project_id');
    }
}
