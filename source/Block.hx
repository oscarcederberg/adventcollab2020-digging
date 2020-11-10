package;

import flixel.FlxSprite;

class Block extends FlxSprite
{
	public var hits:Int;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		immovable = true;
	}

	public function hit(amount:Int):Void {}

	public function breakblock():Void {}
}
