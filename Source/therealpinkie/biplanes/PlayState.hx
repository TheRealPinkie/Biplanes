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

	override public function create():Void
	{
		player = new Player();
		add(player);
		player.resetBiplane();
		player.y = FlxG.camera.height - player.frameHeight;
		
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
		if (FlxG.keys.justPressed.R)
		{
			player.resetBiplane();
			player.y = FlxG.camera.height - player.frameHeight;
			for (bullet in bullets)
				bullet.kill();
		}

		super.update();
	}
}
