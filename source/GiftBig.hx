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
		this.score = 600;

		loadGraphic("assets/images/spr_gift_big.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
