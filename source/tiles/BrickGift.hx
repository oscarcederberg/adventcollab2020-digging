package tiles;

import flixel.math.FlxRandom;
import haxe.macro.Expr.Case;

enum GiftColors
{
	Random;
	Green;
	Purple;
	Black;
	Red;
	Blue;
}

class BrickGift extends Tile
{
	var giftColor:GiftColors;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 15;
		this.totalHits = 3;
		this.currentHits = this.totalHits;

		giftColor = new FlxRandom().getObject([
			GiftColors.Green,
			GiftColors.Purple,
			GiftColors.Black,
			GiftColors.Red,
			GiftColors.Blue
		]);

		switch (giftColor)
		{
			case Green:
				loadGraphic("assets/images/spr_brick_gift_green.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Purple:
				loadGraphic("assets/images/spr_brick_gift_purple.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Black:
				loadGraphic("assets/images/spr_brick_gift_black.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Red:
				loadGraphic("assets/images/spr_brick_gift_red.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Blue:
				loadGraphic("assets/images/spr_brick_gift_blue.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			default:
				loadGraphic("assets/images/spr_brick_gift_green.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		}

		animation.add("hit_0", [0]);
		animation.add("hit_1", [1]);
		animation.add("hit_2", [2]);
		animation.play("hit_0");
	}

	override private function updateTexture():Void
	{
		if (this.currentHits == 2)
		{
			animation.play("hit_1");
		}
		else if (this.currentHits == 1)
		{
			animation.play("hit_2");
		}
	}

	override public function breakblock():Void
	{
		parent.pickups.add(new Gift(x, y - 9, giftColor));
		super.breakblock();
	}
}
