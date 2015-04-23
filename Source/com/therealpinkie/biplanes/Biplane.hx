package com.therealpinkie.biplanes;

import com.therealpinkie.biplanes.Bullet;

class Biplane {
    var x : Float;
    var y : Float;
    var vel : Float;
    var angle : Float;
    var bullets : Array<Bullet> = [new Bullet(), new Bullet()];
    var opponent : Biplane;

    public function new () {

    }
}