package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
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
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 4;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var looking_at:Direction;
	var jumping:Bool;
	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0, parent:PlayState)
	{
		super(x, y);
		this.parent = parent;

		this.looking_at = Direction.Right;
		this.jumping = false;
		drag.x = MOVE_SPEED * 8;
		acceleration.y = GRAVITY;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = JUMP_SPEED;
		makeGraphic(PlayState.CELL_SIZE, PlayState.CELL_SIZE, FlxColor.BLUE);
	}

	override public function update(elapsed:Float):Void
	{
		movement();
		super.update(elapsed);
		FlxG.collide(this, parent.blocks);
	}

	function movement():Void
	{
		var _up:Bool = FlxG.keys.anyPressed([UP, W,]);
		var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		var _action:Bool = FlxG.keys.anyPressed([X, J]);
		var _jump:Bool = FlxG.keys.anyPressed([C, K, SPACE]);

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

		velocity.x = 0;
		if (_left)
			velocity.x = -MOVE_SPEED;
		else if (_right)
			velocity.x = MOVE_SPEED;

		if (this.isTouching(FlxObject.FLOOR))
		{
			if (_jump)
			{
				jumping = true;
				velocity.y = -maxVelocity.y;
			}
			else
			{
				jumping = false;
			}
		}
	}
}
