<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\BroadcastMessage;

class NewAccountNotification extends Notification
{
    use Queueable;
    public $account;
    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($account)
    {
        $this->account = $account;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['database'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    // public function toMail($notifiable)
    // {
    //     return (new MailMessage)
    //                 ->line('The introduction to the notification.')
    //                 ->action('Notification Action', url('/'))
    //                 ->line('Thank you for using our application!');
    // }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        event(new \App\Events\AdminNotification([
            'id' => $this->account[0]->id,
            'email' => $this->account[0]->email,
            'firstName' => $this->account[0]->firstName,
            'lastName' => $this->account[0]->lastName,
            'phone' => $this->account[0]->phone,
            'photo' => $this->account[0]->photo,
            'speciality' => $this->account[0]->speciality,
            'role' => $this->account[0]->role,
            'created_at' => $this->account[0]->created_at
        ]));
        return [
            'id' => $this->account[0]->id,
            'email' => $this->account[0]->email,
            'firstName' => $this->account[0]->firstName,
            'lastName' => $this->account[0]->lastName,
            'phone' => $this->account[0]->phone,
            'photo' => $this->account[0]->photo,
            'speciality' => $this->account[0]->speciality,
            'role' => $this->account[0]->role,
            'created_at' => $this->account[0]->created_at
        ];
    }
}
