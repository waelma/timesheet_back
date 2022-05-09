<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Project;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
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

    public function getChefProjects()
    {
        return response()->json(DB::select('select name,etat,id from projects where chefP_id=?', [Auth::id()]), 200);
    }
}
