package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import tiles.BrickGift.GiftColors;

class GiftMedium extends Pickup
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 300;

		loadGraphic(AssetPaths.spr_gift_medium__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
