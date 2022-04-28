<?php

namespace App\Http\Controllers;

use App\Models\User;
use \Firebase\JWT\JWT;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Notifications\NewAccountNotification;
use Illuminate\Support\Facades\Notification;

class AdminController extends Controller
{
    public function register()
    {
        // $input['password']=Hash::make('Azerty.123');
        // $input['email']='waelma1920@gmail.com';
        // $input['firstName']='-------';
        // $input['lastName']='-------';
        // $input['phone']='-------';
        // $input['speciality']='-------';
        // $input['role']=3;
        // $user=User::create($input);
        // $succes['token']=$user->createToken('123')->accessToken;
        // $succes['message']='regitred successfully';
        // return response()->json($succes,201);
    }

    public function login(Request $request)
    {
        if (Auth::guard('web')->attempt(['email' => $request->email, 'password' => $request->password])) {
            $user = Auth::user();
            if ($user->role == 3) {
                $succes['token'] = $user->createToken('123')->accessToken;
                $succes['name'] = 'admin';
                $succes['role'] = $user->role;
                return response()->json($succes, 200);
            } else {
                return response()->json('Unauthorised', 401);
            }
        } else {
            return response()->json('Unauthorised', 401);
        }
    }

    public function logout(Request $request)
    {
        $token = $request->header('Authorization');
        $token = substr($token, 7, strlen($token) - 7);
        $publicKey = file_get_contents(storage_path('oauth-public.key'));
        $token = JWT::decode($token, $publicKey, array('RS256'));
        DB::delete('delete from oauth_access_tokens where id = ?', [$token->jti]);
        return response()->json('deconnected successfuly', 200);
    }

    public function comptesToApprouve()
    {
        return response()->json(DB::select('select id,email,firstName,lastName,phone,photo,speciality,role,created_at from users where email_verified_at is null and role = 1'), 200);
    }

    public function approuverCompte($id, Request $request)
    {
        DB::update('update users set email_verified_at = ? , role = ? where id = ?', [date('Y-m-d H:i:s'), $request->role, $id]);
        event(new \App\Events\ApprouverCompte($id));
        return response()->json('approuved ', 201);
    }

    public function numberComptesToApprouve()
    {
        return response()->json(DB::select('select count(*) cp from users where email_verified_at is null and role<>3')[0]->cp, 200);
    }

    public function supprimerCompte($id)
    {
        DB::delete('delete from users where id = ?', [$id]);
        return response()->json('deleted successfuly', 200);
    }

    public function listComptes()
    {
        return response()->json(DB::select('select id,email,firstName,lastName,phone,photo,speciality,role,email_verified_at from users where (role <> 3) and (email_verified_at is not null)'), 200);
    }

    public function setRole($id, Request $request)
    {
        DB::update('update users set role = ? where id = ?', [$request->role, $id]);
        return response()->json('updated successfuly');
    }

    public function search(Request $request)
    {
        $request->search = "%" . $request->search . "%";
        return response()->json(DB::select('select firstName,lastName,email,email_verified_at,photo,phone,speciality,role from users where (UPPER(firstName) like UPPER(?) or UPPER(lastName) like UPPER(?) or UPPER(email) like UPPER(?)) and (role <> 3) and (email_verified_at is not null)', [$request->search, $request->search, $request->search]), 200);
    }

    public function test($id)
    {
        // $user=Auth::user();
        // Notification::send($user, new Likes($id));
        $users = User::where('role', 3)->get();
        $data = DB::select('select id,email,firstName,lastName,phone,photo,speciality,role,created_at from users where id=?', [Auth::id()]);
        // $user1->notify(new NewAccountNotification($data));
        Notification::send($users, new NewAccountNotification($data));
        // $user1->notify(((new Likes($id))->delay(now()->addMinutes(1))));
        // return response()->json($user1->unreadNotifications, 201);
        return response()->json($users, 201);
    }


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
