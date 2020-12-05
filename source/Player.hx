package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import tiles.*;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
	static final WIDTH:Int = 20;
	static final HEIGHT:Int = 26;
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 4;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var looking_at:Int;
	var jumping:Bool;
	var digging:Bool;
	var pickaxe:Pickaxe;
	var parent:PlayState;

	var sfx_step:FlxSound;
	var sfx_hit:FlxSound;
	var sfx_damage:FlxSound;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		this.pickaxe = new Pickaxe(x, y, this, 3, 1);
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
		setSize(WIDTH, HEIGHT);
		centerOffsets();
		offset.set(offset.x, 6);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle", [0]);
		animation.add("jump", [1]);
		animation.add("walk", [1, 0], 4, true);
		animation.add("dig_side", [2, 3, 4], 8, true);
		animation.add("dig_down", [5, 6, 7], 8, true);
		animation.add("dig_up", [8, 9, 10], 8, true);
		animation.play("idle");

		sfx_step = FlxG.sound.load(AssetPaths.sfx_step__wav);
		sfx_hit = FlxG.sound.load(AssetPaths.sfx_hit__wav);
		sfx_damage = FlxG.sound.load(AssetPaths.sfx_damage__wav);
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		var center_x = x + WIDTH / 2;
		var center_y = y + HEIGHT / 2;

		switch (looking_at)
		{
			case FlxObject.UP:
				this.pickaxe.setPosition(center_x, center_y - HEIGHT);
			case FlxObject.LEFT:
				this.pickaxe.setPosition(center_x - WIDTH, center_y);
			case FlxObject.DOWN:
				this.pickaxe.setPosition(center_x, center_y + HEIGHT);
			case FlxObject.RIGHT:
				this.pickaxe.setPosition(center_x + WIDTH, center_y);
		}
		this.pickaxe.last.set(pickaxe.x, pickaxe.y);

		if (FlxG.overlap(this, parent.enemies) && !this.isFlickering())
		{
			parent.time.time -= 15;
			this.flicker(2);
			sfx_damage.play();
		}

		animate();

		super.update(elapsed);

		FlxG.collide(this, parent.tiles);
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
			else
				looking_at = facing;

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
				if (FlxG.overlap(pickaxe, parent.tiles, function(object1, object2) cast(object2, Tile).hit(cast(object1, Pickaxe).strength)))
				{
					digging = true;
					new FlxTimer().start(1 / pickaxe.speed, function(timer) digging = false);
					sfx_hit.play();
				}
				else if (FlxG.overlap(pickaxe, parent.enemies, function(object1, object2) cast(object2, Enemy).hit(cast(object1, Pickaxe).strength)))
				{
					digging = true;
					new FlxTimer().start(1 / pickaxe.speed, function(timer) digging = false);
					sfx_hit.play();
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
			if (this.isTouching(FlxObject.FLOOR))
			{
				if ((_left || _right) && !(_left && _right))
				{
					animation.play("walk");
					sfx_step.play();
				}
				else
				{
					animation.play("idle");
					sfx_step.stop();
				}
			}
			else
			{
				animation.play("jump");
				sfx_step.stop();
			}
		}
		else if (jumping || velocity.y != 0)
		{
			sfx_step.stop();
			if (!this.isTouching(FlxObject.CEILING) && !this.isTouching(FlxObject.FLOOR))
				animation.play("jump");
		}
		else if (digging)
		{
			sfx_step.stop();
			switch (looking_at)
			{
				case FlxObject.UP:
					animation.play("dig_up");
				case FlxObject.DOWN:
					animation.play("dig_down");
				default:
					animation.play("dig_side");
			}
		}
	}
}
