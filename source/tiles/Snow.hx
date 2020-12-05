package tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class Snow extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.totalHits = 1;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.spr_snow__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
