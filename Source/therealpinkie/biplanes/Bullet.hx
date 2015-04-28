package therealpinkie.biplanes;

class Bullet {
    var x : Float;
    var y : Float;
    var angle : Float;
    var lifetime : Float;
    var owner : Biplane;
    var is_active : Bool;

    public function new (owner : Biplane) {
        this.owner = owner;
        this.is_active = false;
    }

    public function launch(x : Float, y : Float, angle : Float) {
        this.x = x;
        this.y = y;
        this.angle = angle;
        this.lifetime = 0.0;
        this.is_active = true;
    }

    public function destroy(opponent_hit : Bool) {
        this.is_active = false;
        this.owner.player.update_accuracy(opponent_hit);
    }

    // TODO: make a tick/update/whatever function
}
