package therealpinkie.biplanes;

class Biplane {
    var x : Float;
    var y : Float;
    var velocity : Float;
    var angle : Float;
    var bullets : Array<Bullet>;
    var player : Player;

    public function new (player : Player) {
        this.bullets = [new Bullet(this), new Bullet(this)];
    }
}
