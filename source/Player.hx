package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(32, 32, FlxColor.BLUE);
	}
}
