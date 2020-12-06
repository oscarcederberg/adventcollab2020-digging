package tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxCollision;

class Bedrock extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 0;
		this.totalHits = 999;
		this.currentHits = this.totalHits;

		loadGraphic("assets/images/spr_bedrock.png", false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}

	override public function hit(amount:Int):Void
	{
		// donothing
	}
}
