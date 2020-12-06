package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import tiles.BrickGift.GiftColors;

class Gift extends Pickup
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0, giftColor:GiftColors)
	{
		super(x, y);
		this.score = 100;

		if (giftColor == GiftColors.Random)
		{
			this.giftColor = new FlxRandom().getObject([
				GiftColors.Green,
				GiftColors.Purple,
				GiftColors.Black,
				GiftColors.Red,
				GiftColors.Blue
			]);
		}
		else
		{
			this.giftColor = giftColor;
		}

		switch (giftColor)
		{
			case Green:
				loadGraphic("assets/images/spr_gift_green.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Purple:
				loadGraphic("assets/images/spr_gift_purple.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Black:
				loadGraphic("assets/images/spr_gift_black.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Red:
				loadGraphic("assets/images/spr_gift_red.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Blue:
				loadGraphic("assets/images/spr_gift_blue.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			default:
				loadGraphic("assets/images/spr_gift_green.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		}
	}
}
