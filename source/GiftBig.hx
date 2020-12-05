package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import tiles.BrickGift.GiftColors;

class GiftBig extends Pickup
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.spr_gift_big__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);

		setSize(20, 26);
		centerOffsets();
		offset.set(offset.x, 3);
	}
}
