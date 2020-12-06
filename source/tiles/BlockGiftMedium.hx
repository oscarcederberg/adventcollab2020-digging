package tiles;

import flixel.math.FlxRandom;

class BlockGiftMedium extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 20;
		this.totalHits = 5;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.spr_block_gift_medium__png, true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);

		animation.add("hit_0", [0]);
		animation.add("hit_1", [1]);
		animation.add("hit_2", [2]);
		animation.play("hit_0");
	}

	override private function updateTexture():Void
	{
		if (this.currentHits == 4)
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
		parent.pickups.add(new GiftMedium(x, y - 8));
		super.breakblock();
	}
}