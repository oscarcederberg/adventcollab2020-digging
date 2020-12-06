package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
	var scoreCounter:FlxText;
	var timeCounter:FlxText;

	public function new()
	{
		super();
		this.scoreCounter = new FlxText(8, 8, 0, "Score: 0", 16);
		this.scoreCounter.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.scoreCounter.scrollFactor.set(0, 0);
		this.timeCounter = new FlxText(FlxG.width - 40, 8, 0, "300", 16);
		this.timeCounter.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.timeCounter.scrollFactor.set(0, 0);

		add(scoreCounter);
		add(timeCounter);
	}

	public function updateHUD(score:Int, timeLeft:Int)
	{
		if (timeLeft <= 60 && !timeCounter.isFlickering())
		{
			timeCounter.flicker(0, 0.25);
			timeCounter.color = FlxColor.RED;
		}
		scoreCounter.text = "Score: " + score;
		timeCounter.text = Std.string(timeLeft);
	}
}
