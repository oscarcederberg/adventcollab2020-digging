package;

import flixel.FlxSprite;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import tiles.*;

class Pickaxe extends FlxSprite
{
	private var parent:Player;

	public var speed:Float;
	public var strength:Int;

	public function new(x:Float = 0, y:Float = 0, parent:Player, speed:Float, strength:Int)
	{
		super(x, y);
		this.parent = parent;
		this.speed = speed;
		this.strength = strength;

		makeGraphic(1, 1, FlxColor.TRANSPARENT);
	}
}
