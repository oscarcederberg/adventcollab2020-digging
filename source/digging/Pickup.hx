package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;

class Pickup extends FlxSprite
{
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;
	
	public var score(default, null):Int;
	
	var sfx_pickup:FlxSound;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 0;
		this.acceleration.y = GRAVITY;

		this.sfx_pickup = FlxG.sound.load("assets/sounds/sfx_pickup.mp3");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function pickup()
	{
		sfx_pickup.play();
		kill();
	}
}
