<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\BroadcastMessage;

class EmployeeNotification extends Notification
{
    use Queueable;
    public $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toArray($notifiable)
    {
        return [
            'id' => $this->data[0]->id,
            'email' => $this->data[0]->email,
            'firstName' => $this->data[0]->firstName,
            'lastName' => $this->data[0]->lastName,
            'photo' => $this->data[0]->photo,
            'content' => $this->data[0]->content,
        ];
    }
}
