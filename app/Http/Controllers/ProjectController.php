<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Project;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Tache;
use App\Models\Employes_project;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Carbon\Carbon;
use Facade\FlareClient\Http\Response;
use Illuminate\Support\Facades\Mail;
use App\Mail\ProjectParticipate;

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
            // $detail = [
            //     'projectTitle' => $request->title
            // ];
            // Mail::to(DB::select('select email from users where id = ?', [$employe['id']])[0]->email)->send(new ProjectParticipate($detail));
        }
        foreach ($request->backlog as $tache) {
            DB::insert('insert into taches (project_id,name) values (?, ?)', [$project->id, $tache]);
        }
        DB::insert('insert into project_historys (project_id,name,date) values (?, ?, ?)', [$project->id, "Create project", date('Y-m-d H:i:s')]);
        return response()->json($project, 201);
    }

    public function getProjects()
    {
        return response()->json(DB::select('select name,etat,id from projects where deleted_at is null and( chefP_id=? or id in (select project_id from employes_projects where user_id=?))', [Auth::id(), Auth::id()]), 200);
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
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where deleted_at is null and project_id=? and etat=?', [$id, "todo"]),
                ],
                [
                    "id" => 1,
                    'title' => "Doing",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF, name title,details description,dateFin,etat state,project_id  from taches where deleted_at is null and project_id=? and etat=?', [$id, "inprogress"]),
                ],
                [
                    "id" => 2,
                    'title' => "Test",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where deleted_at is null and project_id=? and etat=?', [$id, "test"])
                ],
                [
                    "id" => 3,
                    'title' => "Finish",
                    "cards" => DB::select('select id,dateDebut dateD,dateFin dateF,name title,details description,dateFin,etat state,project_id  from taches where deleted_at is null and project_id=? and etat=?', [$id, "done"])
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
            for ($i = 0; $i <= 3; $i++) {
                foreach ($columns[$i]['cards'] as $tache) {
                    $files = DB::select('select * from files where tache_id=? ', [$tache->id]);
                    for ($j = 0; $j < sizeof($files); $j++) {
                        $files[$j] = ([
                            "uid" => $files[$j]->id,
                            "url" => $files[$j]->url,
                            "name" => substr($files[$j]->url, 46, strlen($files[$j]->url) - 46),
                            "status" => "done",
                        ]);
                    }
                    $tache->files = $files;
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

    public function archiveProject($id)
    {
        return response()->json(DB::update('update projects set deleted_at = ? where id = ?', [date('Y-m-d H:i:s'), $id]), 204);
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
        Mail::to(DB::select('select email from users where id = ?', [$request->user_id])[0]->email)->send(new ProjectParticipate(DB::select('select name from projects where id = ?', [$request->project_id])[0]->name));
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
        $participants = DB::select('select user_id from employes_projects where project_id = ?', [$request->project_id]);
        foreach ($participants as $participant) {
            if ($request->user_id != $participant->user_id)
                event(new \App\Events\updateGroupeMessage($participant->user_id, $request->project_id));
        }
        $chefP_id = DB::select('select chefP_id from projects where id = ?', [$request->project_id])[0]->chefP_id;
        if ($request->user_id != $chefP_id) {
            event(new \App\Events\updateGroupeMessage($chefP_id, $request->project_id));
        }
        return response()->json(DB::select('select firstName, lastName, photo from users where id = ?', [$request->user_id])[0], 200);
    }

    public function getStatistcs($id)
    {
        $taches = DB::select('select * from taches where deleted_at is null and project_id = ?', [$id]);
        $total = 0;
        foreach ($taches as $tache) {
            $date1 = Carbon::parse(DB::select('select dateDebut from taches where id = ?', [$tache->id])[0]->dateDebut);
            $date2 = Carbon::parse(DB::select('select dateFin from taches where id = ?', [$tache->id])[0]->dateFin);
            $total += $date2->diffInDays($date1);
        }
        $consume = 0;
        foreach ($taches as $tache) {
            if ($tache->etat == "done") {
                $date1 = Carbon::parse(DB::select('select dateDebut from taches where id = ?', [$tache->id])[0]->dateDebut);
                $date2 = Carbon::parse(DB::select('select dateFin from taches where id = ?', [$tache->id])[0]->dateFin);
                $consume += $date2->diffInDays($date1);
            } else if ($tache->etat == "test") {
                $date1 = Carbon::parse(DB::select('select dateDebut from taches where id = ?', [$tache->id])[0]->dateDebut);
                $date2 = Carbon::parse(DB::select('select dateFin from taches where id = ?', [$tache->id])[0]->dateFin);
                $consume += $date2->diffInDays($date1) * 0.9;
            } else if ($tache->etat == "inprogress") {
                $todos = DB::select('select * from todos where tache_id = ?', [$tache->id]);
                if ($todos) {
                    foreach ($todos as $todo) {
                        if ($todo->verified == 1) {
                            $date1 = Carbon::parse(DB::select('select dateDebut from taches where id = ?', [$tache->id])[0]->dateDebut);
                            $date2 = Carbon::parse(DB::select('select dateFin from taches where id = ?', [$tache->id])[0]->dateFin);
                            $nbTodos = DB::select('select count(*) cp from todos where tache_id = ?', [$tache->id])[0]->cp;
                            $consume += $date2->diffInDays($date1) * (1 / $nbTodos) * 0.8;
                        }
                    }
                }
            }
        }
        if ($total) {
            $progress = $consume / $total;
        } else {
            $progress = 0;
        }

        $project = DB::select('select * from projects where id = ?', [$id]);
        $daysLeft = Carbon::parse($project[0]->dateFin)->diffInDays(Carbon::now());

        $advance = $progress - (Carbon::parse($project[0]->dateDebut)->diffInDays(Carbon::now()) / Carbon::parse($project[0]->dateDebut)->diffInDays($project[0]->dateFin));
        $estimatedDays = $daysLeft - (Carbon::parse($project[0]->dateDebut)->diffInDays($project[0]->dateFin) * $advance);
        $statistcs = ([
            "daysLeft" => $daysLeft,
            "daysLeftPercent" => ($daysLeft / Carbon::parse($project[0]->dateDebut)->diffInDays($project[0]->dateFin)) * 100,
            "progress" => $progress * 100,
            "advance" => $advance * 100,
            "estimatedDays" => $estimatedDays,
            "history" => DB::select('select * from project_historys where project_id = ? order by date', [$id])
        ]);
        return response()->json($statistcs, 200);
    }

    public static function setState($tache_id)
    {
        $done = true;
        $test = true;
        $todo = true;
        $project_id = Tache::where('id', $tache_id)->get()[0]->project_id;
        $taches = DB::select('select etat from taches where project_id = ? and deleted_at is null', [$project_id]);
        foreach ($taches as $tache) {
            if ($tache->etat != "done") {
                $done = false;
            }
            if ($tache->etat != "test") {
                $test = false;
            }
            if ($tache->etat != "todo") {
                $todo = false;
            }
        }
        if ($done) {
            DB::update('update projects set etat = ? where id = ?', ["done", $project_id]);
        } else if ($test) {
            DB::update('update projects set etat = ? where id = ?', ["test", $project_id]);
        } else if ($todo) {
            DB::update('update projects set etat = ? where id = ?', ["todo", $project_id]);
        } else {
            DB::update('update projects set etat = ? where id = ?', ["inprogress", $project_id]);
        }
        return true;
    }

    public function getArchiveProjects()
    {
        return response()->json(DB::select('select name,etat,id from projects where deleted_at is not null and chefP_id=?', [Auth::id()]), 200);
    }

    public function restoreProject($id)
    {
        DB::update('update projects set deleted_at = ?  where id = ?', [null, $id]);
        return response()->json(DB::select('select name,etat,id from projects where deleted_at is not null and chefP_id=?', [Auth::id()]), 200);
    }

    public function deleteProject($id)
    {
        DB::delete('delete from projects where id = ?', [$id]);
        return response()->json(DB::select('select name,etat,id from projects where deleted_at is not null and chefP_id=?', [Auth::id()]), 200);
    }
}
