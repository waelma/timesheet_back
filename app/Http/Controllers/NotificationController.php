<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class NotificationController extends Controller
{
    // public function test($id)
    // {
    //     // $user=Auth::user();
    //     // Notification::send($user, new Likes($id));
    //     $users = User::where('role', 3)->get();
    //     $data = DB::select('select id,email,firstName,lastName,phone,photo,speciality,role,created_at from users where id=?', [Auth::id()]);
    //     // $user1->notify(new NewAccountNotification($data));
    //     Notification::send($users, new NewAccountNotification($data));
    //     // $user1->notify(((new Likes($id))->delay(now()->addMinutes(1))));
    //     // return response()->json($user1->unreadNotifications, 201);
    //     return response()->json($users, 201);
    // }

    public function adminNotification()
    {
        $user = User::where('id', Auth::id())->first();
        return response()->json($user->unreadNotifications, 201);
    }

    public function adminNotificationMarkAsRead()
    {
        $user = User::where('id', Auth::id())->first();
        $user->unreadNotifications->markAsRead();
        return response()->json($user->unreadNotifications, 201);
    }
}
