package therealpinkie.biplanes;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Bullet extends FlxSprite
{
	var lifetime:Float;
	var owner:Player;

	public function launch(owner:Player):Void
	{
		this.lifetime = 0;
		this.owner = owner;
		var position = owner.getMidpoint().addPoint(FlxAngle.rotatePoint(owner.frameWidth / 2, 0, 0, 0, owner.angle));
		this.x = position.x;
		this.y = position.y;
		this.angle = owner.angle;
		this.velocity = FlxAngle.rotatePoint(Constants.BULLET_SPEED, 0, 0, 0, this.angle);
	}

	override public function update():Void
	{
		super.update();
		this.lifetime += FlxG.elapsed;
		if (this.lifetime > Constants.BULLET_DURATION || !this.isOnScreen())
		{
			owner.updateAccuracy(false);
			kill();
		}
	}
}
