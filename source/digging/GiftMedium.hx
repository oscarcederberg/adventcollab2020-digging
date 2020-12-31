package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import digging.tiles.BrickGift.GiftColors;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class GiftMedium extends Pickup
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 300;

		loadGraphic(Global.asset("assets/images/spr_gift_medium.png"), false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
