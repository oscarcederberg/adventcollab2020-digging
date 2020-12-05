package tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class BrickSurface extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.totalHits = 2;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.spr_brick_surface__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
