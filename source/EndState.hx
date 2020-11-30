package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;

class EndState extends FlxState
{
	var gameOverText:FlxText;
	var scoreText:FlxText;
	var playButton:FlxButton;

	public function new(score:Int)
	{
		super();

		this.gameOverText = new FlxText(0, 1 * 512 / 6, 0, 16);
		this.gameOverText.text = "GAME OVER";
		this.gameOverText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.gameOverText.screenCenter(FlxAxes.X);

		this.scoreText = new FlxText(0, 2 * 512 / 6, 0, 16);
		this.scoreText.text = "Final Score: " + score;
		this.scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.scoreText.screenCenter(FlxAxes.X);

		this.playButton = new FlxButton(0, 0, "Restart", clickRestart);
		this.playButton.screenCenter();

		add(gameOverText);
		add(scoreText);
		add(playButton);
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
