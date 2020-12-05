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
	var giftsText:FlxText;
	var blocksText:FlxText;
	var enemiesText:FlxText;
	var depthText:FlxText;
	var playButton:FlxButton;

	public function new(score:Int, giftsCollected:Int, blocksDestroyed:Int, enemiesKilled:Int, maxDepth:Int)
	{
		super();

		this.gameOverText = new FlxText(0, 6 * 512 / 32, 0, 32);
		this.gameOverText.text = "GAME OVER";
		this.gameOverText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.gameOverText.screenCenter(FlxAxes.X);

		this.scoreText = new FlxText(0, 9 * 512 / 32, 0, 16);
		this.scoreText.text = "Final Score: " + score;
		this.scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.scoreText.screenCenter(FlxAxes.X);

		this.giftsText = new FlxText(0, 10 * 512 / 32, 0, 16);
		this.giftsText.text = "Gifts Collected: " + giftsCollected;
		this.giftsText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.giftsText.screenCenter(FlxAxes.X);

		this.blocksText = new FlxText(0, 11 * 512 / 32, 0, 16);
		this.blocksText.text = "Blocks Destroyed: " + blocksDestroyed;
		this.blocksText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.blocksText.screenCenter(FlxAxes.X);

		this.enemiesText = new FlxText(0, 12 * 512 / 32, 0, 16);
		this.enemiesText.text = "Enemies Killed: " + enemiesKilled;
		this.enemiesText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.enemiesText.screenCenter(FlxAxes.X);

		this.depthText = new FlxText(0, 13 * 512 / 32, 0, 16);
		this.depthText.text = "Depth Dug: " + maxDepth + " meters";
		this.depthText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		this.depthText.screenCenter(FlxAxes.X);

		this.playButton = new FlxButton(0, 18 * 512 / 32, "Restart", clickRestart);
		this.playButton.screenCenter(FlxAxes.X);

		add(gameOverText);
		add(scoreText);
		add(giftsText);
		add(blocksText);
		add(enemiesText);
		add(depthText);
		add(playButton);
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
