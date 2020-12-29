package digging.tiles;

import flixel.math.FlxRandom;
import haxe.macro.Expr.Case;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

enum GiftColors
{
	Green;
	Purple;
	Black;
	Red;
	Blue;
	Random;
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

		var offset = giftColor.getIndex();

		loadGraphic(Global.asset("assets/images/spr_brick_gift.png"), true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);

		animation.add("hit_0", [offset * 3 + 0]);
		animation.add("hit_1", [offset * 3 + 1]);
		animation.add("hit_2", [offset * 3 + 2]);
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
