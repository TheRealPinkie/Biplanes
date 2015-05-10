package therealpinkie.biplanes;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;
import Math;

enum PlayerState
{
	onEarth;
	flying;
	dead;
}

class Player extends FlxSprite 
{
	var state:PlayerState;
	var numShots:Int;
	var numHits:Int;
	var accelerating:Bool;
	var speed:Float;

	public function new() 
	{
		state = dead;
		numHits = 0;
		numShots = 0;
		super();
	}

	public function resetBiplane(?x:Float = 0, ?y:Float = 0):Void
	{
		this.x = x;
		this.y = y;
		this.angle = 0;
		state = onEarth;
		this.speed = 0;
		this.accelerating = false;
		loadGraphic("images/biplane.png");
	}

	public function updateAccuracy(opponentHit:Bool):Void
	{
		this.numShots++;
		if (opponentHit)
			this.numHits++;
	}

	public function speedUp():Void
	{
		this.accelerating = true;
		switch this.state
		{
			case onEarth:
				this.speed += 40 * FlxG.elapsed;
				if (this.speed >= 57)
				{
					this.speed = 57;
					this.accelerating = false;
					this.y -= 3;
					this.state = flying;
				}
			case flying:
				if (this.speed > 57)
					return;
				this.speed += Math.abs(Math.cos(this.angle) * 20 * FlxG.elapsed);
				if (this.speed > 57)
					this.speed = 57;
			default:
		}
		trace("current speed: " + this.speed);
	}

	override public function update():Void
	{
		if (this.accelerating)
			speedUp();
		switch this.state
		{
			case onEarth:
				if (FlxG.keys.justPressed.UP)
					speedUp();
			case flying:
				if (FlxG.keys.justPressed.UP)
					speedUp();
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

				var newAngle = this.angle;
				if (FlxG.keys.justPressed.LEFT)
					newAngle -= Constants.BIPLANE_SINGLE_ROTATION_ANGLE;
				if (FlxG.keys.justPressed.RIGHT)
					newAngle += Constants.BIPLANE_SINGLE_ROTATION_ANGLE;
				if (newAngle >= 360)
					newAngle -= 360;
				if (newAngle < 0)
					newAngle += 360;
				this.angle = newAngle;

				if (this.angle < 180)
				{
					this.speed += Math.sin(this.angle * Math.PI / 180) * 10 * FlxG.elapsed;
					if (this.speed > 77)
						this.speed = 77;
				}
				if (180 < this.angle)
				{
					this.speed += Math.sin(this.angle * Math.PI / 180) * 10 * FlxG.elapsed;
					if (this.speed < 0)
						this.speed = 0;
				}

				var gravityImpact:Float = 0;
				if (this.speed < 45)
				{
					gravityImpact = 57 * (50 - this.speed) / 50;
					this.y += gravityImpact * FlxG.elapsed;
				}
				if (gravityImpact > -Math.sin(this.angle * Math.PI / 180) * this.speed)
					this.accelerating = false;

			default:
		}
		this.velocity = FlxAngle.rotatePoint(this.speed, 0, 0, 0, this.angle);
		super.update();
	}
}
