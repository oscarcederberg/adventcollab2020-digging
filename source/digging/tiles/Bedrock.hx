package digging.tiles;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxCollision;

import ui.Controls;
#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class Bedrock extends Tile
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.score = 0;
		this.totalHits = 999;
		this.currentHits = this.totalHits;

		loadGraphic(Global.asset("assets/images/spr_bedrock.png"), false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}

	override public function hit(amount:Int):Void
	{
		// donothing
	}
}

class Konami extends FlxSprite
{
	public static var KEYS:Array<Action> = [UP, UP, DOWN, DOWN, LEFT, RIGHT, LEFT, RIGHT, B, A];

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		var today = Date.now();
		if (today.getMonth() == 11 && today.getDate() == 8)
		{
			loadGraphic(Global.asset("assets/images/spr_konami_bd.png"), true, 96, 128);
		}
		else
		{
			loadGraphic(Global.asset("assets/images/spr_konami.png"), true, 96, 128);
		}

		animation.add("konami", [0, 1, 2, 3], 10, true);
		animation.play("konami");

		FlxG.sound.play(Global.asset("assets/sounds/sfx_konami.mp3"));
	}

	static public function handleKeys(step:Int):Bool
	{
		if (step < 10)
		{
			return Controls.justPressed.check(KEYS[step]);
		}
		else
			return false;
	}
}
