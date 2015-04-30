package therealpinkie.biplanes;

import flixel.FlxSprite;

class Biplane extends FlxSprite;
{
	var x : Float;
	var y : Float;
	var velocity : Float;
	var angle : Float;
	var bullets : Array<Bullet>;
	public var player : Player;

	public function new(player : Player) 
	{
		super();
		this.bullets = [new Bullet(this), new Bullet(this)];
	}
}
