package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import digging.tiles.BrickGift.GiftColors;

class GiftMedium extends Pickup
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 300;

		loadGraphic("assets/images/spr_gift_medium.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
