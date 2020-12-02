package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 4;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var looking_at:Int;
	var jumping:Bool;
	var digging:Bool;
	var pickaxe:Pickaxe;
	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		this.pickaxe = new Pickaxe(x, y, this, 3, 4);
		parent.add(pickaxe);

		this.facing = FlxObject.RIGHT;
		this.looking_at = FlxObject.RIGHT;
		this.jumping = false;
		this.digging = false;
		drag.x = MOVE_SPEED * 8;
		acceleration.y = GRAVITY;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = JUMP_SPEED;

		loadGraphic(AssetPaths.spr_player__png, true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		setSize(26, 26);
		centerOffsets();
		offset.set(offset.x, 6);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle", [0]);
		animation.add("jump", [1]);
		animation.add("walk", [1, 0], 4, true);
		animation.add("dig", [2, 3, 4], 8, true);
		animation.play("idle");
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		var center_x = x + PlayState.CELL_SIZE / 2;
		var center_y = y + PlayState.CELL_SIZE / 2;

		switch (looking_at)
		{
			case FlxObject.UP:
				this.pickaxe.setPosition(center_x, center_y - PlayState.CELL_SIZE);
			case FlxObject.LEFT:
				this.pickaxe.setPosition(center_x - PlayState.CELL_SIZE, center_y);
			case FlxObject.DOWN:
				this.pickaxe.setPosition(center_x, center_y + PlayState.CELL_SIZE);
			case FlxObject.RIGHT:
				this.pickaxe.setPosition(center_x + PlayState.CELL_SIZE, center_y);
		}
		this.pickaxe.last.set(pickaxe.x, pickaxe.y);

		if (FlxG.overlap(this, parent.enemies) && !this.isFlickering())
		{
			parent.time.time -= 15;
			this.flicker(2);
		}

		animate();

		super.update(elapsed);

		FlxG.collide(this, parent.blocks);
		FlxG.collide(this, parent.bounds);
	}

	function movement():Void
	{
		var _up:Bool = FlxG.keys.anyPressed([UP, W,]);
		var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		var _action:Bool = FlxG.keys.anyPressed([X, J]);
		var _jump:Bool = FlxG.keys.anyJustPressed([C, K, SPACE]);

		velocity.x = 0;
		if (!digging)
		{
			if (_up && _down)
				_up = _down = false;
			if (_left && _right)
				_left = _right = false;

			if (_left)
			{
				facing = FlxObject.LEFT;
				looking_at = FlxObject.LEFT;
			}
			else if (_right)
			{
				facing = FlxObject.RIGHT;
				looking_at = FlxObject.RIGHT;
			}
			else if (_up)
				looking_at = FlxObject.UP;
			else if (_down)
				looking_at = FlxObject.DOWN;

			if (_left)
			{
				velocity.x = -MOVE_SPEED;
			}
			else if (_right)
			{
				velocity.x = MOVE_SPEED;
			}
		}
		if ((velocity.x > 0 && this.isTouching(FlxObject.RIGHT)) || (velocity.x < 0 && this.isTouching(FlxObject.LEFT)))
			velocity.x = 0;

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
				else if (FlxG.overlap(pickaxe, parent.enemies, function(object1, object2) cast(object2, Enemy).hit(cast(object1, Pickaxe).strength)))
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

	function animate()
	{
		var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

		if (!jumping && !digging)
		{
			if ((_left || _right) && !(_left && _right))
				animation.play("walk");
			else
				animation.play("idle");
		}
		else if (jumping || velocity.y != 0)
		{
			if (!this.isTouching(FlxObject.CEILING) && !this.isTouching(FlxObject.FLOOR))
				animation.play("jump");
		}
		else if (digging)
		{
			animation.play("dig");
		}
	}
}
