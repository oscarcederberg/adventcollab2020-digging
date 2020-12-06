package tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class Block extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 15;
		this.totalHits = 3;
		this.currentHits = this.totalHits;

		loadGraphic("assets/images/spr_block.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
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
}
