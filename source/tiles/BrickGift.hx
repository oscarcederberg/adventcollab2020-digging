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
				loadGraphic(AssetPaths.spr_brick_gift_green__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Purple:
				loadGraphic(AssetPaths.spr_brick_gift_purple__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Black:
				loadGraphic(AssetPaths.spr_brick_gift_black__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Red:
				loadGraphic(AssetPaths.spr_brick_gift_red__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Blue:
				loadGraphic(AssetPaths.spr_brick_gift_blue__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			default:
				loadGraphic(AssetPaths.spr_brick_gift_green__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		}
	}

	override public function breakblock():Void
	{
		parent.add(new Gift(x, y - 9, giftColor));
		destroy();
	}
}
