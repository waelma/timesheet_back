<?php

namespace App\Events;

use App\Events\UpdateFiles as EventsUpdateFiles;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Http\Controllers\TaskController;

class UpdateFiles
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $message;
    public $channel;

    public function __construct($id, $tache_id)
    {
        $cntroller = new TaskController();
        $this->message = $cntroller->getFiles($tache_id);
        $this->channel = 'channel' . strval($id);
    }

    public function broadcastOn()
    {
        return [$this->channel];
    }

    public function broadcastAs()
    {
        return 'updateFiles';
    }
}
