package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxBitmapText;

class HUD extends FlxTypedGroup<FlxSprite>
{
	inline public static var WING_WIDTH = PlayState.WING_WIDTH;

	var scoreCounter:FlxBitmapText;
	var timeCounter:FlxBitmapText;

	public function new()
	{
		super();

		var font = new ui.DigFont.DigNokiaFont16();
		// this.scoreCounter = new FlxText(8, 8, 0, "Score: 0", 16);
		this.scoreCounter = new FlxBitmapText(font);
		this.scoreCounter.text = "Score: 0";
		this.scoreCounter.x = WING_WIDTH + 8;
		this.scoreCounter.y = 8;
		this.scoreCounter.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		this.scoreCounter.scrollFactor.set(0, 0);
		// this.timeCounter = new FlxText(FlxG.width - 40, 8, 0, "300", 16);
		this.timeCounter = new FlxBitmapText(font);
		this.timeCounter.text = "300";
		this.timeCounter.x = FlxG.width - WING_WIDTH - this.timeCounter.width - 8;
		this.timeCounter.y = 8;
		this.timeCounter.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		this.timeCounter.scrollFactor.set(0, 0);

		add(scoreCounter);
		add(timeCounter);
	}

	public function updateHUD(score:Int, timeLeft:Int)
	{
		scoreCounter.text = "Score: " + score;
		timeCounter.text = Std.string(timeLeft);
	}
}
