package;

import flixel.FlxG;
import flixel.FlxSprite;

class Gold extends FlxSprite
{
	public static final SCORE:Int = 400;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);

		acceleration.y = GRAVITY;

		loadGraphic(AssetPaths.gold__png, false, 8, 4);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(this, parent.blocks);
		if (FlxG.overlap(this, parent.player))
		{
			pickup();
		}
	}

	public function pickup()
	{
		parent.updateScore(SCORE);
		destroy();
	}
}
