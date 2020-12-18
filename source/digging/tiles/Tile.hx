package digging.tiles;

import flixel.FlxG;
import flixel.FlxSprite;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class Tile extends FlxSprite
{
	public var score:Int;
	public var totalHits:Int;
	public var currentHits:Int;

	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 0;
		this.parent = cast(Global.state);
		immovable = true;
	}

	public function hit(amount:Int):Void
	{
		this.currentHits -= amount;
		updateTexture();
		if (this.currentHits <= 0)
		{
			breakblock();
		}
	}

	private function updateTexture():Void
	{
		// do nothing
	}

	public function breakblock():Void
	{
		parent.updateScore(score);
		parent.blocksDestroyed++;
		destroy();
	}
}
