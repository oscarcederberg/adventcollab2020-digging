package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;

class Pickup extends FlxSprite
{
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var score:Int;
	var parent:PlayState;
	var sfx_pickup:FlxSound;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 0;
		this.parent = cast(FlxG.state);
		this.acceleration.y = GRAVITY;

		this.sfx_pickup = FlxG.sound.load("assets/sounds/sfx_pickup.wav");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function pickup()
	{
		if (FlxG.pixelPerfectOverlap(this, parent.player))
		{
			sfx_pickup.play();
			parent.updateScore(score);
			parent.giftsCollected++;
			kill();
		}
	}
}
