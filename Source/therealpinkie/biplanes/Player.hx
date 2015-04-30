package therealpinkie.biplanes;

import flixel.FlxSprite;

class Player extends FlxSprite 
{
	var biplane : Biplane;
	var opponent : Player;
	var num_shots : Int;
	var num_hits : Int;

	public function new() 
	{
		super();
		this.biplane = new Biplane(this);
	}

	public function update_accuracy(opponent_hit : Bool):Void
	{
		this.num_shots++;
		if (opponent_hit)
			this.num_hits++;
	}

	public override function update():Void
	{

	}
}
