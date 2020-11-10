package;

import flixel.util.FlxColor;

class BlockSnow extends Block
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.blocksnow__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}

	override function hit(amount:Int):Void {}

	override function breakblock():Void {}
}
