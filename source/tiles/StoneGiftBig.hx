package tiles;

import flixel.math.FlxRandom;
import haxe.macro.Expr.Case;

class StoneGiftBig extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 35;
		this.totalHits = 8;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.spr_stone_gift_big__png, true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);

		animation.add("hit_0", [0]);
		animation.add("hit_1", [1]);
		animation.add("hit_2", [2]);
		animation.play("hit_0");
	}

	override private function updateTexture():Void
	{
		if (this.currentHits == 5)
		{
			animation.play("hit_1");
		}
		else if (this.currentHits == 2)
		{
			animation.play("hit_2");
		}
	}

	override public function breakblock():Void
	{
		parent.add(new GiftBig(x, y - 4));
		super.breakblock();
	}
}
