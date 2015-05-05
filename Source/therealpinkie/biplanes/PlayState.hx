package therealpinkie.biplanes;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	var player:Player;
	public var bullets:FlxGroup;
	var timeToRotate:Float;

	override public function create():Void
	{
		player = new Player();
		player.loadGraphic("images/biplane.png");
		player.x = (FlxG.width - player.frameWidth) / 2;
		player.y = (FlxG.height - player.frameHeight) / 2;
		timeToRotate = 0;
		add(player);
		
		bullets = new FlxGroup(Constants.MAX_BULLETS);
		for (i in 0...Constants.MAX_BULLETS)
		{
			var b:Bullet;
			b = new Bullet();
			b.makeGraphic(3, 3);
			b.exists = false;
			bullets.add(b);
		}
		add(bullets);

		FlxG.mouse.visible = false;

		super.create();
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		timeToRotate += FlxG.elapsed;
		if (timeToRotate > 0.5)
		{
			timeToRotate = 0;
			player.angle += Constants.BIPLANE_SINGLE_ROTATION_ANGLE;
		}
		super.update();
	}
}
