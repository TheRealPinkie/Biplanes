package therealpinkie.biplanes;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Player extends FlxSprite 
{
	var numShots:Int;
	var numHits:Int;

	public function new(?x:Float = 0, ?y:Float = 0) 
	{
		numShots = 0;
		numHits = 0;
		super(x, y);
	}

	public function updateAccuracy(opponentHit:Bool):Void
	{
		this.numShots++;
		if (opponentHit)
			this.numHits++;
	}

	override public function update():Void
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			var b = cast(FlxG.state, PlayState).bullets.getFirstAvailable();
			if (b != null)
			{
				var bullet = cast(b, Bullet);
				bullet.reset(0, 0);
				bullet.launch(this);
			}
		}
		this.velocity = FlxAngle.rotatePoint(57, 0, 0, 0, this.angle);
		super.update();
	}
}
