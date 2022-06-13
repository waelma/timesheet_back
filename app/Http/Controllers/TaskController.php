<?php

namespace App\Http\Controllers;

use App\Models\Project;
use Illuminate\Http\Request;
use App\Models\Tache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Mockery\Undefined;

use function PHPSTORM_META\map;

class TaskController extends Controller
{
    public function createTask(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'name' => 'required',
            'dateDebut' => 'required',
            'dateFin' => 'required',
            'project_id' => 'required',
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }
        if (DB::select('select * from taches where project_id = ? and name= ?', [$request->project_id, $request->name])) {
            return response()->json("Name already exists ", 400);
        } else {
            $tache = Tache::create($request->all());
            if ($request->members) {
                foreach ($request->members as $member) {
                    DB::insert('insert into employes_taches (tache_id, user_id) values (?, ?)', [$tache->id, $member]);
                }
            }
            DB::insert('insert into project_historys (project_id,name,date) values (?, ?, ?)', [$request->project_id, "Create $request->name", date('Y-m-d H:i:s')]);
            return response()->json("Task created", 200);
        }
    }

    public function removeTask($id)
    {
        $tache = DB::select('select * from taches where id = ?', [$id]);
        DB::delete('delete from taches where id = ?', [$id]);
        DB::delete('delete from project_historys where (name = ? or name=?) and project_id=?', [$tache[0]->name . " completed", "Create " . $tache[0]->name, $tache[0]->project_id]);
        return response()->json("Task removed", 204);
    }

    public function changeState($id, Request $request)
    {
        $tache = DB::select('select * from taches where id = ?', [$id]);
        DB::update('update taches set etat =? where id = ?', [$request->state, $id]);
        if ($request->state == "done") {
            if (DB::select('select * from project_historys where name = ? and project_id=?', [$tache[0]->name . " completed", $tache[0]->project_id])) {
                DB::update('update project_historys set date =? where name = ? and project_id=?', [date('Y-m-d H:i:s'), $tache[0]->name . " completed", $tache[0]->project_id]);
            } else {
                DB::insert('insert into project_historys (project_id,name,date) values (?, ?, ?)', [$tache[0]->project_id, $tache[0]->name . " completed", date('Y-m-d H:i:s')]);
            }
        }
        if ($tache[0]->etat == "done") {
            DB::delete('delete from project_historys where name = ? and project_id=?', [$tache[0]->name . " completed", $tache[0]->project_id]);
        }
        $participants = DB::select('select user_id from employes_projects where project_id = ?', [$tache[0]->project_id]);
        foreach ($participants as $participant) {
            if ($request->user_id != $participant->user_id)
                event(new \App\Events\ProjectUpdate($participant->user_id));
        }
        $chefP_id = DB::select('select chefP_id from projects where id = ?', [$tache[0]->project_id])[0]->chefP_id;
        if ($request->user_id != $chefP_id) {
            event(new \App\Events\ProjectUpdate($chefP_id));
        }
        return response()->json("state changed", 200);
    }

    public function getTask($id)
    {
        return response()->json(DB::select('select * from taches where id = ?', [$id])[0], 200);
    }

    public function addMember(Request $request)
    {
        return response()->json(DB::insert('insert into employes_taches (user_id, tache_id) values (?, ?)', [$request->user_id, $request->tache_id]), 201);
    }

    public function removeMember(Request $request)
    {
        return response()->json(DB::delete('delete from employes_taches where tache_id = ? and user_id=?', [$request->tache_id, $request->user_id]), 204);
    }

    public function editTitle($id, Request $request)
    {
        DB::update('update taches set name = ? where id = ?', [$request->title, $id]);;
        return response()->json("Title changed", 201);
    }

    public function editDate($id, Request $request)
    {
        DB::update('update taches set dateDebut = ?  where id = ?', [$request->dateDebut,  $id]);
        DB::update('update taches set dateFin = ?  where id = ?', [$request->dateFin,  $id]);
        return response()->json("date changed", 201);
    }

    public function editDescription($id, Request $request)
    {
        DB::update('update taches set details = ?  where id = ?', [$request->desc, $id]);
        return response()->json("Description changed", 201);
    }

    public function addTodo(Request $request)
    {
        DB::insert('insert into todos (name,verified,tache_id) values (?,?,?)', [$request->name, 0, $request->tache_id]);
        return response()->json("Todo added", 201);
    }

    public function verifiedTodo($id, Request $request)
    {
        DB::update('update todos set verified = ?  where tache_id = ? and name=?', [$request->verif, $request->tache_id, $request->name]);
        return response()->json("Todo verified", 201);
    }

    public function deleteTodo($id, Request $request)
    {
        DB::delete('delete from todos where tache_id = ? and name = ?', [$id, $request->name]);
        return response()->json("deleted successfully", 204);
    }

    public function addComment(Request $request)
    {
        DB::insert('insert into comments (comment,tache_id,user_id) values (?,?,?)', [$request->comment, $request->tache_id, $request->user_id]);
        $comments = DB::select('select * from comments where tache_id = ?', [$request->tache_id]);
        foreach ($comments as $comment) {
            $comment->user = DB::select('select firstName,lastName,photo from users where id = ?', [$comment->user_id]);
        }
        $project = DB::select('select project_id from taches where id = ?', [$request->tache_id])[0]->project_id;
        $participants = DB::select('select user_id from employes_projects where project_id = ?', [$project]);
        foreach ($participants as $participant) {
            if ($request->user_id != $participant->user_id)
                event(new \App\Events\CommentsUpdate($participant->user_id, $comments));
        }
        $chefP_id = DB::select('select chefP_id from projects where id = ?', [$project])[0]->chefP_id;
        if ($request->user_id != $chefP_id) {
            event(new \App\Events\CommentsUpdate($chefP_id, $comments));
        }
        return response()->json(DB::select('select firstName, lastName, photo from users where id = ?', [$request->user_id])[0], 201);
    }
}
