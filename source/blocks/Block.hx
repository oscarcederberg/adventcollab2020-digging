package blocks;

import flixel.FlxG;
import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var totalHits:Int;
	public var currentHits:Int;

	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		immovable = true;
	}

	public function hit(amount:Int):Void
	{
		this.currentHits -= amount;
		if (this.currentHits <= 0)
		{
			breakblock();
		}
	}

	public function breakblock():Void
	{
		destroy();
	}
}
