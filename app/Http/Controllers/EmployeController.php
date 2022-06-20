<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use \Firebase\JWT\JWT;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use App\Mail\ConfirmAcc;
use Exception;
use Nexmo\Laravel\Facade\Nexmo;
use Illuminate\Support\Facades\File;
use App\Models\ConfirmationCode;
use Laravel\Socialite\Facades\Socialite;
use App\Notifications\NewAccountNotification;
use Illuminate\Support\Facades\Notification;

class EmployeController extends Controller
{
    public function confirmAcc(Request $request)
    {
        if (DB::select('select count(*) x from users where email = ?', [$request->email])[0]->x != 0) {
            return response()->json("Email already used", 400);
        } else {
            $code = rand(100000, 1000000);
            if (DB::select('select count(*) cp from confirmation_codes where email = ?', [$request->email])[0]->cp == 0) {
                DB::insert('insert into confirmation_codes (code, email) values (?, ?)', [$code, $request->email]);
            } else {
                DB::update('update confirmation_codes set code = ? where email = ?', [$code, $request->email]);
            }
            $detail = [
                'code' => $code,
            ];
            Mail::to($request->email)->send(new ConfirmAcc($detail));
            return response()->json("a confirmation email has been sent... check your mail", 200);
        }
    }

    protected function registerOrLoginWithGoogle(Request $request)
    {
        $user = User::where('email', '=', $request->email)->first();
        if (!$user) {
            $user = new User();
            $user->firstName = $request->firstName;
            $user->email = $request->email;
            $user->lastName = $request->lastName;
            $user->photo = $request->photo;
            $user->save();
            $succes['token'] = $user->createToken('123')->accessToken;
            $succes['name'] = $user->firstName;
            $succes['message'] = 'success';
            $succes['user_id'] = $user->id;
            $succes['role'] = '1';
            $succes['email_verified_at'] = "null";
            $admins = User::where('role', 3)->get();
            $data = DB::select('select id,email,firstName,lastName,phone,photo,speciality,role,created_at from users where email=?', [$request->email]);
            Notification::send($admins, new NewAccountNotification($data));
            return response()->json($succes, 201);
        }
        $succes['token'] = $user->createToken('123')->accessToken;
        $succes['name'] = $user->firstName;
        $succes['message'] = 'success';
        $succes['user_id'] = $user->id;
        $succes['role'] = $user->role;
        $succes['email_verified_at'] = $user->email_verified_at;
        return response()->json($succes, 200);
    }


    public function register($code, Request $request)
    {
        if ($code == DB::select('select code from confirmation_codes where email = ?', [$request->email])[0]->code) {
            $validate = Validator::make($request->all(), [
                'firstName' => 'required',
                'phone' => 'required',
                'lastName' => 'required',
                'email' => 'required|email',
                // 'speciality' => 'required',
                'password' => 'required|min:8',
                'c_password' => 'required|same:password',
            ]);
            if ($validate->fails()) {
                return response()->json($validate->errors(), 400);
            }
            $input = $request->all();
            $input['password'] = Hash::make($input['password']);
            $user = User::create($input);
            $succes['token'] = $user->createToken('123')->accessToken;
            $succes['name'] = $user->firstName;
            $succes['user_id'] = $user->id;
            $succes['role'] = '1';
            $admins = User::where('role', 3)->get();
            $data = DB::select('select id,email,firstName,lastName,phone,photo,role,created_at from users where email=?', [$request->email]);
            Notification::send($admins, new NewAccountNotification($data));
            $succes['message'] = 'success';
            DB::delete('delete from confirmation_codes where email = ?', [$request->email]);
            return response()->json($succes, 201);
        } else {
            return response()->json("Invalide code", 401);
        }
    }

    public function CompteVerifier()
    {
        if (DB::select('select email_verified_at from users where id=?', [Auth::id()])[0]->email_verified_at) {
            return response()->json(true, 200);
        } else {
            return response()->json(false, 200);
        }
    }

    public function login(Request $request)
    {
        if (Auth::guard('web')->attempt(['email' => $request->email, 'password' => $request->password])) {
            $user = Auth::user();
            if ($user->role == 1 or $user->role == 2) {
                $succes['token'] = $user->createToken('123')->accessToken;
                $succes['role'] = $user->role;
                $succes['name'] = $user->firstName;
                $succes['user_id'] = $user->id;
                $succes['email_verified_at'] = $user->email_verified_at;
                return response()->json($succes, 200);
            } else {
                return response()->json('unauthorized', 401);
            }
        } else {
            return response()->json('unauthorized', 401);
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

    public function forgetPwdMessage(Request $request)
    {
        $code = rand(100000, 1000000);
        $validate = Validator::make($request->all(), [
            'email' => 'required|email'
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }
        $x = DB::select('select count(id) x from users where email = ?', [$request->email]);
        if ($x[0]->x) {
            $phone = DB::select('select phone from users where email = ?', [$request->email])[0]->phone;
            if (DB::select('select count(*) cp from confirmation_codes where phone = ?', [$phone])[0]->cp == 0) {
                DB::insert('insert into confirmation_codes (code, phone) values (?, ?)', [$code, $phone]);
            } else {
                DB::update('update confirmation_codes set code = ? where phone = ?', [$code, $phone]);
            }
            // Nexmo::message()->send([
            //     "to" => "+216" . strval($phone),
            //     "from" => "22207999",
            //     "text" => strval($code) . " est le code de réinitialisation de votre mot de passe Pointache"
            // ]);
            $success["message"] = "success";
            $phone = substr_replace($phone, "****", 3, 4);
            $success["phone"] = $phone;
            return response()->json($success, 200);
        } else {
            return response()->json("Vous navez pas un compte avec cet email", 200);
        }
    }

    public function verifCode($code, Request $request)
    {
        $phone = DB::select('select phone from users where email = ?', [$request->email])[0]->phone;
        if ($code == DB::select('select code from confirmation_codes where phone = ?', [$phone])[0]->code) {
            return response()->json("true", 200);
        }
        return response()->json("false", 200);;
    }

    public function resetForgetPwd($code, Request $request)
    {
        $phone = DB::select('select phone from users where email = ?', [$request->email])[0]->phone;
        if ($code == DB::select('select code from confirmation_codes where phone = ?', [$phone])[0]->code) {
            $validate = Validator::make($request->all(), [
                'password' => 'required|min:8',
                'c_password' => 'required|same:password',
            ]);
            if ($validate->fails()) {
                return response()->json($validate->errors(), 400);
            }
            DB::update('update users set password = ? where email = ?', [Hash::make($request->password), $request->email]);
            DB::delete('delete from confirmation_codes where phone = ?', [$phone]);
            Auth::guard('web')->attempt(['email' => $request->email, 'password' => $request->password]);
            $user = Auth::user();
            $succes['token'] = $user->createToken('123')->accessToken;
            $succes['role'] = $user->role;
            $succes['name'] = $user->firstName;
            $succes['message'] = "success";
            return response()->json($succes, 201);
        } else {
            $succes['message'] = "Invalide code";
            return response()->json($succes, 200);
        }
    }

    public function updatePhoto(Request $request)
    {
        $token = $request->header('Authorization');
        $token = substr($token, 7, strlen($token) - 7);
        $publicKey = file_get_contents(storage_path('oauth-public.key'));
        $token = JWT::decode($token, $publicKey, array('RS256'));
        $id = $token->sub;
        $input = $request->all();
        $validate = Validator::make($input, [
            'photo' => 'required|image'
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }
        $photo = $request->photo;
        $newPhoto = time() . $photo->getClientOriginalName();
        $photo->move('uploads/users', $newPhoto);
        $path = DB::select('select photo from users where id = ?', [$id]);
        DB::update(
            'update users set photo = ? where id = ?',
            ["http://localhost:8000/uploads/users/$newPhoto", $id]
        );
        if ($path[0]->photo != "http://localhost:8000/uploads/users/photParDefault.jpeg") {
            File::delete("uploads/users/" . substr($path[0]->photo, 36, strlen($path[0]->photo) - 36));
        }
        $succes["message"] = "succes";
        $succes["newPhote"] = $newPhoto;
        return response()->json($newPhoto, 201);
    }

    public function userPhoto()
    {
        $path = DB::select('select photo from users where id = ?', [Auth::id()]);
        // return response()->download(public_path($path[0]->photo), 'post image');
        return response()->json($path[0]->photo, 200);
    }

    public function userProfil(Request $request)
    {
        return response()->json(DB::select('select lastName,firstName,email,speciality,phone,photo from users where id = ?', [Auth::id()]), 200);
    }

    public function updateProfil(Request $request)
    {
        DB::update('update users set firstName = ?, lastName = ?, email = ? where id = ?', [$request->firstName, $request->lastName, $request->email, Auth::id()]);
        if (Validator::make($request->all(), ['speciality' => 'required']) and ($request->speciality != "")) {
            DB::update('update users set speciality = ? where id = ?', [$request->speciality, Auth::id()]);
        }
        if (Validator::make($request->all(), ['phone' => 'required']) and ($request->phone != "")) {
            DB::update('update users set phone = ? where id = ?', [$request->phone, Auth::id()]);
        }
        return response()->json(DB::select('select lastName,firstName,email,speciality,phone,photo from users where id = ?', [Auth::id()]), 201);
    }

    public function updatePassword(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'new_password' => 'required|min:8',
            'c_new_password' => 'required|same:new_password',
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }
        DB::update('update users set password = ? where id = ?', [Hash::make($request->new_password), Auth::id()]);
        $succes['message'] = "Changed successfuly";
        return response()->json($succes, 201);
    }

    public function getEmployes()
    {
        $employes = DB::select('select id,email,firstName,lastName,phone,photo from users where (role = 1) and (email_verified_at is not null)');
        $result = [];
        foreach ($employes as $employe) {
            array_push($result, [
                'value' => $employe->firstName . " " . $employe->lastName,
                'id' => $employe->id,
                'first' => $employe->firstName,
                'last' => $employe->lastName,
                'email' => $employe->email,
                'photo' => $employe->photo,
            ]);
        }
        return response()->json($result, 200);
    }

    public function getUsers()
    {
        $employes = DB::select('select id,email,firstName,lastName,phone,photo from users where (role <> 3) and (email_verified_at is not null)');
        return response()->json($employes, 200);
    }

    public function getEmployeCalendar()
    {
        $calendar = DB::select('select T.name, T.dateFin from taches T, employes_taches E where T.deleted_at is null and E.user_id = ? and E.tache_id=T.id ', [Auth::id()]);
        $t = ([]);
        for ($i = 1; $i <= 12; $i++) {
            $x = 100;
            $j = 0;
            foreach ($calendar as $cal) {
                if (intval(substr($cal->dateFin, 5, 2)) == $i) {
                    if (intval(substr($cal->dateFin, 8, 2)) != $x) $j = 0;
                    $t[$i][intval(substr($cal->dateFin, 8, 2))][$j] =  $cal->name;
                    $x = intval(substr($cal->dateFin, 8, 2));
                    $j++;
                }
            }
        }
        return response()->json(
            $t,
            200
        );
    }
}
