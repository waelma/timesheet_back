<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    use HasFactory;
    protected $fillable = [
        'message',
        'date',
        'transmitter_id ',
        'receiver_id '
    ];

    public function transmitter()
    {
        return $this->belongsTo('app\Models\User', 'transmitter_id');
    }
    public function receiver()
    {
        return $this->belongsTo('app\Models\User', 'receiver_id');
    }
}
