package digging;

import digging.PlayState;
import ui.Controls;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxDirectionFlags;
import flixel.util.FlxTimer;
import digging.tiles.*;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{
	static final WIDTH:Int = 20;
	static final HEIGHT:Int = 26;
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 4;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var looking_at:FlxDirectionFlags;
	var jumping:Bool;
	var digging:Bool;
	var pickaxe:Pickaxe;
	var parent:PlayState;

	var sfx_step:FlxSound;
	var sfx_hit_1:FlxSound;
	var sfx_damage:FlxSound;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(Global.state);
		this.pickaxe = new Pickaxe(x, y, this, 3, 1);
		parent.add(pickaxe);

		this.facing = RIGHT;
		this.looking_at = RIGHT;
		this.jumping = false;
		this.digging = false;
		drag.x = MOVE_SPEED * 8;
		acceleration.y = GRAVITY;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = JUMP_SPEED;

		loadGraphic(Global.asset("assets/images/spr_player.png"), true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		setSize(WIDTH, HEIGHT);
		centerOffsets();
		offset.set(offset.x, 6);
		setFacingFlip(LEFT, true, false);
		setFacingFlip(RIGHT, false, false);
		animation.add("idle", [0]);
		animation.add("jump", [1]);
		animation.add("walk", [1, 0], 4, true);
		animation.add("look_down", [2]);
		animation.add("look_up", [3]);
		animation.add("dig_side", [4, 5, 6], 8, true);
		animation.add("dig_down", [7, 8, 9], 8, true);
		animation.add("dig_up", [10, 11, 12], 8, true);
		animation.play("idle");

		sfx_step = FlxG.sound.load(Global.asset("assets/sounds/sfx_step.mp3"));
		sfx_hit_1 = FlxG.sound.load(Global.asset("assets/sounds/sfx_hit_1.mp3"));
		sfx_damage = FlxG.sound.load(Global.asset("assets/sounds/sfx_damage.mp3"));
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		var center_x = x + WIDTH / 2;
		var center_y = y + HEIGHT / 2;

		switch (looking_at)
		{
			case UP:
				this.pickaxe.setPosition(center_x, center_y - HEIGHT);
			case LEFT:
				this.pickaxe.setPosition(center_x - WIDTH, center_y);
			case DOWN:
				this.pickaxe.setPosition(center_x, center_y + HEIGHT);
			case RIGHT:
				this.pickaxe.setPosition(center_x + WIDTH, center_y);
			case _://oops?
		}
		this.pickaxe.last.set(pickaxe.x, pickaxe.y);

		if (FlxG.overlap(this, parent.enemies) && !this.isFlickering())
		{
			parent.time.time -= 15;
			new HitText(this, 15);
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
		var _up:Bool = Controls.pressed.UP;
		var _down:Bool = Controls.pressed.DOWN;
		var _left:Bool = Controls.pressed.LEFT;
		var _right:Bool = Controls.pressed.RIGHT;

		var _action:Bool = Controls.pressed.A;
		var _jump:Bool = Controls.justPressed.B;

		velocity.x = 0;
		if (!digging)
		{
			if (_up && _down)
				_up = _down = false;
			if (_left && _right)
				_left = _right = false;

			if (_left)
			{
				facing = LEFT;
				looking_at = LEFT;
			}
			else if (_right)
			{
				facing = RIGHT;
				looking_at = RIGHT;
			}
			else if (_up)
				looking_at = UP;
			else if (_down)
				looking_at = DOWN;
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
		if ((velocity.x > 0 && this.isTouching(RIGHT)) || (velocity.x < 0 && this.isTouching(LEFT)))
			velocity.x = 0;

		if (this.isTouching(FLOOR))
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
					sfx_hit_1.play();
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

	// animate.... and play some sound hehe
	function animate()
	{
		var _up:Bool = Controls.pressed.UP;
		var _down:Bool = Controls.pressed.DOWN;
		var _left:Bool = Controls.pressed.LEFT;
		var _right:Bool = Controls.pressed.RIGHT;

		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;

		if (!jumping && !digging)
		{
			if (this.isTouching(FLOOR))
			{
				if (_left || _right)
				{
					animation.play("walk");
					sfx_step.play();
				}
				else if (_up)
				{
					animation.play("look_up");
				}
				else if (_down)
				{
					animation.play("look_down");
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
			if (!this.isTouching(CEILING) && !this.isTouching(FLOOR))
				animation.play("jump");
		}
		else if (digging)
		{
			sfx_step.stop();
			switch (looking_at)
			{
				case UP:
					animation.play("dig_up");
				case DOWN:
					animation.play("dig_down");
				default:
					animation.play("dig_side");
			}
		}
	}
}
