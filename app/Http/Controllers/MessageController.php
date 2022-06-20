<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Message;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Notification;
use App\Notifications\EmployeeNotification;

class MessageController extends Controller
{
    public function getMessages($id)
    {
        $messages = DB::select('select * from messages where (transmitter_id = ? and receiver_id=?) or (transmitter_id = ? and receiver_id=?) ', [Auth::id(), $id, $id, Auth::id()]);
        foreach ($messages as $msg) {
            $transmitter = DB::select('select id,firstName,lastName,email,photo from users where id=?', [$msg->transmitter_id])[0];
            $msg->transmitter = $transmitter;
        }
        return response()->json($messages, 200);
    }

    public function sendMessage($id, Request $request)
    {
        DB::insert('insert into messages (transmitter_id, receiver_id, message, date) values (?, ?, ?, ?)', [Auth::id(), $id, $request->message, $request->date]);
        event(new \App\Events\MessagesUpdate($id));
        $data = DB::select('select id,email,firstName,lastName,photo from users where id=?', [Auth::id()]);
        $data[0]->content = "sent you a message";
        Notification::send(User::where('id', $id)->get(), new EmployeeNotification($data));
        event(new \App\Events\NotificationEvent($id));
        return response()->json("Message send successfuly", 200);
    }
}
