package tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class Snow extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 5;
		this.totalHits = 1;
		this.currentHits = this.totalHits;

		loadGraphic("assets/images/spr_snow.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}
}
