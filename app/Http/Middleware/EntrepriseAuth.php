<?php

namespace App\Http\Middleware;

use Closure;
use \Firebase\JWT\JWT;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Services\PayUService\Exception;

class EntrepriseAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $token=$request->header('Authorization');
        $token=substr($token,7,strlen($token)-7);
        $publicKey = file_get_contents(storage_path('oauth-public.key'));
        try {
            $token=JWT::decode($token,$publicKey, array('RS256'));
          }catch (\Exception $e) {
                return response()->json('Unauthenticated',401);
        }
        $req=DB::select('select count(*) cp from oauth_access_tokens where id = ?', [$token->jti]);
        if($req[0]->cp){
            $request->attributes->add([
                'entrepriseId' => $token->sub,
                'token'=>$token->jti
            ]);
            return $next($request);
        }
        return response()->json('Unauthenticated',401);
    }



}
