package digging;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import flixel.util.FlxColor;

#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
	inline public static var WING_WIDTH = PlayState.WING_WIDTH;

	var scoreCounter:FlxBitmapText;
	var timeCounter:FlxBitmapText;

	public function new()
	{
		super();

		var wings:FlxSprite = new FlxSprite(0, 0);
		if (!FlxG.onMobile)
			wings.loadGraphic(Global.asset("assets/images/spr_wings_pc.png"), true, 480, 270);
		else
			wings.loadGraphic(Global.asset("assets/images/spr_wings_mobile.png"), true, 480, 270);
		wings.scrollFactor.set(0, 0);
		add(wings);

		var font = new ui.Font.NokiaFont16();
		// scoreCounter = new FlxText(8, 8, 0, "Score: 0", 16);
		scoreCounter = new FlxBitmapText(font);
		scoreCounter.text = "Score: 0";
		scoreCounter.x = WING_WIDTH + 8;
		scoreCounter.y = 8;
		scoreCounter.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		scoreCounter.scrollFactor.set(0, 0);
		// timeCounter = new FlxText(Global.width - 40, 8, 0, "300", 16);
		timeCounter = new FlxBitmapText(font);
		timeCounter.text = "300";
		timeCounter.x = Global.width - WING_WIDTH - timeCounter.width - 8;
		timeCounter.y = 8;
		timeCounter.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		timeCounter.scrollFactor.set(0, 0);

		add(scoreCounter);
		add(timeCounter);
	}

	public function updateFlicker()
	{
		if (!timeCounter.isFlickering())
		{
			timeCounter.flicker(0, 0.25);
			timeCounter.color = FlxColor.RED;
		}
	}

	public function updateHUD(score:Int, timeLeft:Int)
	{
		scoreCounter.text = "Score: " + score;
		timeCounter.text = Std.string(timeLeft);
	}
}
