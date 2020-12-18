package digging;

import digging.PlayState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

using flixel.util.FlxSpriteUtil;

class Enemy extends FlxSprite
{
	public static final SCORE:Int = 300;

	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 2;
	static final JUMP_SPEED:Float = PlayState.CELL_SIZE * 10;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	public var totalHits:Int;
	public var currentHits:Int;

	var sfx_hit_2:FlxSound;

	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(Global.state);
		this.facing = FlxObject.RIGHT;

		this.totalHits = 3;
		this.currentHits = this.totalHits;

		acceleration.y = GRAVITY;
		velocity.x = MOVE_SPEED;
		maxVelocity.x = MOVE_SPEED;
		maxVelocity.y = JUMP_SPEED;

		loadGraphic("assets/images/spr_enemy_gov.png", true, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		setSize(28, 32);
		centerOffsets();
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle", [0]);
		animation.add("walk", [1, 0], 4, true);
		animation.play("walk");

		sfx_hit_2 = FlxG.sound.load("assets/sounds/sfx_hit_2.wav");
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		super.update(elapsed);
	}

	function movement():Void
	{
		switch (facing)
		{
			case FlxObject.LEFT:
				if (this.isTouching(FlxObject.LEFT))
				{
					animation.play("idle");
					new FlxTimer().start(0.4, turn);
				}
			case FlxObject.RIGHT:
				if (this.isTouching(FlxObject.RIGHT))
				{
					animation.play("idle");
					new FlxTimer().start(0.4, turn);
				}
			default:
		}
	}

	public function hit(amount:Int):Void
	{
		if (!this.isFlickering())
		{
			this.currentHits -= amount;
			sfx_hit_2.play();

			if (this.currentHits <= 0)
			{
				parent.updateScore(SCORE);
				parent.enemiesKilled++;
				new ScoreText(this, SCORE);
				kill();
			}
			else
			{
				this.flicker(1);
				if (parent.player.x < x)
				{
					velocity.x = MOVE_SPEED;
					facing = FlxObject.RIGHT;
				}
				else
				{
					velocity.x = -MOVE_SPEED;
					facing = FlxObject.LEFT;
				}
			}
		}
	}

	function turn(flxtimer:FlxTimer)
	{
		animation.play("walk");
		if (facing == FlxObject.RIGHT)
		{
			velocity.x = -MOVE_SPEED;
			facing = FlxObject.LEFT;
		}
		else
		{
			velocity.x = MOVE_SPEED;
			facing = FlxObject.RIGHT;
		}
	}
}
