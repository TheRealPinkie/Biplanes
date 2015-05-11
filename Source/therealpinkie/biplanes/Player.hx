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
	var orientation:Int;

	public function new() 
	{
		this.state = dead;
		this.numHits = 0;
		this.numShots = 0;
		this.orientation = 1;
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
		if (this.orientation == -1)
			this.flipX = true;
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
				this.speed += 3.84 * FlxG.elapsed * Constants.ORIGINAL_FPS;
				if (this.speed > Constants.BIPLANE_MAX_SPEED)
				{
					this.y -= 3;
					this.speed = Constants.BIPLANE_MAX_SPEED;
					this.state = flying;
					this.accelerating = false;
				}
			case flying:
				if (this.speed > Constants.BIPLANE_MAX_SPEED)
					return;
				this.speed += Math.abs(Math.cos(this.angle)) * 1.92 * 
					FlxG.elapsed * Constants.ORIGINAL_FPS;
				if (this.speed > Constants.BIPLANE_MAX_SPEED)
					this.speed = Constants.BIPLANE_MAX_SPEED;
			default:
		}
	}

	override public function update():Void
	{
		if (this.accelerating)
			speedUp();
		switch this.state
		{
			case dead:
			case onEarth:
				if (FlxG.keys.justPressed.UP)
					speedUp();
				this.x += this.orientation * this.speed * 
							FlxG.elapsed * Constants.ORIGINAL_FPS;
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

				this.x += Math.cos(this.angle * Math.PI / 180) * this.speed *
							FlxG.elapsed * Constants.ORIGINAL_FPS;
				var gravityImpact:Float = 0;
				var verticalVelocityImpact:Float = 
					Math.cos(this.angle * Math.PI / 180) * this.speed;
				this.y += verticalVelocityImpact * FlxG.elapsed * Constants.ORIGINAL_FPS;
				if (Constants.BIPLANE_SINGLE_ROTATION_ANGLE < this.angle &&
						this.angle < 180 - Constants.BIPLANE_SINGLE_ROTATION_ANGLE)
				{
					this.speed += Math.sin(this.angle * Math.PI / 180) * 
						0.96 * Constants.ORIGINAL_FPS;
					if (this.speed > Constants.BIPLANE_MAX_FALLING_SPEED)
						this.speed = Constants.BIPLANE_MAX_FALLING_SPEED;
				}
				else if (180 + Constants.BIPLANE_SINGLE_ROTATION_ANGLE < this.angle &&
						this.angle < 360 - Constants.BIPLANE_SINGLE_ROTATION_ANGLE)
				{
					this.speed += Math.sin(this.angle * Math.PI / 180) * 
						0.96 * Constants.ORIGINAL_FPS;
					if (this.speed < 0)
						this.speed = 0;
				}
				if (this.speed < Constants.GRAVITY_IMPACT_THRESHOLD)
				{
					gravityImpact = Constants.BIPLANE_MAX_SPEED * 
						(Constants.GRAVITY_IMPACT_THRESHOLD - this.speed) / 
						Constants.GRAVITY_IMPACT_THRESHOLD;
					this.y += gravityImpact * FlxG.elapsed * Constants.ORIGINAL_FPS;
				}
				if (gravityImpact > verticalVelocityImpact)
					this.accelerating = false;
		}

		super.update();
	}
}
