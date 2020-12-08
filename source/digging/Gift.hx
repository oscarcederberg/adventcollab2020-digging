package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import digging.tiles.BrickGift.GiftColors;

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

		var offset = this.giftColor.getIndex();

		loadGraphic("assets/images/spr_gift.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		animation.add("idle", [offset]);
		animation.play("idle");
	}
}