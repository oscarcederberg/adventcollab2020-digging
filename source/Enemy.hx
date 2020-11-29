package;

import flixel.FlxG;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	static final MOVE_SPEED:Float = PlayState.CELL_SIZE * 2;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	public var totalHits:Int;
	public var currentHits:Int;

	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.parent = cast(FlxG.state);

		acceleration.y = GRAVITY;
		velocity.x = MOVE_SPEED;
		maxVelocity.x = MOVE_SPEED;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(this, parent.blocks);
		FlxG.collide(this, parent.bounds);
	}
}
