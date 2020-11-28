package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

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
	var digging:Bool;
	var pickaxe:Pickaxe;
	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0, parent:PlayState)
	{
		super(x, y);
		this.pickaxe = new Pickaxe(x, y, this, 3, 4);
		parent.add(pickaxe);
		this.parent = parent;

		this.looking_at = Direction.Right;
		this.jumping = false;
		this.digging = false;
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

		velocity.x = 0;
		if (!digging)
		{
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

			if (_left)
				velocity.x = -MOVE_SPEED;
			else if (_right)
				velocity.x = MOVE_SPEED;
		}
		if ((velocity.x > 0 && this.isTouching(FlxObject.RIGHT)) || (velocity.x < 0 && this.isTouching(FlxObject.LEFT)))
			velocity.x = 0;

		var center_x = x + PlayState.CELL_SIZE / 2;
		var center_y = y + PlayState.CELL_SIZE / 2;

		switch (looking_at)
		{
			case Direction.Up:
				this.pickaxe.setPosition(center_x, center_y - PlayState.CELL_SIZE);
			case Direction.Left:
				this.pickaxe.setPosition(center_x - PlayState.CELL_SIZE, center_y);
			case Direction.Down:
				this.pickaxe.setPosition(center_x, center_y + PlayState.CELL_SIZE);
			case Direction.Right:
				this.pickaxe.setPosition(center_x + PlayState.CELL_SIZE, center_y);
		}
		this.pickaxe.last.set(pickaxe.x, pickaxe.y);

		if (this.isTouching(FlxObject.FLOOR))
		{
			if (_jump && !_action && !jumping && !digging)
			{
				jumping = true;
				velocity.y = -maxVelocity.y;
			}
			else if (_action && !_jump && !digging && !jumping)
			{
				if (FlxG.overlap(pickaxe, parent.blocks, function(object1, object2) cast(object2, Block).hit(cast(object1, Pickaxe).strength)))
				{
					digging = true;
					new FlxTimer().start(1 / pickaxe.speed, function(timer) digging = false);
				}
			}
			else
			{
				jumping = false;
			}
		}
	}
}
