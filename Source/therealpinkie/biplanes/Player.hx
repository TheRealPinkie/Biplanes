package therealpinkie.biplanes;

class Player {
    var biplane : Biplane;
    var opponent : Player;
    var num_shots : Int;
    var num_hits : Int;

    public function new () {
        this.biplane = new Biplane(this);
    }

    public function update_accuracy(opponent_hit : Bool) {
        this.num_shots++;
        if (opponent_hit)
            this.num_hits++;
    }
}
