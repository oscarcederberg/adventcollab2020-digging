package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

enum Direction
{
	Up;
	Left;
	Down;
	Right;
}

class Player extends FlxSprite
{
	static final MOVE_SPEED:Float = 16;
	static final JUMP_SPEED:Float = 32;
	static final GRAVITY:Float = 32;

	var looking_at:Direction;
	var tiles:FlxTilemap;

	public function new(x:Float = 0, y:Float = 0, tiles:FlxTilemap)
	{
		super(x, y);
		this.tiles = tiles;

		this.looking_at = Direction.Right;
		drag.x = MOVE_SPEED * 8;
		acceleration.y = GRAVITY;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = 1.5 * JUMP_SPEED;
		makeGraphic(32, 32, FlxColor.BLUE);
	}

	override public function update(elapsed:Float):Void
	{
		movement();
		super.update(elapsed);
	}

	function movement():Void
	{
		var _up:Bool = FlxG.keys.anyPressed([UP, W,]);
		var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		var _action:Bool = FlxG.keys.anyPressed([X, J]);
		var _jump:Bool = FlxG.keys.anyJustPressed([C, K, SPACE]);

		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;

		if (_up)
			looking_at = Direction.Up;
		else if (_down)
			looking_at = Direction.Down;
		else if (_left)
			looking_at = Direction.Left;
		else if (_right)
			looking_at = Direction.Right;

		acceleration.x = 0;
		if (_left)
			acceleration.x = -drag.x;
		else if (_right)
			acceleration.x = drag.x;

		acceleration.y = GRAVITY;
		if (this.isTouching(FlxObject.FLOOR))
		{
			if (_jump)
				acceleration.y = -JUMP_SPEED;
			else
				acceleration.y = 0;
		}
	}
}
