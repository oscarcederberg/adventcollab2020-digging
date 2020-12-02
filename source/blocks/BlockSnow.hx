package blocks;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class BlockSnow extends Block
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.totalHits = 10;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.spr_block__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
