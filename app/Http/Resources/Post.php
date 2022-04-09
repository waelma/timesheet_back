<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class Post extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        if(!empty($this->name)){
            return  [
                'id'=>$this->id,
                'title'=>$this->title,
                'detail'=>$this->detail,
                'price'=>$this->price,
                'photo'=>$this->photo,
                'categorie'=>$this->categorie,
                'city'=>$this->city,
                'slug'=>$this->slug,
                'name'=>$this->name,
                'created_at'=>$this->created_at,//->format('d/m/y'),
                'updated_at'=>$this->updated_at//->format('d/m/y')
        ];}
        else{
            return  [
                'id'=>$this->id,
                'title'=>$this->title,
                'detail'=>$this->detail,
                'price'=>$this->price,
                'photo'=>$this->photo,
                'categorie'=>$this->categorie,
                'city'=>$this->city,
                'slug'=>$this->slug,
                'created_at'=>$this->created_at,//->format('d/m/y'),
                'updated_at'=>$this->updated_at//->format('d/m/y')
            ];
        }
    }
}
