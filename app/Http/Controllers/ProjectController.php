<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Project;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Employes_project;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ProjectController extends Controller
{
    public function CreateProject(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'title' => 'required',
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }
        $project = Project::create([
            'chefP_id' => Auth::id(),
            'name' => $request->title,
            'details' => $request->details,
            'dateDebut' => $request->dateDebut,
            'dateFin' => $request->dateFin,
        ]);
        foreach ($request->tags as $employe) {
            DB::insert('insert into employes_projects (project_id,user_id) values (?, ?)', [$project->id, $employe['id']]);
        }
        foreach ($request->backlog as $tache) {
            DB::insert('insert into taches (project_id,name) values (?, ?)', [$project->id, $tache]);
        }
        return response()->json($project, 201);
    }

    public function getProjects()
    {
        return response()->json(DB::select('select name,etat,id from projects where chefP_id=? or id in (select project_id from employes_projects where user_id=?)', [Auth::id(), Auth::id()]), 200);
    }

    public function participe($idP, $idU)
    {
        $participe = false;
        $projects = DB::select('select id from projects where chefP_id=? or id in (select project_id from employes_projects where user_id=?)', [$idU, $idU]);
        foreach ($projects as $project) {
            if ($project->id == $idP)
                return true;
        }
        return false;
    }

    public function getProject($id)
    {
        if ($this->participe($id, Auth::id())) {
            $project = Project::find($id);
            $project->chefP_id = DB::select('select id,firstName,lastName,email,photo from users where id=?', [$project->chefP_id])[0];
            $columns = ([
                [
                    "id" => 0,
                    "title" => "Backlog",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where project_id=? and etat=?', [$id, "todo"]),
                ],
                [
                    "id" => 1,
                    'title' => "Doing",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF, name title,details description,dateFin,etat state,project_id  from taches where project_id=? and etat=?', [$id, "inprogress"]),
                ],
                [
                    "id" => 2,
                    'title' => "Test",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where project_id=? and etat=?', [$id, "test"])
                ],
                [
                    "id" => 3,
                    'title' => "Finish",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where project_id=? and etat=?', [$id, "done"])
                ]
            ]);
            for ($i = 0; $i <= 3; $i++) {
                foreach ($columns[$i]['cards'] as $tache) {
                    $members = DB::select('select U.id,U.firstName,U.lastName,U.email,U.photo from users U, employes_taches E where E.tache_id=? and E.user_id=U.id', [$tache->id]);
                    $tache->members = $members;
                }
            }
            for ($i = 0; $i <= 3; $i++) {
                foreach ($columns[$i]['cards'] as $tache) {
                    $subtaches = DB::select('select id, name, verified from todos where tache_id=? ', [$tache->id]);
                    $tache->subTache = $subtaches;
                }
            }
            for ($i = 0; $i <= 3; $i++) {
                foreach ($columns[$i]['cards'] as $tache) {
                    $comments = DB::select('select comment, user_id from comments where tache_id=? ', [$tache->id]);
                    foreach ($comments as $comment) {
                        $comment->user = DB::select('select firstName,lastName,photo from users where id = ?', [$comment->user_id]);
                    }
                    $tache->comments = $comments;
                }
            }

            $i = 0;
            $project->columns = $columns;
            foreach ($project->employes_projects as $emp) {
                $emp = DB::select('select id,firstName,lastName,email,photo from users where id=?', [$emp->user_id])[0];
                $project->employes_projects[$i] = $emp;
                $i++;
            }
            return response()->json($project, 200);
        } else {
            return response()->json("Unauthorized", 401);
        }
    }

    public function deleteProject($id)
    {
        return response()->json(DB::delete('delete from projects where id = ?', [$id]), 204);
    }

    public function editTitle($id, Request $request)
    {
        return response()->json(DB::update('update projects set name = ? where id = ?', [$request->title, $id]), 201);
    }

    public function editDate($id, Request $request)
    {
        DB::update('update projects set dateDebut = ?  where id = ?', [$request->dateDebut,  $id]);
        DB::update('update projects set dateFin = ?  where id = ?', [$request->dateFin,  $id]);
        return response()->json("date changed", 201);
    }

    public function addMember(Request $request)
    {
        DB::insert('insert into employes_projects (project_id , user_id) values (?, ?)', [$request->project_id, $request->user_id]);
        return response()->json("Member added", 201);
    }

    public function removeMember(Request $request)
    {
        DB::delete('delete from employes_projects where user_id = ? and project_id=?', [$request->user_id, $request->project_id]);
        DB::delete('delete from employes_taches  where user_id = ? and
        tache_id in (select id from taches where project_id=?)', [$request->user_id, $request->project_id]);
        return response()->json("Member deleted", 204);
    }

    public function groupeMessage($id)
    {
        $messages = DB::select('select * from groupe_messages where project_id = ?', [$id]);
        foreach ($messages as $msg) {
            $user = DB::select('select U.id,U.firstName,U.lastName,U.email,U.photo from users U where id=?', [$msg->user_id]);
            $msg->user = $user;
        }
        return response()->json($messages, 200);
    }

    public function addGroupeMessage(Request $request)
    {
        DB::insert('insert into groupe_messages (message, date, project_id, user_id ) values (?, ?, ?, ?)', [$request->message, $request->date, $request->project_id, $request->user_id]);
        return response()->json(DB::select('select firstName, lastName, photo from users where id = ?', [$request->user_id])[0], 200);
    }
}
