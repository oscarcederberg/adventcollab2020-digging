package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import tiles.BrickGift.GiftColors;

class GiftBig extends FlxSprite
{
	public static final SCORE:Int = 2000;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var parent:PlayState;

	var sfx_pickup:FlxSound;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		acceleration.y = GRAVITY;

		loadGraphic(AssetPaths.spr_gift_big__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);

		sfx_pickup = FlxG.sound.load(AssetPaths.sfx_pickup__wav);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(this, parent.tiles);
		if (FlxG.pixelPerfectOverlap(this, parent.player))
		{
			pickup();
		}
	}

	public function pickup()
	{
		sfx_pickup.play();
		parent.updateScore(SCORE);
		destroy();
	}
}
