<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Http\Controllers\ProjectController;

class updateGroupeMessage implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    public $message;
    public $channel;
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($id, $project_id)
    {
        $cntroller = new ProjectController;
        $this->message = $cntroller->groupeMessage($project_id);
        $this->channel = 'channel' . strval($id);
    }

    public function broadcastOn()
    {
        return [$this->channel];
    }

    public function broadcastAs()
    {
        return 'updateGroupeMessage';
    }
}
